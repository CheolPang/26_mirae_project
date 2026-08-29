<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 배송 확인</title>
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
		if(cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if(n.equals("Shipping_cartId")) {
					Shipping_cartId = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
				}
				if(n.equals("Shipping_name")) {
					Shipping_name = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
				}
				if(n.equals("Shipping_date")) {
					Shipping_date = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
				}
				if(n.equals("Shipping_address")) {
					Shipping_address = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
				}
				if(n.equals("Shipping_postId")) {
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
						<h1>주문 정보</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->
	<div class="untree_co-section before-footer-section">

		<div class="container">
			<h2 class="text-center mb-5">영수증</h2>
			<div class="row">
				<div class="col-4 text-left">
					<strong>배송 주소 : <br> 성명 | <%=Shipping_name %> <br>
						우편번호 | <%=Shipping_postId %> <br> 세부주소 | <%=Shipping_address %>
					</strong>
				</div>
				<div class="col-4 text-right">
					<strong>배송일 : <br> 배송예정날짜 | <%=Shipping_date %></strong>
				</div>
			</div>
			<div class="row mb-5">
				<form class="col-md-12" method="post">
					<div class="site-blocks-table">
						<table class="table">
							<thead>
								<tr>
									<th class="product-name">상품</th>
									<th class="product-price">가격</th>
									<th class="product-quantity">수량</th>
									<th class="product-total">소계</th>
								</tr>
							</thead>
							<tbody>
								<%
                      		int sum = 0;
                      		ArrayList<Product> cartlist = (ArrayList<Product>) session.getAttribute("cartlist");
                      	
                      		if(cartlist == null) {
                      			cartlist = new ArrayList<Product>();
                      		}
                      		for (int i=0; i<cartlist.size(); i++) {
                      			Product product = cartlist.get(i);
                      			int total = product.getUnitPrice() * product.getQuantity();
                      			sum += total;
                      		
                      	%>
								<tr>
									<td class="product-name">
										<h2 class="h5 text-black"><%=product.getPname() %></h2>
									</td>
									<td><%=product.getUnitPrice() %></td>
									<td><%=product.getQuantity() %></td>
									<td><%=total %></td>
								</tr>

								<%
                        	} 
                        %>
								<tr>
									<td></td>
									<td></td>
									<td><h5>
											<b>총액</b>
										</h5></td>
									<td><h5>
											<b><%=sum %></b>
										</h5></td>
								</tr>
							</tbody>
						</table>

					</div>
				</form>

			</div>
			<a href="./products.jsp" class="btn btn-primary">쇼핑 계속하기</a>
			<%
              	String cartId = session.getId();
              %>
			<a href="./checkOutCancelled.jsp" class="btn btn-danger float-end">취소</a>
			<a href="./shippingInfo.jsp?cartId=<%=cartId %>"
				class="btn btn-dark float-end mx-2">이전</a> <a
				href="./thanksCustomer.jsp" class="btn btn-primary float-end mx-3">주문완료</a>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>