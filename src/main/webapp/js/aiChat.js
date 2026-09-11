// CPShop AI 상품 추천 챗봇 위젯 (aiChatWidget.jsp에서 로드)
// - 채팅 패널 자체의 열기/닫기(우하단 버튼, Offcanvas 슬라이드)는 Bootstrap 5의
//   data-bs-toggle/data-bs-dismiss가 처리하므로 여기서는 다루지 않는다.
//   이 파일은 패널이 열렸을 때의 첫 인사말과 실제 채팅 전송 로직만 담당한다.
// - 대화 기록은 새로고침 시 사라져도 되는 요구사항이라 JS 배열(메모리)에만 보관한다.
// - 서버에 매 메시지마다 최근 대화 기록을 같이 보내서(멀티턴 컨텍스트) Ollama가
//   맥락을 이어갈 수 있게 한다.
// - 사용자가 입력한 텍스트와 AI가 응답한 텍스트는 모두 textContent로만 DOM에 넣는다.
//   (innerHTML을 쓰지 않음 -> LLM 응답에 HTML/스크립트가 섞여 와도 실행되지 않는다)
(function () {
	"use strict";

	let root = document.querySelector("#aiChatRoot");
	if (!root) return;

	let isLoggedIn = root.getAttribute("data-logged-in") === "true";
	let actionUrl = root.getAttribute("data-action-url");

	let toggleBtn = document.querySelector("#aiChatToggleBtn");
	let panel = document.querySelector("#aiChatPanel");
	let messagesEl = document.querySelector("#aiChatMessages");
	let input = document.querySelector("#aiChatInput");
	let sendBtn = document.querySelector("#aiChatSendBtn");

	// 화면에 보여줄 용도가 아니라 서버로 보낼 최근 대화 기록 (role/content만)
	let history = [];
	let sending = false;
	let greeted = false;

	function addBubble(role, text) {
		let bubble = document.createElement("div");
		bubble.className = "ai-chat-bubble ai-chat-bubble-" + role;
		bubble.textContent = text; // XSS 방지: 항상 textContent 사용
		messagesEl.appendChild(bubble);
		messagesEl.scrollTop = messagesEl.scrollHeight;
	}

	// 패널을 여는 것 자체는 Bootstrap Offcanvas(data-bs-toggle)가 처리하고,
	// 여기서는 완전히 열린 뒤(shown.bs.offcanvas)에 첫 인사말만 붙인다.
	panel.addEventListener("shown.bs.offcanvas", function () {
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
	});

	// 패널이 열려 있는 동안은 우하단 토글 버튼이 패널 안 전송 버튼 위에 겹쳐 보이므로
	// (data-bs-scroll="true"라 body 스크롤과 별개로 버튼이 항상 화면에 고정돼 있음) 숨긴다.
	// 닫을 때는 패널 헤더의 닫기(X) 버튼을 쓰면 된다.
	panel.addEventListener("show.bs.offcanvas", function () {
		toggleBtn.hidden = true;
	});
	panel.addEventListener("hidden.bs.offcanvas", function () {
		toggleBtn.hidden = false;
	});

	function sendMessage() {
		if (!isLoggedIn) {
			addBubble("assistant", "로그인 후 이용 가능한 기능입니다.");
			return;
		}

		let text = input.value.trim();
		if (!text || sending) return;

		addBubble("user", text);
		input.value = "";
		sending = true;
		sendBtn.disabled = true;

		let typingBubble = document.createElement("div");
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
				let replyText = (data && typeof data.reply === "string" && data.reply)
					? data.reply
					: "지금은 답변을 받을 수 없습니다.";
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
				addBubble("assistant", "지금은 추천을 받을 수 없습니다.");
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
