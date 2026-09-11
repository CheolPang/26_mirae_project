<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductDAO"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%!
	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}

	// 조건 코드(DB 저장값: New/Old/Refurbished/Recycled)를 bundle.message 키로 매핑한다.
	// 실제 표시 문구는 <fmt:message>로 렌더링한다 (DB 값 자체가 아니라 UI 라벨이므로 다국어화 대상).
	private String conditionKey(String condition) {
		if ("New".equalsIgnoreCase(condition)) return "condition_New";
		if ("Old".equalsIgnoreCase(condition)) return "condition_Old";
		if ("Refurbished".equalsIgnoreCase(condition)) return "condition_Refurbished";
		if ("Recycled".equalsIgnoreCase(condition)) return "condition_Recycling";
		return "condition_New";
	}
%>
<%
	Product product = ProductDAO.getInstance().getProductById(request.getParameter("id"));
	if (product == null) {
		response.sendRedirect("exceptionNoProductId.jsp");
		return;
	}
	DecimalFormat df = new DecimalFormat("#,##0");
	long stock = product.getUnitsInStock();
	boolean soldOut = stock <= 0;
	String condKey = conditionKey(product.getCondition());

	String[] specs = nvl(product.getDescription()).split("\\s*/\\s*|\\r?\\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | <%=nvl(product.getPname()) %></title>
</head>
<body>
	<fmt:setLocale value='<%=request.getParameter("language")%>' />
	<fmt:bundle basename="bundle.message">
	<%@ include file="menu.jsp" %>
			<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="product-detail-title" /></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="container">
		<% if (request.getParameter("added") != null) { %>
		<div class="alert alert-success d-flex mt-5 justify-content-between align-items-center" role="alert">
			<span><fmt:message key="added-to-cart" /></span>
			<a href="cart.jsp" class="alert-link"><fmt:message key="go-to-cart" /> &rsaquo;</a>
		</div>
		<% } %>

		<div class="row g-5 mt-2 product-detail">
			<div class="col-lg-6">
				<div class="product-detail-image">
					<img src="${pageContext.request.contextPath}/upload/<%=product.getFilename() %>" alt="<%=nvl(product.getPname()) %>">
				</div>
			</div>

			<div class="col-lg-6">
				<div class="product-brand"><%=nvl(product.getManufacturer()) %></div>
				<h1 class="product-detail-name"><%=nvl(product.getPname()) %></h1>
				<p class="product-detail-price"><%=df.format(product.getUnitPrice()) %><span class="won"><fmt:message key="currency-won" /></span></p>

				<table class="product-info-table">
					<tr>
						<th><fmt:message key="stock-label" /></th>
						<td>
							<c:choose>
								<c:when test="<%=soldOut%>"><fmt:message key="sold-out" /></c:when>
								<c:otherwise><fmt:message key="stock-count"><fmt:param value="<%=df.format(stock)%>"/></fmt:message></c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th><fmt:message key="condition" /></th>
						<td><fmt:message key="<%=condKey%>" /></td>
					</tr>
					<tr>
						<th><fmt:message key="productId" /></th>
						<td><%=product.getProductId() %></td>
					</tr>
				</table>

				<fmt:message key="decrease-qty" var="decreaseQtyLabel" />
				<fmt:message key="increase-qty" var="increaseQtyLabel" />
				<fmt:message key="quantity" var="quantityLabel" />

				<form action="addCart.jsp" name="addForm" method="post" data-price="<%=product.getUnitPrice() %>">
					<input type="hidden" name="id" value="<%=product.getProductId() %>">
					<input type="hidden" name="buy" value="">

					<div class="product-order-row">
						<span><fmt:message key="quantity" /></span>
						<div class="qty-stepper">
							<button type="button" onclick="changeQty(-1)" aria-label="${decreaseQtyLabel}" <%=soldOut ? "disabled" : "" %>>&minus;</button>
							<input type="number" name="qty" id="qty" value="1" min="1" max="<%=stock %>" aria-label="${quantityLabel}" onchange="changeQty(0)" <%=soldOut ? "disabled" : "" %>>
							<button type="button" onclick="changeQty(1)" aria-label="${increaseQtyLabel}" <%=soldOut ? "disabled" : "" %>>+</button>
						</div>
					</div>

					<div class="product-sum">
						<span><fmt:message key="total-price" /></span>
						<span class="product-sum-price" id="totalPrice"><%=df.format(product.getUnitPrice()) %><fmt:message key="currency-won" /></span>
					</div>

					<div class="product-actions">
						<button type="button" class="btn btn-outline-shop" onclick="addToCart()" <%=soldOut ? "disabled" : "" %>><fmt:message key="add-to-cart-btn" /></button>
						<button type="button" class="btn btn-primary" onclick="buyNow()" <%=soldOut ? "disabled" : "" %>>
							<c:choose>
								<c:when test="<%=soldOut%>"><fmt:message key="sold-out" /></c:when>
								<c:otherwise><fmt:message key="buy-now" /></c:otherwise>
							</c:choose>
						</button>
					</div>
				</form>
			</div>
		</div>

		<section class="product-detail-section">
			<h2><fmt:message key="product-spec-title" /></h2>
			<ul class="product-spec-list">
				<%
				for (int i = 0; i < specs.length; i++) {
					if (specs[i].trim().isEmpty()) continue;
				%>
				<li><%=specs[i].trim() %></li>
				<%
				}
				%>
			</ul>
		</section>
	</div>

	<%@ include file="footer.jsp" %>
	</fmt:bundle>
</body>
</html>
