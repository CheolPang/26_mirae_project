<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | removeCart</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		if(id == null || id.trim().equals("")){
			response.sendRedirect("cart.jsp");
			return;
		}
		
		// 장바구니에서 빼는 작업이므로 상품 정보를 다시 조회할 필요가 없다.
		// (예전에는 ProductRepository 메모리 목록에서 찾다가
		//  새로 등록한 상품을 못 찾고 그대로 아래로 흘러 내려갔다.)
		ArrayList<Product> cartlist = (ArrayList<Product>) session.getAttribute("cartlist");
		if(cartlist == null) {
			response.sendRedirect("cart.jsp");
			return;
		}
		
		// 뒤에서부터 지워야 인덱스가 밀리지 않는다.
		for(int i=cartlist.size()-1; i>=0; i--){
			Product goodQnt = cartlist.get(i);
			if(goodQnt.getProductId().equals(id)) {
				cartlist.remove(i);
			}
		}
		
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>
