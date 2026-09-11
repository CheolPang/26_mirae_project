<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 주문 취소</title>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="order-cancelled-title" /></h1>
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
				<div class='alert alert-danger mb-1' role='alert'>
					<h3>
						<b><fmt:message key="order-cancelled-msg" /></b>
					</h3>
					<h6 class="mt-2 mb-0">
						<b><fmt:message key="order-cancelled-detail" /></b>
					</h6>
				</div>
			</div>
			<a href="./products.jsp" class="btn btn-primary"><fmt:message key="go-to-products" /></a>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
</fmt:bundle>
