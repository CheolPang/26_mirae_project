<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%!
	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}
%>
<%
	ArrayList<Product> productList = ProductDAO.getInstance().getAllProducts();
	DecimalFormat df = new DecimalFormat("#,##0");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 상품 목록</title>
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
						<h1><fmt:message key="menu-product-list" /></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="shop-section">
		<div class="container">

			<div class="product-grid">
				<%
				for (int i = 0; i < productList.size(); i++) {
					Product product = productList.get(i);
				%>
				<a href="product.jsp?id=<%=product.getProductId() %>" class="product-card">
					<div class="product-card-thumb">
						<img src="${pageContext.request.contextPath}/upload/<%=product.getFilename() %>" alt="<%=nvl(product.getPname()) %>" loading="lazy">
						<% if (product.getUnitsInStock() <= 0) { %>
						<span class="product-soldout"><fmt:message key="sold-out" /></span>
						<% } %>
					</div>
					<div class="product-card-body">
						<div class="product-brand"><%=nvl(product.getManufacturer()) %></div>
						<div class="product-card-name"><%=nvl(product.getPname()) %></div>
						<div class="product-card-price"><%=df.format(product.getUnitPrice()) %><fmt:message key="currency-won" /></div>
					</div>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
	</fmt:bundle>
</body>
</html>
