<%@page import="dao.ProductRepository"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 제품 목록</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
	
	<div class="container-fluid">
		<div class="row">
			<div class="bg-Secondary">
				<ul class="nav justify-content-center" id="titleLine">
					<li class="nav-item text-success">
						<h1><b>상품목록</b></h1>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<%
		ProductRepository dao = ProductRepository.getInstance();
		ArrayList<Product> listOfProducts = dao.getAllProducts();
	%>
	
	<div class="container p-5">
		<div class="row">
			<%
				for (int i = 0; i < listOfProducts.size(); i++){
					Product product = listOfProducts.get(i);
					DecimalFormat df = new DecimalFormat("#,##0");
					String dfR1 = df.format(product.getUnitPrice());
			%>
			<div class="col-5 mb-5" id="coll">
				<h3 class="mb-5"><%=product.getPname() %></h3>
				<img alt="" src="${pageContext.request.contextPath}/upload/<%=product.getFilename()%>" class="img-fluid"/>
				<p><%=product.getDescription() %></p>
				<p><%=dfR1 %>원</p>
				<p><a href="product.jsp?id=<%=product.getProductId() %>" class="btn btn-primary btn-sm mt-2">상세 정보</a></p>
			</div>
			<%
				}
			%>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>