<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 관리자(admin) 계정만 접근 허용
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
<title>CPShop | processUpdateProduct</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String filename = "";
//		String realFolder = "C:/Users/Administrator/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/byeongsu_freshman/upload"; //이미지가 저장될 경로
		// 이미지 저장 위치 : processAddProduct.jsp 설명 참고 (Serve modules without publishing)
		String realFolder = application.getRealPath("/upload");
		String encType = "UTF-8";
		int maxSize = 5*1024*1024;
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		} catch (java.io.IOException e) {
			// 5MB 초과 등 업로드 실패 : 500 에러 대신 수정 폼으로 돌려보낸다
			// (본문을 못 읽었으므로 상품 코드는 form action 주소의 ?id= 에서 꺼낸다)
			System.out.println("processUpdateProduct 업로드 실패 : " + e);
		}
		if (multi == null) {
			if (conn != null) conn.close();
			response.sendRedirect("updateProduct.jsp?error=upload&id=" + java.net.URLEncoder.encode(String.valueOf(request.getParameter("id")), "UTF-8"));
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
		boolean failed = false; // 길이 초과 등으로 저장 실패
		try {
			//String sql = "INSERT INTO bs_product VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
			String sql = "SELECT * FROM bs_product where p_id=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, productId);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				if (fileName != null) {
					sql = "UPDATE bs_product SET p_name=?, p_unitPrice=?, p_description=?, p_category=?, p_manufacturer=?, p_unitsInStock=?, p_condition=?, p_fileName=?, p_quantity=10 WHERE p_id=?";
					pstmt = conn.prepareStatement(sql);				
					pstmt.setString(1, productName);
					pstmt.setInt(2, price);
					pstmt.setString(3, description);
					pstmt.setString(4, category);
					pstmt.setString(5, manufacturer);
					pstmt.setLong(6, stock);
					pstmt.setString(7, condition);
					pstmt.setString(8, fileName);
					pstmt.setString(9, productId);
				
					pstmt.executeUpdate();

				} else {
					sql = "UPDATE bs_product SET p_name=?, p_unitPrice=?, p_description=?, p_category=?, p_manufacturer=?, p_unitsInStock=?, p_condition=?, p_quantity=10 WHERE p_id=?";
					pstmt = conn.prepareStatement(sql);				
					pstmt.setString(1, productName);
					pstmt.setInt(2, price);
					pstmt.setString(3, description);
					pstmt.setString(4, category);
					pstmt.setString(5, manufacturer);
					pstmt.setLong(6, stock);
					pstmt.setString(7, condition);
					pstmt.setString(8, productId);

					pstmt.executeUpdate();

				}
			}
		} catch (Exception e) {
			// 상품 설명 500바이트(한글 약 166자) 초과 등 : 500 에러 대신 수정 폼으로 돌려보낸다
			System.out.println("processUpdateProduct 에러 : " + e);
			failed = true;
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}

		if (failed) {
			// 저장하지 못했으므로 새로 올라간 이미지 파일도 지운다
			if (fileName != null) multi.getFile(frame).delete();
			response.sendRedirect("updateProduct.jsp?error=db&id=" + java.net.URLEncoder.encode(productId, "UTF-8"));
			return;
		}

//		dao.addProduct(newProduct);
		response.sendRedirect("editProduct.jsp?edit=update");
	%>
</body>
</html>