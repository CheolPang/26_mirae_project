<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 404</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
		<div class="container-fluid">
			<div class="row">
				<div>
					<ul class="nav justify-content-center" id="titleLine">
						<li class="nav-item text-success">
							<h1><b>페이지 오류</b></h1>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col p-5 flexcenter">
					<h2>페이지를 찾을 수 없습니다.</h2>
					<a href="./products.jsp"><button class="btn btn-primary">상품 목록</button></a>
				</div>
			</div>
		</div>
	<%@ include file="footer.jsp" %>
</body>
</html>