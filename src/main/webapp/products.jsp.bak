<%@page import="dao.ProductRepository"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 상품 목록</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<%@ include file="dbconn.jsp" %>
	
	<div class="container-fluid">
		<div class="row">
			<div class="bg-Secondary">
				<ul class="nav justify-content-center" id="titleLine">
					<li class="nav-item text-success">
						<h1><b>상품목록</b></h1>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<%
		// Non-DB용
		// ProductRepository dao = ProductRepository.getInstance();
		// ArrayList<Product> listOfProducts = dao.getAllProducts();
	%>
	
	<div class="container p-5">
		<div class="row">
			<%
				// Non-DB용
				//for (int i = 0; i < listOfProducts.size(); i++){
				//	Product product = listOfProducts.get(i);
				//	DecimalFormat df = new DecimalFormat("#,##0");
				//	String dfR1 = df.format(product.getUnitPrice());
				String sql = "SELECT * from bs_product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					
			%>
			<div class="col-5 mb-5" id="coll">
				<h3 class="mb-5"><%=rs.getString("p_name") %></h3>
				<img alt="" src="${pageContext.request.contextPath}/upload/<%=rs.getString("p_fileName") %>" class="img-fluid"/>
				<p><%=rs.getString("p_description") %></p>
				<p><%=rs.getInt("p_unitPrice") %>원</p>
				<p><a href="product.jsp?id=<%=rs.getString("p_id") %>" class="btn btn-primary btn-sm mt-2">상세 정보</a></p>
			</div>
			<%
				}
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			%>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>