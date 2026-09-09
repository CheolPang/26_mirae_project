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
	<%@ include file="dbconn.jsp" %>
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
		//ProductRepository dao = ProductRepository.getInstance();
		String id = request.getParameter("id");
		//Product product = dao.getProductById(id);
		DecimalFormat df = new DecimalFormat("#,##0");
		//String dfR1 = df.format(product.getUnitPrice());
		//String dfR2 = df.format(product.getUnitsInStock());
		String sql = "SELECT * from bs_product WHERE p_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		while(rs.next()) {
	%>
	<div class="container">
		<div class="row p-3">
			<div class="col bg-light p-5" id="sangBox">
				<h3><%=rs.getString("p_name") %></h3>
				<img alt="" src="${pageContext.request.contextPath}/upload/<%=rs.getString("p_fileName")%>" class="img-fluid"/>
				<p class="cs-bold cs-small"><%=rs.getString("p_description") %></p>
				<p><b class="cs-bold cs-small">상품 코드 </b> <%=rs.getString("p_id") %></p>
				<p><b class="cs-bold cs-small">제조사 </b> <%=rs.getString("p_manufacturer") %></p>
				<p><b class="cs-bold cs-small">분류 </b> <%=rs.getString("p_category") %></p>
				<p><b class="cs-bold cs-small">재고 수 </b> <%=rs.getInt("p_unitsInStock") %></p>
				<p><b class="cs-bold cs-small">상품 가격 </b> <%=rs.getInt("p_unitPrice") %></p>
				<p><b class="cs-bold cs-small">상품 상태 </b> <%=rs.getString("p_condition") %></p>
				<form action="addCart.jsp" name="addForm" method="post" class="d-flex flex-wrap gap-2">
					<input type="hidden" name="id" value="<%=rs.getString("p_id")%>">
					<button type="button" class="btn btn-primary btn-sm">상품 주문</button>
					<a href="./cart.jsp" class="btn btn-primary btn-sm" role="button">장바구니 바로가기</a>
					<button type="button" class="btn btn-primary btn-sm" onclick="addToCart()">장바구니에 담기</button>
					<a href="./products.jsp" class="btn btn-secondary btn-sm" role="button">상품 목록 &raquo;</a>
				</form>
			</div>
		</div>
	</div>
			<%
				}
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			%>
	<%@ include file="footer.jsp" %>
</body>
</html>