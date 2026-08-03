<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | Cart</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>장바구니</h1>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
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
                          <th class="product-name">상품</th>
                          <th class="product-price">가격</th>
                          <th class="product-quantity">수량</th>
                          <th class="product-total">소계</th>
                          <th class="product-total">비고</th>
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
                          <td><a href="./removeCart.jsp?id=<%=product.getProductId() %>" class="btn btn-danger">삭제</a></td>
                        </tr>

                        <%
                        	} 
                        %>
                        <tr>
                          <td>  
                          </td>
                          <td></td>
                          <td><h5><b>총액</b></h5></td>
                          <td><h5><b><%=sum %></b></h5></td>
                          <td></td>
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
              <a href="./deleteCart.jsp?cartId=<%=cartId %>" class="btn btn-danger float-end">장바구니 비우기</a>
			</div>
		</div>
	<%@ include file="footer.jsp" %>
</body>
</html>