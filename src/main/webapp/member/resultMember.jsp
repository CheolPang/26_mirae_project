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
<title>CPShop | 회원 정보</title>
</head>
<body>
	<%@ include file="../menu.jsp" %>
		<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="member-info-title" /></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->
	<%-- thanksCustomer.jsp / checkOutCancelled.jsp와 같은 알림 박스 + 이동 버튼 형태로 통일 --%>
	<div class="untree_co-section before-footer-section">
		<div class="container">
			<div class="row mb-5">
				<c:choose>
					<c:when test="${param.msg eq '0'}">
						<div class='alert alert-success' role='alert'>
							<h3><b><fmt:message key="member-info-updated-title" /></b></h3>
							<h6 class="mt-2 mb-0"><b><fmt:message key="member-info-updated-detail" /></b></h6>
						</div>
					</c:when>
					<c:when test="${param.msg eq '1'}">
						<div class='alert alert-success' role='alert'>
							<h3><b><fmt:message key="member-signup-complete-title" /></b></h3>
							<h6 class="mt-2 mb-0"><b><fmt:message key="member-signup-complete-detail" /></b></h6>
						</div>
					</c:when>
					<c:when test="${param.msg eq '2'}">
						<div class='alert alert-success' role='alert'>
							<h3><b><fmt:message key="member-welcome-login-title"><fmt:param value="${sessionScope.sessionId}" /></fmt:message></b></h3>
							<h6 class="mt-2 mb-0"><b><fmt:message key="member-welcome-login-detail" /></b></h6>
						</div>
					</c:when>
					<c:when test="${param.msg eq '3'}">
						<div class='alert alert-success' role='alert'>
							<h3><b><fmt:message key="member-withdraw-complete-title" /></b></h3>
							<h6 class="mt-2 mb-0"><b><fmt:message key="member-withdraw-complete-detail" /></b></h6>
						</div>
					</c:when>
					<c:when test="${empty param.msg}">
						<div class='alert alert-danger mb-1' role='alert'>
							<h3><b><fmt:message key="member-info-not-found-title" /></b></h3>
							<h6 class="mt-2 mb-0"><b><fmt:message key="member-info-not-found-detail" /></b></h6>
						</div>
					</c:when>
				</c:choose>
			</div>

			<c:choose>
				<c:when test="${param.msg eq '1' or empty param.msg}">
					<a href="../member/login.jsp" class="btn btn-primary"><fmt:message key="go-to-login" /></a>
				</c:when>
				<c:when test="${param.msg eq '3'}">
					<a href="../welcome.jsp" class="btn btn-primary"><fmt:message key="go-to-home" /></a>
				</c:when>
				<c:otherwise>
					<a href="../products.jsp" class="btn btn-primary"><fmt:message key="go-to-products" /></a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<%@ include file="/footer.jsp" %>
</body>
</html>
</fmt:bundle>
