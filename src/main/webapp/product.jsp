<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductDAO"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}

	private String conditionLabel(String condition) {
		if ("New".equalsIgnoreCase(condition)) return "신규 상품";
		if ("Old".equalsIgnoreCase(condition)) return "중고 제품";
		if ("Refurbished".equalsIgnoreCase(condition)) return "재생 제품";
		if ("Recycled".equalsIgnoreCase(condition)) return "재활용 제품";
		return nvl(condition);
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

	String[] specs = nvl(product.getDescription()).split("\\s*/\\s*|\\r?\\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | <%=nvl(product.getPname()) %></title>
</head>
<body>
	<%@ include file="menu.jsp" %>
			<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>상품 정보</h1>
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
			<span>장바구니에 상품을 담았습니다.</span>
			<a href="cart.jsp" class="alert-link">장바구니 바로가기 &rsaquo;</a>
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
				<p class="product-detail-price"><%=df.format(product.getUnitPrice()) %><span class="won">원</span></p>

				<table class="product-info-table">
					<tr>
						<th>재고</th>
						<td><%=soldOut ? "품절" : df.format(stock) + "개" %></td>
					</tr>
					<tr>
						<th>상품 상태</th>
						<td><%=conditionLabel(product.getCondition()) %></td>
					</tr>
					<tr>
						<th>상품 코드</th>
						<td><%=product.getProductId() %></td>
					</tr>
				</table>

				<form action="addCart.jsp" name="addForm" method="post" data-price="<%=product.getUnitPrice() %>">
					<input type="hidden" name="id" value="<%=product.getProductId() %>">
					<input type="hidden" name="buy" value="">

					<div class="product-order-row">
						<span>수량</span>
						<div class="qty-stepper">
							<button type="button" onclick="changeQty(-1)" aria-label="수량 줄이기" <%=soldOut ? "disabled" : "" %>>&minus;</button>
							<input type="number" name="qty" id="qty" value="1" min="1" max="<%=stock %>" aria-label="수량" onchange="changeQty(0)" <%=soldOut ? "disabled" : "" %>>
							<button type="button" onclick="changeQty(1)" aria-label="수량 늘리기" <%=soldOut ? "disabled" : "" %>>+</button>
						</div>
					</div>

					<div class="product-sum">
						<span>총 상품금액</span>
						<span class="product-sum-price" id="totalPrice"><%=df.format(product.getUnitPrice()) %>원</span>
					</div>

					<div class="product-actions">
						<button type="button" class="btn btn-outline-shop" onclick="addToCart()" <%=soldOut ? "disabled" : "" %>>장바구니</button>
						<button type="button" class="btn btn-primary" onclick="buyNow()" <%=soldOut ? "disabled" : "" %>><%=soldOut ? "품절" : "바로구매" %></button>
					</div>
				</form>
			</div>
		</div>

		<section class="product-detail-section">
			<h2>상품정보</h2>
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
</body>
</html>
