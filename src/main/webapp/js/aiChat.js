// CPShop AI 상품 추천 챗봇 위젯 (aiChatWidget.jsp에서 로드)
// - 화면 우하단 고정 버튼을 눌러 채팅 패널을 토글한다.
// - 대화 기록은 새로고침 시 사라져도 되는 요구사항이라 JS 배열(메모리)에만 보관한다.
// - 서버에 매 메시지마다 최근 대화 기록을 같이 보내서(멀티턴 컨텍스트) Ollama가
//   맥락을 이어갈 수 있게 한다.
// - 사용자가 입력한 텍스트와 AI가 응답한 텍스트는 모두 textContent로만 DOM에 넣는다.
//   (innerHTML을 쓰지 않음 -> LLM 응답에 HTML/스크립트가 섞여 와도 실행되지 않는다)
(function () {
	"use strict";

	var root = document.getElementById("aiChatRoot");
	if (!root) return;

	var isLoggedIn = root.getAttribute("data-logged-in") === "true";
	var actionUrl = root.getAttribute("data-action-url");

	var toggleBtn = document.getElementById("aiChatToggleBtn");
	var panel = document.getElementById("aiChatPanel");
	var closeBtn = document.getElementById("aiChatCloseBtn");
	var messagesEl = document.getElementById("aiChatMessages");
	var input = document.getElementById("aiChatInput");
	var sendBtn = document.getElementById("aiChatSendBtn");

	// 화면에 보여줄 용도가 아니라 서버로 보낼 최근 대화 기록 (role/content만)
	var history = [];
	var sending = false;
	var greeted = false;

	function addBubble(role, text) {
		var bubble = document.createElement("div");
		bubble.className = "ai-chat-bubble ai-chat-bubble-" + role;
		bubble.textContent = text; // XSS 방지: 항상 textContent 사용
		messagesEl.appendChild(bubble);
		messagesEl.scrollTop = messagesEl.scrollHeight;
	}

	function openPanel() {
		panel.hidden = false;
		if (!greeted) {
			greeted = true;
			if (!isLoggedIn) {
				addBubble("assistant", "로그인 후 이용 가능한 기능입니다.");
			} else {
				addBubble("assistant", "안녕하세요! 찾으시는 가구가 있으면 편하게 물어보세요.");
			}
		}
		if (isLoggedIn) {
			input.focus();
		}
	}

	function closePanel() {
		panel.hidden = true;
	}

	toggleBtn.addEventListener("click", function () {
		if (panel.hidden) {
			openPanel();
		} else {
			closePanel();
		}
	});
	closeBtn.addEventListener("click", closePanel);

	function sendMessage() {
		if (!isLoggedIn) {
			addBubble("assistant", "로그인 후 이용 가능한 기능입니다.");
			return;
		}

		var text = input.value.trim();
		if (!text || sending) return;

		addBubble("user", text);
		input.value = "";
		sending = true;
		sendBtn.disabled = true;

		var typingBubble = document.createElement("div");
		typingBubble.className = "ai-chat-bubble ai-chat-bubble-assistant ai-chat-bubble-typing";
		typingBubble.textContent = "...";
		messagesEl.appendChild(typingBubble);
		messagesEl.scrollTop = messagesEl.scrollHeight;

		fetch(actionUrl, {
			method: "POST",
			headers: { "Content-Type": "application/json;charset=UTF-8" },
			body: JSON.stringify({ message: text, history: history })
		})
			.then(function (res) {
				return res.json();
			})
			.then(function (data) {
				typingBubble.remove();
				var replyText = (data && typeof data.reply === "string" && data.reply)
					? data.reply
					: "지금은 추천을 받을 수 없어요.";
				addBubble("assistant", replyText);

				if (data && data.ok) {
					history.push({ role: "user", content: text });
					history.push({ role: "assistant", content: replyText });
					// 서버로 보내는 기록이 너무 길어지지 않도록 최근 20턴만 유지
					if (history.length > 20) {
						history = history.slice(history.length - 20);
					}
				}
			})
			.catch(function () {
				typingBubble.remove();
				addBubble("assistant", "지금은 추천을 받을 수 없어요.");
			})
			.finally(function () {
				sending = false;
				sendBtn.disabled = false;
			});
	}

	sendBtn.addEventListener("click", sendMessage);
	input.addEventListener("keydown", function (e) {
		if (e.key === "Enter") {
			e.preventDefault();
			sendMessage();
		}
	});
})();
