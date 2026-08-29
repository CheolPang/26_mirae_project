<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 배송정보처리</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		Cookie cartId = new Cookie("Shipping_cartId", URLEncoder.encode(request.getParameter("cartId"), "UTF-8"));
		Cookie name = new Cookie("Shipping_name", URLEncoder.encode(request.getParameter("customerName"), "UTF-8"));
		Cookie date = new Cookie("Shipping_date", URLEncoder.encode(request.getParameter("shippingDate"), "UTF-8"));
		Cookie address = new Cookie("Shipping_address", URLEncoder.encode(request.getParameter("shippingAddress"), "UTF-8"));
		Cookie postId = new Cookie("Shipping_postId", URLEncoder.encode(request.getParameter("shippingPostNumber"), "UTF-8"));
//		Cookie name = new Cookie("Shipping_name", request.getParameter("customerName"));
//		Cookie date = new Cookie("Shipping_date", request.getParameter("shippingDate"));
//		Cookie address = new Cookie("Shipping_address", request.getParameter("shippingAddress"));
//		Cookie postId = new Cookie("Shipping_postId", request.getParameter("shippingPostNumber")); // 공백이슈 처리X
	
		cartId.setMaxAge(24*60*60);
		name.setMaxAge(24*60*60);
		date.setMaxAge(24*60*60);
		address.setMaxAge(24*60*60);
		postId.setMaxAge(24*60*60);
		
		response.addCookie(cartId);
		response.addCookie(name);
		response.addCookie(date);
		response.addCookie(address);
		response.addCookie(postId);
		
		response.sendRedirect("orderConfirm.jsp");
	%>
</body>
</html>