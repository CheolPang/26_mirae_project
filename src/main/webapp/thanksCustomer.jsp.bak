<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 주문 완료</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	String Shipping_cartId = "";
	String Shipping_name = "";
	String Shipping_date = "";
	String Shipping_address = "";
	String Shipping_postId = "";

	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_cartId")) {
		Shipping_cartId = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if (n.equals("Shipping_name")) {
		Shipping_name = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if (n.equals("Shipping_date")) {
		Shipping_date = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if (n.equals("Shipping_address")) {
		Shipping_address = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if (n.equals("Shipping_postId")) {
		Shipping_postId = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
		}
	}
	%>
	<%@ include file="menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>주문 완료</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="untree_co-section before-footer-section">
		<div class="container">
			<div class="row mb-5">
				<div class='alert alert-success' role='alert'>
					<h3>
						<b>주문해주셔서 감사합니다.</b>
					</h3>
					<h6 class="mt-2 mb-0">
						<b>주문이 정상적으로 처리되어 예정된 날짜에 상품이 배송될 예정입니다.</b>
					</h6>
				</div>
				<h5 class="mt-3">
					주문번호 :
					<%=Shipping_cartId%></h5>
				<h5>
					배송 예정 날짜 :
					<%=Shipping_date%></h5>
			</div>
			<a href="./products.jsp" class="btn btn-primary">상품 목록으로 이동</a>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
	<%
		session.invalidate();
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
				if (n.equals("Shipping_cartId")) {
					thisCookie.setMaxAge(0);
				}
				if (n.equals("Shipping_name")) {
					thisCookie.setMaxAge(0);
				}
				if (n.equals("Shipping_date")) {
					thisCookie.setMaxAge(0);
				}
				if (n.equals("Shipping_address")) {
					thisCookie.setMaxAge(0);
				}
				if (n.equals("Shipping_postId")) {
					thisCookie.setMaxAge(0);
				}
				
				response.addCookie(thisCookie);
			}
	%>
</body>
</html>