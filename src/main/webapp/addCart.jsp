<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | addCart</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		String id = request.getParameter("id");
		if(id == null || id.trim().equals("")){
			response.sendRedirect("products.jsp");
			return;
		}
		
		// 상품 정보를 DB(bs_product)에서 조회한다.
		// 예전에는 ProductRepository(메모리 목록)에서 찾았기 때문에
		// 관리자가 새로 등록한 상품은 찾지 못했다.
		Product goods = null;
		
		String sql = "SELECT * FROM bs_product WHERE p_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			// 장바구니에는 조회 결과로 만든 새 객체를 담는다.
			goods = new Product();
			goods.setProductId(rs.getString("p_id"));
			goods.setPname(rs.getString("p_name"));
			goods.setUnitPrice(rs.getInt("p_unitPrice"));
			goods.setDescription(rs.getString("p_description"));
			goods.setCategory(rs.getString("p_category"));
			goods.setManufacturer(rs.getString("p_manufacturer"));
			goods.setUnitsInStock(rs.getLong("p_unitsInStock"));
			goods.setCondition(rs.getString("p_condition"));
			goods.setFilename(rs.getString("p_fileName"));
		}
		
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
		
		if(goods == null) {
			response.sendRedirect("exceptionNoProductId.jsp");
			return;
		}
		
		ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
		if(list == null) {
			list = new ArrayList<Product>();
			session.setAttribute("cartlist", list);
		}
		
		// 이미 담긴 상품이면 수량만 1 증가시킨다.
		int cnt = 0;
		for (int i=0; i<list.size(); i++){
			Product goodsQnt = list.get(i);
			if(goodsQnt.getProductId().equals(id)) {
				cnt++;
				goodsQnt.setQuantity(goodsQnt.getQuantity() + 1);
				break;
			}
		}
		
		if(cnt == 0){
			goods.setQuantity(1);
			list.add(goods);
		}
		
		response.sendRedirect("product.jsp?id="+id);
	%>
</body>
</html>
