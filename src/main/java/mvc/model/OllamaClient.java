package mvc.model;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;

import mvc.util.MiniJson;

public class OllamaClient {

	public static class OllamaResult {
		public final boolean ok;
		public final String reply;
		public final String errorCode; // null이면 성공

		private OllamaResult(boolean ok, String reply, String errorCode) {
			this.ok = ok;
			this.reply = reply;
			this.errorCode = errorCode;
		}

		static OllamaResult success(String reply) {
			return new OllamaResult(true, reply, null);
		}

		static OllamaResult failure(String errorCode, String reply) {
			return new OllamaResult(false, reply, errorCode);
		}
	}

	private final String baseUrl;
	private final String model;
	private final Duration timeout;

	public OllamaClient(String baseUrl, String model, Duration timeout) {
		this.baseUrl = (baseUrl == null ? "" : baseUrl).replaceAll("/+$", "");
		this.model = model;
		this.timeout = timeout;
	}

	public OllamaResult chat(List<Map<String, String>> messages) {
		if (baseUrl.isEmpty() || model == null || model.isEmpty()) {
			System.out.println("OllamaClient: baseUrl/model이 설정되지 않음 (WEB-INF/ollama.properties 확인)");
			return OllamaResult.failure("not_configured", "지금은 추천을 받을 수 없어요.");
		}

		String requestJson = buildRequestJson(messages);

		try {
			HttpClient client = HttpClient.newBuilder()
					.connectTimeout(timeout)
					.build();

			HttpRequest request = HttpRequest.newBuilder()
					.uri(URI.create(baseUrl + "/api/chat"))
					.timeout(timeout)
					.header("Content-Type", "application/json; charset=UTF-8")
					.POST(HttpRequest.BodyPublishers.ofString(requestJson, java.nio.charset.StandardCharsets.UTF_8))
					.build();

			HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

			if (response.statusCode() < 200 || response.statusCode() >= 300) {
				System.out.println("OllamaClient: HTTP " + response.statusCode() + " / body=" + response.body());
				return OllamaResult.failure("http_error", "지금은 추천을 받을 수 없어요.");
			}

			String content = parseReplyContent(response.body());
			if (content == null || content.trim().isEmpty()) {
				System.out.println("OllamaClient: 응답에서 message.content를 찾지 못함. body=" + response.body());
				return OllamaResult.failure("empty_reply", "지금은 추천을 받을 수 없어요.");
			}
			return OllamaResult.success(content.trim());

		} catch (java.net.ConnectException e) {
			System.out.println("OllamaClient: 연결 실패(ConnectException) - " + e.getMessage());
			return OllamaResult.failure("connection_refused", "지금은 추천을 받을 수 없어요.");
		} catch (java.net.http.HttpTimeoutException e) {
			System.out.println("OllamaClient: 타임아웃 - " + e.getMessage());
			return OllamaResult.failure("timeout", "지금은 추천을 받을 수 없어요.");
		} catch (Exception e) {
			System.out.println("OllamaClient: 알 수 없는 에러 - " + e);
			return OllamaResult.failure("unknown", "지금은 추천을 받을 수 없어요.");
		}
	}

	private String buildRequestJson(List<Map<String, String>> messages) {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"model\":\"").append(MiniJson.escape(model)).append("\",");
		sb.append("\"stream\":false,");
		sb.append("\"think\":false,");
		sb.append("\"keep_alive\":\"30m\",");
		sb.append("\"messages\":[");
		for (int i = 0; i < messages.size(); i++) {
			Map<String, String> m = messages.get(i);
			if (i > 0) sb.append(",");
			sb.append("{\"role\":\"").append(MiniJson.escape(m.get("role"))).append("\",");
			sb.append("\"content\":\"").append(MiniJson.escape(m.get("content"))).append("\"}");
		}
		sb.append("]}");
		return sb.toString();
	}

	@SuppressWarnings("unchecked")
	private String parseReplyContent(String responseBody) {
		Object parsed = MiniJson.parse(responseBody);
		if (!(parsed instanceof Map)) return null;
		Map<String, Object> root = (Map<String, Object>) parsed;
		Object messageObj = root.get("message");
		if (!(messageObj instanceof Map)) return null;
		Map<String, Object> message = (Map<String, Object>) messageObj;
		Object contentObj = message.get("content");
		return contentObj == null ? null : String.valueOf(contentObj);
	}
}
