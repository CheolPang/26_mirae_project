<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductRepository"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.Product"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 제품 상세페이지</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<div class="container-fluid">
		<div class="row">
			<div class="bg-Secondary">
				<ul class="nav justify-content-center" id="titleLine">
					<li class="nav-item text-success">
						<h1><b>상품정보</b></h1>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<%
		ProductRepository dao = ProductRepository.getInstance();
		String id = request.getParameter("id");
		Product product = dao.getProductById(id);
		DecimalFormat df = new DecimalFormat("#,##0");
		String dfR1 = df.format(product.getUnitPrice());
		String dfR2 = df.format(product.getUnitsInStock());
	%>
	<div class="container">
		<div class="row p-3">
			<div class="col bg-light p-5" id="sangBox">
				<h3><%=product.getPname() %></h3>
				<img alt="" src="${pageContext.request.contextPath}/upload/<%=product.getFilename()%>" class="img-fluid"/>
				<p class="cs-bold cs-small"><%=product.getDescription() %></p>
				<p><b class="cs-bold cs-small">상품 코드 </b> <%=product.getProductId() %></p>
				<p><b class="cs-bold cs-small">제조사 </b> <%=product.getManufacturer() %></p>
				<p><b class="cs-bold cs-small">분류 </b> <%=product.getCategory() %></p>
				<p><b class="cs-bold cs-small">재고 수 </b> <%=dfR2 %></p>
				<p><b class="cs-bold cs-small">상품 가격 </b> <%=dfR1 %></p>
				<p>
					<form action="addCart.jsp?id=<%=product.getProductId()%>" name="addForm" method="post">
						<a href="#" class="btn btn-primary btn-sm">상품 주문</a>
						<a href="./cart.jsp" class="btn btn-primary btn-sm">장바구니 바로가기</a>
						<input href="#" class="btn btn-primary btn-sm" onclick="addToCart()" value="장바구니에 담기"></input>
						<a href="./products.jsp" class="btn btn-light btn-sm">상품 목록 &raquo;</a>
					</form>
				</p>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>