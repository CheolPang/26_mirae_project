<%@page import="mvc.model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | <fmt:message key="board-title" /></title>
<script>
	function checkForm() {
		if(!document.newWrite.subject.value) {
			alert("<fmt:message key="board-subject-required-alert" />");
			return false;
		}
		if(!document.newWrite.content.value) {
			alert("<fmt:message key="board-content-required-alert" />");
			return false;
		}
		document.newWrite.submit();
	}
</script>

</head>
<body>
	<%@ include file="/menu.jsp" %>
	<%
		BoardDTO notice = (BoardDTO) request.getAttribute("board");
		int num = (Integer) request.getAttribute("num");
		int now = (Integer) request.getAttribute("pageNum");
	%>
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
					<h2 class="h3 mb-3 text-black"><fmt:message key="board-post-heading" /></h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<form name="newWrite" action="./BoardWriteAction.do" method="post"
							onsubmit="return checkForm()">
							<input type="hidden" id="id" name="id" value="${sessionId}">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="name" class="text-black"><fmt:message key="name-label" /></label>
									<input type="text" class="form-control" id="name" name="name"
										value="<%=notice.getName() %>" readonly>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="subject" class="text-black"><fmt:message key="board-subject-label" /></label>
									<input type="text" class="form-control" id="subject" name="subject"
										value="<%=notice.getSubject() %>" readonly>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="content" class="text-black"><fmt:message key="board-content-label" /></label>
									<textarea class="form-control" name="content" id="content"
										rows="15" readonly><%=notice.getContent()%></textarea>
								</div>
							</div>

							<c:set var="userId" value="<%=notice.getId()%>" />
							<c:if test="${sessionId eq userId}">
								<fmt:message key="update-btn" var="boardUpdateBtn" />
								<fmt:message key="delete-btn" var="boardDeleteBtn" />
								<fmt:message key="board-confirm-delete" var="boardConfirmDelete" />
								<input type="button" class="btn btn-primary me-1" value="${boardUpdateBtn}" onclick="location.href='./board/editForm.jsp?edit=edit&num=<%=num %>&pageNum=<%=now %>'" />
								<input type="button" class="btn btn-danger me-1" value="${boardDeleteBtn}" onclick="if(confirm('${boardConfirmDelete}')) location.href='./board/editForm.jsp?edit=delete&num=<%=num %>&pageNum=<%=now %>'" />
							</c:if>
							<fmt:message key="list-btn" var="boardListBtn" />
							<a href="./BoardListAction.do?pageNum=<%=now %>" class="btn btn-dark">${boardListBtn}</a>
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
