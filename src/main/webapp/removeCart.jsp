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
		
		ArrayList<Product> cartlist = (ArrayList<Product>) session.getAttribute("cartlist");
		if(cartlist == null) {
			response.sendRedirect("cart.jsp");
			return;
		}

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
