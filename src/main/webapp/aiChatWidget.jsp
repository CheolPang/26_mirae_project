<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// footer.jsp에서 include 되므로, footer.jsp를 포함하는 모든 페이지에 자동으로 뜬다.
	// 로그인 여부는 다른 페이지들과 동일하게 session의 "sessionId" 속성으로 판단한다.
	String aiSessionId = (String) session.getAttribute("sessionId");
	boolean aiLoggedIn = (aiSessionId != null);
%>
<!-- Start AI 상품 추천 챗봇 위젯 -->
<div id="aiChatRoot" data-logged-in="<%=aiLoggedIn%>" data-action-url="<%=request.getContextPath()%>/AiChatAction.do">
	<button type="button" id="aiChatToggleBtn" aria-label="AI 상품 추천 챗봇 열기">AI</button>

	<div id="aiChatPanel" hidden>
		<div id="aiChatPanelHeader">
			<span>CPShop AI 추천</span>
			<button type="button" id="aiChatCloseBtn" aria-label="닫기">&times;</button>
		</div>
		<div id="aiChatMessages"></div>
		<div id="aiChatInputBar">
			<input type="text" id="aiChatInput" placeholder="메시지를 입력하세요" maxlength="500" autocomplete="off">
			<button type="button" id="aiChatSendBtn">전송</button>
		</div>
	</div>
</div>
<!-- End AI 상품 추천 챗봇 위젯 -->
<script src="<%=request.getContextPath()%>/js/aiChat.js"></script>
