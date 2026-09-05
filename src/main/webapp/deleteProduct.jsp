<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | deleteProduct</title>
</head>
<body>
	<%
		String productId = request.getParameter("id");
		String sql = "SELECT * FROM bs_product";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			sql = "DELETE FROM bs_product WHERE p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			pstmt.executeUpdate();
		} else {
			out.println("일치하는 상품이 없습니다.");
		}
		
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
		
		response.sendRedirect("editProduct.jsp?edit=delete");
	%>
</body>
</html>