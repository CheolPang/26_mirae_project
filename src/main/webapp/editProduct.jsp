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
	String adminCheckId = (String) session.getAttribute("sessionId");
	if (!"admin".equals(adminCheckId)) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}

	boolean deleteMode = "delete".equals(request.getParameter("edit"));
	String modeTitleKey = deleteMode ? "menu-product-delete" : "menu-product-update";
	String modeSelectKey = deleteMode ? "select-to-delete" : "select-to-update";

	ArrayList<Product> productList = ProductDAO.getInstance().getAllProducts();
	DecimalFormat df = new DecimalFormat("#,##0");
%>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<fmt:message key="confirm-delete-product" var="confirmDeleteMsg" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | <fmt:message key="<%=modeTitleKey%>" /></title>
<script>
	function deleteConfirm(id) {
		if (confirm("${confirmDeleteMsg}") == true) {
			location.href="deleteProduct.jsp?id=" + id;
		}
	}
</script>
</head>
<body>
	<%@ include file="menu.jsp" %>

	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="<%=modeTitleKey%>" /></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="shop-section">
		<div class="container">
			<p class="shop-count">
				<fmt:message key="shop-count"><fmt:param value="<%=productList.size()%>"/></fmt:message>
				&middot;
				<fmt:message key="<%=modeSelectKey%>" />
			</p>

			<div class="product-grid">
				<%
				for (int i = 0; i < productList.size(); i++) {
					Product product = productList.get(i);
				%>
				<div class="product-card">
					<div class="product-card-thumb">
						<img src="${pageContext.request.contextPath}/upload/<%=product.getFilename() %>" alt="<%=nvl(product.getPname()) %>" loading="lazy">
						<% if (product.getUnitsInStock() <= 0) { %>
						<span class="product-soldout"><fmt:message key="sold-out" /></span>
						<% } %>
					</div>
					<div class="product-card-body">
						<div class="product-brand"><%=nvl(product.getManufacturer()) %> &middot; <%=product.getProductId() %></div>
						<div class="product-card-name"><%=nvl(product.getPname()) %></div>
						<div class="product-card-price"><%=df.format(product.getUnitPrice()) %><fmt:message key="currency-won" /></div>
					</div>
					<div class="product-card-admin">
						<% if (deleteMode) { %>
						<button type="button" onclick="deleteConfirm('<%=product.getProductId() %>')" class="btn btn-danger w-100"><fmt:message key="menu-product-delete" /></button>
						<% } else { %>
						<a href="updateProduct.jsp?id=<%=product.getProductId() %>" class="btn btn-primary w-100"><fmt:message key="edit-info" /></a>
						<% } %>
					</div>
				</div>
				<%
				}
				%>
			</div>

			<% if (productList.isEmpty()) { %>
			<p class="shop-empty"><fmt:message key="no-products" /></p>
			<% } %>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>
</fmt:bundle>
