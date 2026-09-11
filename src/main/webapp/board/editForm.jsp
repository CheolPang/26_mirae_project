<%@page import="mvc.model.BoardDAO"%>
<%@page import="mvc.model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String edit = request.getParameter("edit");

	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO board = dao.getBoardByNum(num, pageNum);

	String loginId = (String) session.getAttribute("sessionId");
	if (board == null || loginId == null || !loginId.equals(board.getId())) {
		response.sendRedirect(request.getContextPath() + "/BoardViewAction.do?num=" + num + "&pageNum=" + pageNum);
		return;
	}

	if ("delete".equals(edit)) {
		dao.deleteBoard(num);
		response.sendRedirect(request.getContextPath() + "/BoardListAction.do?pageNum=" + pageNum);
		return;
	}

	String subject = board.getSubject();
	String content = board.getContent();
	if (request.getAttribute("errorMsg") != null) {
		subject = request.getParameter("subject");
		content = request.getParameter("content");
	}
	pageContext.setAttribute("subject", subject);
	pageContext.setAttribute("content", content);
%>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | <fmt:message key="board-title" /></title>
<script>
	function checkForm() {
		if(!document.editWrite.subject.value) {
			alert("<fmt:message key="board-subject-required-alert" />");
			return false;
		}
		if(!document.editWrite.content.value) {
			alert("<fmt:message key="board-content-required-alert" />");
			return false;
		}
		if(!checkBytes(document.editWrite.subject, 100, "<fmt:message key="board-subject-label" />") || !checkBytes(document.editWrite.content, 1000, "<fmt:message key="board-content-label" />")) {
			return false;
		}
		document.editWrite.submit();
	}
</script>

</head>
<body>
	<%@ include file="/menu.jsp" %>
		<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="board-title" /></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->
	<div class="untree_co-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12 mb-5 mb-md-0">
					<h2 class="h3 mb-3 text-black"><fmt:message key="board-edit-heading" /></h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<form name="editWrite" action="<%=request.getContextPath()%>/BoardUpdateAction.do" method="post" onsubmit="return checkForm()">
							<c:if test="${not empty errorMsg}">
								<div class="alert alert-danger" role="alert">${errorMsg}</div>
							</c:if>
							<input type="hidden" name="num" value="<%=num %>">
							<input type="hidden" name="pageNum" value="<%=pageNum %>">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="name" class="text-black"><fmt:message key="name-label" /></label>
									<input type="text" class="form-control" id="name" name="name" value="<%=board.getName() %>" readonly>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="subject" class="text-black"><fmt:message key="board-subject-label" /> <span
										class="text-danger">*</span></label>
									<fmt:message key="board-subject-placeholder" var="boardSubjectPlaceholder" />
									<input type="text"
										class="form-control" id="subject" name="subject" placeholder="${boardSubjectPlaceholder}" value="<c:out value='${subject}'/>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="content" class="text-black"><fmt:message key="board-content-label" /> <span
										class="text-danger">*</span></label>
									<fmt:message key="board-content-placeholder" var="boardContentPlaceholder" />
									<textarea class="form-control" name="content" id="content" rows="15" placeholder="${boardContentPlaceholder}"><c:out value="${content}"/></textarea>
								</div>
							</div>

							<fmt:message key="update-btn" var="boardUpdateBtn" />
							<fmt:message key="board-reset-btn" var="boardResetBtn" />
							<fmt:message key="prev-btn" var="boardPrevBtn" />
							<input type="submit" class="btn btn-primary me-1" value="${boardUpdateBtn}" />
							<input type="reset" class="btn btn-danger me-1" value="${boardResetBtn}" />
							<input type="button" class="btn btn-dark" value="${boardPrevBtn}" onclick="history.back()"/>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/footer.jsp" %>
</body>
</html>
</fmt:bundle>
