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
	<div class="untree_co-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12 mb-5 mb-md-0">
					<h2 class="h3 mb-3 text-black">배송 정보 입력</h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<%
						String cartId = session.getId();
						%>
						<form action="./processShippingInfo.jsp" method="POST">
							<input type="hidden" value="<%=cartId %>" name="cartId">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="customerName" class="text-black">성명 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="customerName" name="customerName"
										placeholder="받는 분 성명을 입력하세요." required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="shippingDate" class="text-black">배송일 <span
										class="text-danger">*</span></label> <input type="date"
										class="form-control" id="shippingDate" name="shippingDate"
										placeholder="YYYY-MM-DD" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="shippingAddress" class="text-black">주소 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="shippingAddress" name="shippingAddress"
										placeholder="주소를 입력하세요." required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="shippingPostNumber" class="text-black">우편번호 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="shippingPostNumber" name="shippingPostNumber"
										placeholder="우편번호를 입력하세요." required>
								</div>
							</div>
							<div class="form-group">
							<input type="submit" class="btn btn-primary me-1 text-start" id="Add" value="등록">
							<a href="./cart.jsp" class="btn btn-dark me-1 text-start">이전</a>
							<a href="./checkOutCancelled.jsp" class="btn btn-danger text-end">취소</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>