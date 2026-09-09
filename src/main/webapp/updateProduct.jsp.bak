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
<title>CPShop | 상품정보수정</title>
</head>             
<body>
	<%@ include file="menu.jsp" %>
	<%@ include file="dbconn.jsp" %>
	<div class="container-fluid">
		<div class="row">
			<div class="bg-Secondary">
				<ul class="nav justify-content-center" id="titleLine">
					<li class="nav-item text-success">
						<h1><b>상품정보수정</b></h1>
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
			<form action="./processUpdateProduct.jsp" name="updateProduct" method="POST" enctype="multipart/form-data">
				<h3>상품명: <input type="text" id="productName" name="productName" value="<%=rs.getString("p_name") %>"></h3>
				<img alt="" src="${pageContext.request.contextPath}/upload/<%=rs.getString("p_fileName")%>" class="img-fluid"/>
				<p class="cs-bold cs-small"><textarea id="description" name="description" cols="100" ><%=rs.getString("p_description") %></textarea></p>
				
				<p><b class="cs-bold cs-small"><label for="productId">상품 코드 </label></b><input type="text" id="productId" name="productId" value="<%=rs.getString("p_id") %>" readonly> </p>
				<p><b class="cs-bold cs-small"><label for="manufacturer">제조사 </label></b><input type="text" id="manufacturer" name="manufacturer" value="<%=rs.getString("p_manufacturer") %>"></p>
				<p><b class="cs-bold cs-small"><label for="category">분류 </label></b><input type="text" id="category" name="category" value="<%=rs.getString("p_category") %>"></p>
				<p><b class="cs-bold cs-small"><label for="unitsInStock">재고 수 </label></b><input type="number" id="unitsInStock" name="unitsInStock" value="<%=rs.getString("p_unitsInStock") %>"></p>
				<p><b class="cs-bold cs-small"><label for="unitPrice">상품 가격 </label></b><input type="number" id="unitPrice" name="unitPrice" value="<%=rs.getString("p_unitPrice") %>"></p>
				<p><b class="cs-bold cs-small"><label for="productImage">이미지 수정 (선택) </label></b><input type="file" id="productImage" name="productImage"></p>
				<p><b class="cs-bold cs-small">상품 상태 </b>
					<%
						String status = rs.getString("p_condition");
						if (status.equals("new")) {
					%>
					<input type="radio" name="condition" value="New" checked>신규제품
					<input type="radio" name="condition" value="Old">중고제품
					<input type="radio" name="condition" value="Refurbished">재생제품	
					<input type="radio" name="condition" value="Recycled">재생제품	
					<%		
						} else if (status.equals("Old")) {
					%>
					<input type="radio" name="condition" value="New">신규제품
					<input type="radio" name="condition" value="Old" checked>중고제품
					<input type="radio" name="condition" value="Refurbished">재생제품						
					<input type="radio" name="condition" value="Recycled">재활용제품						
					<%
						} else if (status.equals("Refurbished")) {
					%>
					<input type="radio" name="condition" value="New">신규제품
					<input type="radio" name="condition" value="Old">중고제품
					<input type="radio" name="condition" value="Refurbished" checked>재생제품		
					<input type="radio" name="condition" value="Recycled">재활용제품	
					<%
						} else if (status.equals("Recycled")) {
					%>
					<input type="radio" name="condition" value="New">신규제품
					<input type="radio" name="condition" value="Old">중고제품
					<input type="radio" name="condition" value="Refurbished">재생제품		
					<input type="radio" name="condition" value="Recycled" checked>재활용제품	
					<%
						}
					%>
				</p>
					<button type="button" onclick="checkEditProduct()" class="btn btn-primary">수정하기</button>
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