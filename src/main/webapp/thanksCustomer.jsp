<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mvc.database.DBConnection"%>
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
		// 로그인한 회원이면 구매 이력(bs_purchase_history)에 남긴다.
		// AI 상품 추천 기능(추후 작업)이 회원별 실제 구매 내역을 읽어올 수 있도록 하기 위함.
		// 게스트(비로그인) 주문은 회원 아이디가 없으므로 이력을 남기지 않는다.
		String sessionId = (String) session.getAttribute("sessionId");
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

		// 주문이 끝났으므로 장바구니만 비운다.
		// 예전에는 session.invalidate()로 세션 전체를 없애서
		// 로그인 정보(sessionId)까지 함께 날아가 로그아웃되는 문제가 있었다.
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