<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 배송 정보</title>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>배송 정보</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->
	<div class="untree_co-section before-footer-section">

		<div class="container">
			<!-- <p>배송정보 등록</p> -->
			<div class="row mb-5">
				<%
              	String cartId = session.getId();
              %>
				<form action="./processShippingInfo.jsp" method="POST">
					<input type="hidden" value="<%=cartId %>" name="cartId">
					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">성명</span> <input
							type="text" class="form-control" placeholder="" aria-label="성명"
							aria-describedby="basic-addon1" id="customerName"
							name="customerName">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">배송일</span> <input
							type="date" class="form-control" placeholder="YYYY-MM-DD"
							aria-label="배송일" aria-describedby="basic-addon1"
							id="shippingDate" name="shippingDate">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">주소</span> <input
							type="text" class="form-control" placeholder="" aria-label="주소"
							aria-describedby="basic-addon1" id="shippingAddress"
							name="shippingAddress">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">우편번호</span> <input
							type="text" class="form-control" placeholder="" aria-label="우편번호"
							aria-describedby="basic-addon1" id="shippingPostNumber"
							name="shippingPostNumber">
					</div>
					<div class="input-group mb-3">
						<a href="./cart.jsp" class="btn btn-dark mx-1">이전</a> <input
							type="submit" class="form-control btn btn-primary mx-1"
							placeholder="" id="Add" value="등록"> <a
							href="./checkOutCancelled.jsp" class="btn btn-danger mx-1">취소</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>