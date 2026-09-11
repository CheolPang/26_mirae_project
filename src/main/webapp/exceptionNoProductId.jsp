<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 상품아이디 오류</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
		<div class="container-fluid">
			<div class="row">
				<div>
					<ul class="nav justify-content-center" id="titleLine">
						<li class="nav-item text-success">
							<h1><b><fmt:message key="error-product-id-title" /></b></h1>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col p-5 flexcenter">
					<h2><fmt:message key="error-product-not-found" /></h2>
					<a href="./products.jsp" class="btn btn-primary" role="button"><fmt:message key="menu-product-list" /></a>
				</div>
			</div>
		</div>
	<%@ include file="footer.jsp" %>
</body>
</html>
</fmt:bundle>
