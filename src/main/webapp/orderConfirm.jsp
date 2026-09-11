<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
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
						<h1><fmt:message key="menu-order-info" /></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->
	<div class="untree_co-section before-footer-section">

		<div class="container">
			<h2 class="text-center mb-5"><fmt:message key="receipt-title" /></h2>
			<div class="row">
				<div class="col-4 text-left">
					<strong><fmt:message key="shipping-address-label" /> : <br> <fmt:message key="name-label" /> | <%=Shipping_name %> <br>
						<fmt:message key="postal-code-label" /> | <%=Shipping_postId %> <br> <fmt:message key="detail-address-label" /> | <%=Shipping_address %>
					</strong>
				</div>
				<div class="col-4 text-right">
					<strong><fmt:message key="shipping-date-label" /> : <br> <fmt:message key="expected-delivery-label" /> | <%=Shipping_date %></strong>
				</div>
			</div>
			<div class="row mb-5">
				<form class="col-md-12" method="post">
					<div class="site-blocks-table">
						<table class="table">
							<thead>
								<tr>
									<th class="product-name"><fmt:message key="th-product" /></th>
									<th class="product-price"><fmt:message key="price-label" /></th>
									<th class="product-quantity"><fmt:message key="quantity" /></th>
									<th class="product-total"><fmt:message key="th-subtotal" /></th>
								</tr>
							</thead>
							<tbody>
								<%
                      		DecimalFormat df = new DecimalFormat("#,##0");
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
									<td><%=df.format(product.getUnitPrice()) %><fmt:message key="currency-won" /></td>
									<td><%=product.getQuantity() %></td>
									<td><%=df.format(total) %><fmt:message key="currency-won" /></td>
								</tr>

								<%
                        	}
                        %>
								<tr>
									<td></td>
									<td></td>
									<td><h5>
											<b><fmt:message key="total-label" /></b>
										</h5></td>
									<td><h5>
											<b><%=df.format(sum) %><fmt:message key="currency-won" /></b>
										</h5></td>
								</tr>
							</tbody>
						</table>

					</div>
				</form>

			</div>
			<a href="./products.jsp" class="btn btn-primary"><fmt:message key="continue-shopping" /></a>
			<%
              	String cartId = session.getId();
              %>
			<a href="./checkOutCancelled.jsp" class="btn btn-danger float-end"><fmt:message key="cancel-btn" /></a>
			<a href="./shippingInfo.jsp?cartId=<%=cartId %>"
				class="btn btn-dark float-end mx-2"><fmt:message key="prev-btn" /></a> <a
				href="./thanksCustomer.jsp" class="btn btn-primary float-end mx-3"><fmt:message key="complete-order-btn" /></a>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
</fmt:bundle>
