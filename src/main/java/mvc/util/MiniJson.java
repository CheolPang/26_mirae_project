package mvc.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MiniJson {

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
