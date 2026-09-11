<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String adminCheckId = (String) session.getAttribute("sessionId");
	if (!"admin".equals(adminCheckId)) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | processAddProduct</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String filename = "";
		String realFolder = application.getRealPath("/upload");
		String encType = "UTF-8";
		int maxSize = 5*1024*1024;
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		} catch (java.io.IOException e) {
			System.out.println("processAddProduct 업로드 실패 : " + e);
		}
		if (multi == null) {
			if (conn != null) conn.close();
			response.sendRedirect("addProduct.jsp?error=upload");
			return;
		}

		String productId = multi.getParameter("productId");
		String productName = multi.getParameter("productName");
		String unitPrice = multi.getParameter("unitPrice");
		String description = multi.getParameter("description");
		String manufacturer = multi.getParameter("manufacturer");
		String category = multi.getParameter("category");
		String unitsInStock = multi.getParameter("unitsInStock");
		String condition = multi.getParameter("condition");
		
		int price;
		if(unitPrice.isEmpty()) {
			price = 0;
		} else {
			price = Integer.valueOf(unitPrice);
		}
		
		long stock;
		if(unitsInStock.isEmpty()) {
			stock = 0;
		} else {
			stock = Long.valueOf(unitsInStock);
		}
		
		Enumeration files = multi.getFileNames();
		String frame = (String) files.nextElement();
		String fileName = multi.getFilesystemName(frame);
		
		
		Product newProduct = new Product();
		String error = null;

		try {
			pstmt = conn.prepareStatement("SELECT count(*) FROM bs_product WHERE p_id=?");
			pstmt.setString(1, productId);
			rs = pstmt.executeQuery();
			rs.next();

			if (rs.getInt(1) > 0) {
				error = "dup";
			} else {
				pstmt.close();
				String sql = "INSERT INTO bs_product VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, productId);
				pstmt.setString(2, productName);
				pstmt.setInt(3, price);
				pstmt.setString(4, description);
				pstmt.setString(5, category);
				pstmt.setString(6, manufacturer);
				pstmt.setLong(7, stock);
				pstmt.setString(8, condition);
				pstmt.setString(9, fileName);

				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println("processAddProduct 에러 : " + e);
			error = "db";
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}

		if (error != null) {
			if (fileName != null) multi.getFile(frame).delete();
			response.sendRedirect("addProduct.jsp?error=" + error);
			return;
		}

//		dao.addProduct(newProduct);
		response.sendRedirect("products.jsp");
	%>
</body>
</html>