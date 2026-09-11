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

	let history = [];
	let sending = false;
	let greeted = false;

	function addBubble(role, text) {
		let bubble = document.createElement("div");
		bubble.className = "ai-chat-bubble ai-chat-bubble-" + role;
		bubble.textContent = text;
		messagesEl.appendChild(bubble);
		messagesEl.scrollTop = messagesEl.scrollHeight;
	}

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
