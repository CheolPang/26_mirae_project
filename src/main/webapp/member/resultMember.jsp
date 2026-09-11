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
	<div class="untree_co-section before-footer-section">
		<div class="container">
			<div class="row mb-5">
			<c:choose>
				<c:when test="${param.msg eq '0'}">
					<fmt:message key="member-info-updated" />
				</c:when>
				<c:when test="${param.msg eq '1'}">
					<h2><fmt:message key="member-signup-complete" /></h2>
				</c:when>
				<c:when test="${param.msg eq '2'}">
					<h2><fmt:message key="member-welcome-login"><fmt:param value="${sessionScope.sessionId}" /></fmt:message></h2>
				</c:when>
				<c:when test="${param.msg eq '3'}">
					<h2><fmt:message key="member-withdraw-complete" /></h2>
				</c:when>
				<c:when test="${empty param.msg}">
					<fmt:message key="member-info-not-found" />
				</c:when>
			</c:choose>
			</div>
		</div>
	</div>
	<%@ include file="/footer.jsp" %>
</body>
</html>
</fmt:bundle>
