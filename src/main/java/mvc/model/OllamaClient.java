package mvc.model;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;

import mvc.util.MiniJson;

/**
 * Ollama의 /api/chat 엔드포인트를 호출하는 아주 작은 클라이언트.
 *
 * /api/generate 대신 /api/chat을 쓰는 이유: 이 기능은 "자유 채팅형"으로 최근 대화
 * 턴(role=user/assistant)을 이어서 보내야 하는데, /api/chat은 messages 배열(role +
 * content)을 그대로 받아 그 형태와 정확히 맞아떨어진다. /api/generate로 하려면
 * system/history/product-list를 매번 하나의 긴 문자열로 직접 이어붙여야 해서
 * 번거롭고 실수하기 쉽다.
 *
 * 통신은 표준 JDK의 java.net.http.HttpClient를 쓴다(JDK 11+ 표준, 이 프로젝트는
 * JDK 17로 컴파일/JDK 21 런타임이라 별도 라이브러리 없이 바로 쓸 수 있다).
 */
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
		// 끝에 슬래시가 있어도/없어도 동작하도록 정리
		this.baseUrl = (baseUrl == null ? "" : baseUrl).replaceAll("/+$", "");
		this.model = model;
		this.timeout = timeout;
	}

	/**
	 * messages: [{"role":"system"|"user"|"assistant", "content":"..."}, ...] 순서대로.
	 */
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
			// Ollama 주소에 아무것도 떠 있지 않을 때(placeholder 주소 등)
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
		// qwen3처럼 "thinking" 기능이 있는 모델은 기본적으로 답하기 전에 긴 추론 과정을
		// 거치는데, 이게 몇십 초씩 걸려 아래 OLLAMA_TIMEOUT(18초)을 거의 항상 넘겨버린다.
		// think:false로 꺼서 바로 답만 받는다. (이 필드는 thinking을 지원하지 않는
		// 모델에서는 그냥 무시되므로 다른 모델에 영향 없음)
		sb.append("\"think\":false,");
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
