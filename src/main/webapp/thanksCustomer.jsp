<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mvc.database.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
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
						<h1><fmt:message key="order-complete-title" /></h1>
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
						<b><fmt:message key="thank-you-title" /></b>
					</h3>
					<h6 class="mt-2 mb-0">
						<b><fmt:message key="order-processed-msg" /></b>
					</h6>
				</div>
				<h5 class="mt-3">
					<fmt:message key="order-number-label" /> :
					<%=Shipping_cartId%></h5>
				<h5>
					<fmt:message key="expected-delivery-label" /> :
					<%=Shipping_date%></h5>
			</div>
			<a href="./products.jsp" class="btn btn-primary"><fmt:message key="go-to-products" /></a>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
	<%
		sessionId = (String) session.getAttribute("sessionId");
		ArrayList<Product> purchasedList = (ArrayList<Product>) session.getAttribute("cartlist");
		if (sessionId != null && purchasedList != null && !purchasedList.isEmpty()) {
			Connection phConn = null;
			PreparedStatement phStmt = null;
			try {
				phConn = DBConnection.getConnection();
				String phSql = "insert into bs_purchase_history(num, id, p_id, quantity, purchase_price) "
						+ "values(bs_purchase_num.nextval, ?, ?, ?, ?)";
				phStmt = phConn.prepareStatement(phSql);
				for (int i = 0; i < purchasedList.size(); i++) {
					Product purchasedProduct = purchasedList.get(i);
					phStmt.setString(1, sessionId);
					phStmt.setString(2, purchasedProduct.getProductId());
					phStmt.setInt(3, purchasedProduct.getQuantity());
					phStmt.setInt(4, purchasedProduct.getUnitPrice());
					phStmt.executeUpdate();
				}
			} catch (Exception e) {
				System.out.println("구매 이력 저장 에러 : " + e);
			} finally {
				try {
					if (phStmt != null) phStmt.close();
					if (phConn != null) phConn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		session.removeAttribute("cartlist");
		for (int i = 0; cookies != null && i < cookies.length; i++) {
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
</fmt:bundle>