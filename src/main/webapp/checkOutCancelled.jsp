<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 주문 취소</title>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>주문 취소</h1>
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
				<div class='alert alert-danger mb-1' role='alert'>
					<h3>
						<b>주문이 취소되었습니다.</b>
					</h3>
					<h6 class="mt-2 mb-0">
						<b>주문이 취소되어 장바구니에 상품이 다시 담겼습니다.</b>
					</h6>
				</div>
			</div>
			<a href="./products.jsp" class="btn btn-primary">상품 목록으로 이동</a>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>