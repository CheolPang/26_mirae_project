<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
							<h1><b>상품아이디 오류</b></h1>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col p-5 flexcenter">
					<h2>해당 상품이 존재하지 않습니다.</h2>
					<a href="./products.jsp" class="btn btn-primary" role="button">상품 목록</a>
				</div>
			</div>
		</div>
	<%@ include file="footer.jsp" %>
</body>
</html>