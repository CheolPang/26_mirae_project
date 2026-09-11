<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
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
<title>CPShop | Cart</title>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="cart-title" /></h1>
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
				<form class="col-md-12" method="post">
					<div class="site-blocks-table">
						<table class="table">
							<thead>
								<tr>
									<th class="product-name"><fmt:message key="th-product" /></th>
									<th class="product-price"><fmt:message key="price-label" /></th>
									<th class="product-quantity"><fmt:message key="quantity" /></th>
									<th class="product-total"><fmt:message key="th-subtotal" /></th>
									<th class="product-total"><fmt:message key="th-note" /></th>
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
									<td><a
										href="./removeCart.jsp?id=<%=product.getProductId() %>"
										class="btn btn-danger"><fmt:message key="delete-btn" /></a></td>
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
									<td></td>
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
			<a href="./deleteCart.jsp?cartId=<%=cartId %>"
				class="btn btn-danger float-end"><fmt:message key="empty-cart-btn" /></a> <a
				href="./shippingInfo.jsp?cartId=<%=cartId %>"
				class="btn btn-primary float-end mx-2"><fmt:message key="order-btn" /></a>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
</fmt:bundle>
