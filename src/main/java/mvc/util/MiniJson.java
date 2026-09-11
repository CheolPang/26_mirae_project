package mvc.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 아주 작은 JSON 파서/이스케이프 유틸리티.
 *
 * 이 프로젝트(WEB-INF/lib)에는 Gson/Jackson 같은 JSON 라이브러리가 없어서,
 * AI 채팅 기능(AiChatController ↔ 브라우저, AiChatController ↔ Ollama)에 필요한
 * 최소한의 JSON 읽기/쓰기만 직접 구현한다.
 *
 * 지원 타입: object(Map), array(List), string, number(Double), boolean, null.
 * 표준 JSON 문법을 따르되, 이 프로젝트에서 주고받는 정도의 크기/형태만 다루면 되므로
 * 성능보다는 정확성과 단순함을 우선한다.
 */
public class MiniJson {

	// ------------------------------------------------------------------
	// 파싱 (문자열 -> Map/List/String/Double/Boolean/null)
	// ------------------------------------------------------------------
	public static Object parse(String json) {
		Parser p = new Parser(json);
		p.skipWhitespace();
		Object value = p.parseValue();
		p.skipWhitespace();
		return value;
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> parseObject(String json) {
		Object v = parse(json);
		if (v instanceof Map) {
			return (Map<String, Object>) v;
		}
		return new LinkedHashMap<String, Object>();
	}

	private static class Parser {
		private final String s;
		private int i;

		Parser(String s) {
			this.s = s == null ? "" : s;
			this.i = 0;
		}

		void skipWhitespace() {
			while (i < s.length() && Character.isWhitespace(s.charAt(i))) {
				i++;
			}
		}

		Object parseValue() {
			skipWhitespace();
			if (i >= s.length()) {
				return null;
			}
			char c = s.charAt(i);
			if (c == '{') return parseObjectValue();
			if (c == '[') return parseArrayValue();
			if (c == '"') return parseStringValue();
			if (c == 't' || c == 'f') return parseBooleanValue();
			if (c == 'n') { i += 4; return null; } // "null"
			return parseNumberValue();
		}

		Map<String, Object> parseObjectValue() {
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			i++; // '{'
			skipWhitespace();
			if (i < s.length() && s.charAt(i) == '}') {
				i++;
				return map;
			}
			while (true) {
				skipWhitespace();
				String key = parseStringValue();
				skipWhitespace();
				if (i < s.length() && s.charAt(i) == ':') i++;
				Object value = parseValue();
				map.put(key, value);
				skipWhitespace();
				if (i < s.length() && s.charAt(i) == ',') {
					i++;
					continue;
				}
				if (i < s.length() && s.charAt(i) == '}') {
					i++;
				}
				break;
			}
			return map;
		}

		List<Object> parseArrayValue() {
			List<Object> list = new ArrayList<Object>();
			i++; // '['
			skipWhitespace();
			if (i < s.length() && s.charAt(i) == ']') {
				i++;
				return list;
			}
			while (true) {
				Object value = parseValue();
				list.add(value);
				skipWhitespace();
				if (i < s.length() && s.charAt(i) == ',') {
					i++;
					continue;
				}
				if (i < s.length() && s.charAt(i) == ']') {
					i++;
				}
				break;
			}
			return list;
		}

		String parseStringValue() {
			StringBuilder sb = new StringBuilder();
			if (i >= s.length() || s.charAt(i) != '"') {
				return "";
			}
			i++; // opening quote
			while (i < s.length()) {
				char c = s.charAt(i);
				if (c == '"') {
					i++;
					break;
				}
				if (c == '\\' && i + 1 < s.length()) {
					char next = s.charAt(i + 1);
					switch (next) {
						case '"': sb.append('"'); break;
						case '\\': sb.append('\\'); break;
						case '/': sb.append('/'); break;
						case 'n': sb.append('\n'); break;
						case 't': sb.append('\t'); break;
						case 'r': sb.append('\r'); break;
						case 'b': sb.append('\b'); break;
						case 'f': sb.append('\f'); break;
						case 'u':
							if (i + 5 < s.length()) {
								String hex = s.substring(i + 2, i + 6);
								try {
									sb.append((char) Integer.parseInt(hex, 16));
								} catch (NumberFormatException ignore) {
									// 잘못된 \\u 시퀀스는 무시
								}
								i += 4;
							}
							break;
						default:
							sb.append(next);
					}
					i += 2;
				} else {
					sb.append(c);
					i++;
				}
			}
			return sb.toString();
		}

		Boolean parseBooleanValue() {
			if (s.startsWith("true", i)) {
				i += 4;
				return Boolean.TRUE;
			}
			if (s.startsWith("false", i)) {
				i += 5;
				return Boolean.FALSE;
			}
			return Boolean.FALSE;
		}

		Double parseNumberValue() {
			int start = i;
			while (i < s.length() && "-+.0123456789eE".indexOf(s.charAt(i)) >= 0) {
				i++;
			}
			String numStr = s.substring(start, i);
			try {
				return Double.parseDouble(numStr);
			} catch (NumberFormatException e) {
				return 0.0;
			}
		}
	}

	// ------------------------------------------------------------------
	// 이스케이프 (JSON 문자열 리터럴로 안전하게 쓰기 위한 용도)
	// ------------------------------------------------------------------
	public static String escape(String value) {
		if (value == null) {
			return "";
		}
		StringBuilder sb = new StringBuilder(value.length() + 16);
		for (int idx = 0; idx < value.length(); idx++) {
			char c = value.charAt(idx);
			switch (c) {
				case '"': sb.append("\\\""); break;
				case '\\': sb.append("\\\\"); break;
				case '\n': sb.append("\\n"); break;
				case '\r': sb.append("\\r"); break;
				case '\t': sb.append("\\t"); break;
				default:
					if (c < 0x20) {
						sb.append(String.format("\\u%04x", (int) c));
					} else {
						sb.append(c);
					}
			}
		}
		return sb.toString();
	}

	public static String getString(Map<String, Object> map, String key, String defaultValue) {
		if (map == null) return defaultValue;
		Object v = map.get(key);
		return v == null ? defaultValue : String.valueOf(v);
	}
}
