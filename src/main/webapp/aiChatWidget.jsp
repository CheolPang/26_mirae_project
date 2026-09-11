<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String aiSessionId = (String) session.getAttribute("sessionId");
	boolean aiLoggedIn = (aiSessionId != null);
%>
<!-- Start AI 상품 추천 챗봇 위젯 (Bootstrap 5 Offcanvas) -->
<div id="aiChatRoot" data-logged-in="<%=aiLoggedIn%>" data-action-url="<%=request.getContextPath()%>/AiChatAction.do">
	<button type="button" id="aiChatToggleBtn"
		class="ai-chat-brand btn rounded-circle position-fixed shadow d-flex align-items-center justify-content-center p-0"
		style="right: 24px; bottom: 24px; z-index: 1050;"
		data-bs-toggle="offcanvas" data-bs-target="#aiChatPanel" aria-controls="aiChatPanel"
		aria-label="AI 챗봇 열기">AI</button>

	<div class="offcanvas offcanvas-end" tabindex="-1" id="aiChatPanel" aria-labelledby="aiChatPanelLabel"
		data-bs-scroll="true" data-bs-backdrop="false">
		<div class="offcanvas-header ai-chat-brand">
			<h5 class="offcanvas-title" id="aiChatPanelLabel">CPShop AI</h5>
			<button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="닫기"></button>
		</div>
		<div class="offcanvas-body d-flex flex-column p-0">
			<div id="aiChatMessages" class="flex-grow-1 overflow-auto p-3 d-flex flex-column gap-2"></div>
			<div id="aiChatInputBar" class="d-flex gap-2 p-2 border-top">
				<input type="text" id="aiChatInput" class="form-control rounded-pill" placeholder="메시지를 입력하세요" maxlength="500" autocomplete="off">
				<button id="aiChatSendBtn" class="ai-chat-brand btn rounded-pill">
										<span class="fa fa-paper-plane"></span>
									</button>
			</div>
		</div>
	</div>
</div>
<!-- End AI 상품 추천 챗봇 위젯 -->
<script src="<%=request.getContextPath()%>/js/aiChat.js"></script>
