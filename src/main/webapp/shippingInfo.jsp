<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 배송 정보</title>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="menu-shipping-info" /></h1>
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
					<h2 class="h3 mb-3 text-black"><fmt:message key="shipping-info-heading" /></h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<%
						String cartId = session.getId();
						%>
						<fmt:message key="ph-recipient-name" var="phRecipientName" />
						<fmt:message key="ph-address" var="phAddress" />
						<fmt:message key="ph-postal-code" var="phPostalCode" />
						<form action="./processShippingInfo.jsp" method="POST">
							<input type="hidden" value="<%=cartId %>" name="cartId">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="customerName" class="text-black"><fmt:message key="name-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="customerName" name="customerName"
										placeholder="${phRecipientName}" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="shippingDate" class="text-black"><fmt:message key="shipping-date-label" /> <span
										class="text-danger">*</span></label> <input type="date"
										class="form-control" id="shippingDate" name="shippingDate"
										placeholder="YYYY-MM-DD" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="shippingAddress" class="text-black"><fmt:message key="address-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="shippingAddress" name="shippingAddress"
										placeholder="${phAddress}" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="shippingPostNumber" class="text-black"><fmt:message key="postal-code-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="shippingPostNumber" name="shippingPostNumber"
										placeholder="${phPostalCode}" required>
								</div>
							</div>
							<div class="form-group">
							<fmt:message key="register-btn" var="registerBtnLabel" />
							<input type="submit" class="btn btn-primary me-1 text-start" id="Add" value="${registerBtnLabel}">
							<a href="./cart.jsp" class="btn btn-dark me-1 text-start"><fmt:message key="prev-btn" /></a>
							<a href="./checkOutCancelled.jsp" class="btn btn-danger text-end"><fmt:message key="cancel-btn" /></a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
</fmt:bundle>
