<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
//		String realFolder = "C:/Users/Administrator/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/byeongsu_freshman/upload"; //이미지가 저장될 경로
		String realFolder = application.getRealPath("/upload");
		String encType = "UTF-8";
		int maxSize = 5*1024*1024;
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
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
		
//		ProductRepository dao = ProductRepository.getInstance();
		
		Product newProduct = new Product();
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
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
		
//		dao.addProduct(newProduct);
		response.sendRedirect("products.jsp");
	%>
</body>
</html>