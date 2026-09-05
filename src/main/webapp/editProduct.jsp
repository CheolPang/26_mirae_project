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
<title>CPShop | 상품정보수정</title>
<script>
	function deleteConfirm(id) {
		if (confirm("해당 상품을 정말 삭제하시겠습니까?") == true) {
			location.href="deleteProduct.jsp?id=" + id;
		} else {
			event.stopPropagation();
		}
	}
</script>
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
				<p>
				<%
					String edit = request.getParameter("edit");
					if(edit.equals("update")){
				%>
					<a href="updateProduct.jsp?id=<%=rs.getString("p_id") %>" class="btn btn-info btn-sm mt-2">정보 수정</a>
				<%
					} else if (edit.equals("delete")) {
				%>
					<a onclick="deleteConfirm('<%=rs.getString("p_id") %>')" class="btn btn-danger btn-sm mt-2">상품 삭제</a>
				<%	
					}
				%>
				</p>
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