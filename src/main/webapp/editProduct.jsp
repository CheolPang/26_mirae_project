<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductDAO" %>
<%!
	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}
%>
<%
	// 관리자(admin) 계정만 접근 허용
	String adminCheckId = (String) session.getAttribute("sessionId");
	if (!"admin".equals(adminCheckId)) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}

	// 메뉴의 "상품 수정"(edit=update) / "상품 삭제"(edit=delete). 값이 없으면 수정 모드
	boolean deleteMode = "delete".equals(request.getParameter("edit"));

	ArrayList<Product> productList = ProductDAO.getInstance().getAllProducts();
	DecimalFormat df = new DecimalFormat("#,##0");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | <%=deleteMode ? "상품 삭제" : "상품 수정" %></title>
<script>
	function deleteConfirm(id) {
		if (confirm("해당 상품을 정말 삭제하시겠습니까?") == true) {
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
						<h1><%=deleteMode ? "상품 삭제" : "상품 수정" %></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="shop-section">
		<div class="container">
			<p class="shop-count">전체 <strong><%=productList.size() %></strong>개 &middot; <%=deleteMode ? "삭제" : "수정" %>할 상품을 선택하세요.</p>

			<div class="product-grid">
				<%
				for (int i = 0; i < productList.size(); i++) {
					Product product = productList.get(i);
				%>
				<div class="product-card">
					<div class="product-card-thumb">
						<img src="${pageContext.request.contextPath}/upload/<%=product.getFilename() %>" alt="<%=nvl(product.getPname()) %>" loading="lazy">
						<% if (product.getUnitsInStock() <= 0) { %>
						<span class="product-soldout">품절</span>
						<% } %>
					</div>
					<div class="product-card-body">
						<div class="product-brand"><%=nvl(product.getManufacturer()) %> &middot; <%=product.getProductId() %></div>
						<div class="product-card-name"><%=nvl(product.getPname()) %></div>
						<div class="product-card-price"><%=df.format(product.getUnitPrice()) %>원</div>
					</div>
					<div class="product-card-admin">
						<% if (deleteMode) { %>
						<button type="button" onclick="deleteConfirm('<%=product.getProductId() %>')" class="btn btn-danger w-100">상품 삭제</button>
						<% } else { %>
						<a href="updateProduct.jsp?id=<%=product.getProductId() %>" class="btn btn-primary w-100">정보 수정</a>
						<% } %>
					</div>
				</div>
				<%
				}
				%>
			</div>

			<% if (productList.isEmpty()) { %>
			<p class="shop-empty">등록된 상품이 없습니다.</p>
			<% } %>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>
