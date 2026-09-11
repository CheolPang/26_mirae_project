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
		if(!checkBytes(document.newWrite.subject, 100, "<fmt:message key="board-subject-label" />") || !checkBytes(document.newWrite.content, 1000, "<fmt:message key="board-content-label" />")) {
			return false;
		}
		document.newWrite.submit();
	}
</script>

</head>
<body>
	<%@ include file="/menu.jsp" %>
	<%
		String name = (String) request.getAttribute("name");
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
					<h2 class="h3 mb-3 text-black"><fmt:message key="board-write-heading" /></h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<form name="newWrite" action="./BoardWriteAction.do" method="post" onsubmit="return checkForm()">
							<c:if test="${not empty errorMsg}">
								<div class="alert alert-danger" role="alert">${errorMsg}</div>
							</c:if>
							<input type="hidden" id="id" name="id" value="${sessionId}">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="name" class="text-black"><fmt:message key="name-label" /></label>
									<input type="text" class="form-control" id="name" name="name" value="${name}" readonly>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="subject" class="text-black"><fmt:message key="board-subject-label" /> <span
										class="text-danger">*</span></label>
									<fmt:message key="board-subject-placeholder" var="boardSubjectPlaceholder" />
									<input type="text"
										class="form-control" id="subject" name="subject" placeholder="${boardSubjectPlaceholder}" value="<c:out value='${param.subject}'/>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="content" class="text-black"><fmt:message key="board-content-label" /> <span
										class="text-danger">*</span></label>
									<fmt:message key="board-content-placeholder" var="boardContentPlaceholder" />
									<textarea class="form-control" name="content" id="content" rows="15" placeholder="${boardContentPlaceholder}"><c:out value="${param.content}"/></textarea>
								</div>
							</div>

							<fmt:message key="register-btn" var="boardRegisterBtn" />
							<fmt:message key="board-reset-btn" var="boardResetBtn" />
							<fmt:message key="prev-btn" var="boardPrevBtn" />
							<input type="submit" class="btn btn-primary me-1" value="${boardRegisterBtn}" />
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
