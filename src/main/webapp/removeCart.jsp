<%@page import="dao.ProductRepository"%>
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
			response.sendRedirect("product.jsp");
			return;
		}
		
		ProductRepository dao = ProductRepository.getInstance();
		Product product = dao.getProductById(id);
		
		if(product == null) {
			response.sendRedirect("exceptionNoProductId.jsp");
		}
		ArrayList<Product> cartlist = (ArrayList<Product>) session.getAttribute("cartlist");
	
		Product goodQnt = new Product();
		for(int i=0; i<cartlist.size(); i++){
			goodQnt = cartlist.get(i);
			if(goodQnt.getProductId().equals(id)) {
				cartlist.remove(goodQnt);
			}
		}
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>