<%@page import="dto.Product"%>
<%@page import="dao.ProductDAO"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}
%>
<%
	// 관리자(admin) 계정만 접근 허용
	String adminCheckId = (String) session.getAttribute("sessionId");
	if (!"admin".equals(adminCheckId)) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}

	Product product = ProductDAO.getInstance().getProductById(request.getParameter("id"));
	if (product == null) {
		response.sendRedirect("exceptionNoProductId.jsp");
		return;
	}

	// 상품 상태: DB에 "new"(초기 데이터) / "New"(상품 등록 폼)가 섞여 있으므로 대소문자 구분 없이 비교.
	// 어느 것에도 맞지 않으면 첫 번째(New)를 선택해 둔다.
	String[][] conditions = {
		{"New", "신규 상품"}, {"Old", "중고 제품"}, {"Refurbished", "재생 제품"}, {"Recycled", "재활용 제품"}
	};
	int checkedIndex = 0;
	for (int k = 0; k < conditions.length; k++) {
		if (conditions[k][0].equalsIgnoreCase(product.getCondition())) checkedIndex = k;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 상품정보수정</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>상품정보수정</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="shop-section">
		<div class="container">
			<h2 class="h3 mb-3 text-black">상품 정보 수정</h2>
			<form action="./processUpdateProduct.jsp" name="updateProduct" method="POST" enctype="multipart/form-data">
				<div class="row g-5">
					<!-- 왼쪽 : 상품 상세와 같은 이미지 영역 -->
					<div class="col-lg-5">
						<div class="product-detail-image">
							<img alt="현재 상품 이미지" src="${pageContext.request.contextPath}/upload/<%=product.getFilename() %>">
						</div>
						<div class="mt-3">
							<label for="productImage" class="text-black">이미지 수정 (선택)</label>
							<input type="file" class="form-control" id="productImage" name="productImage">
						</div>
					</div>

					<!-- 오른쪽 : 입력 폼 -->
					<div class="col-lg-7">
						<div class="p-3 p-lg-5 border bg-white signForm">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="productId" class="text-black">상품 코드</label>
									<input type="text" class="form-control" id="productId" name="productId"
										value="<%=product.getProductId() %>" readonly>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="productName" class="text-black">상품명 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="productName" name="productName"
										placeholder="상품명을 입력하세요." value="<%=nvl(product.getPname()) %>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-6 mb-3">
									<label for="unitPrice" class="text-black">상품 가격 <span
										class="text-danger">*</span></label> <input type="number"
										class="form-control" id="unitPrice" name="unitPrice"
										placeholder="상품 가격을 입력하세요." value="<%=product.getUnitPrice() %>">
								</div>
								<div class="col-md-6 mb-3">
									<label for="unitsInStock" class="text-black">재고 수 <span
										class="text-danger">*</span></label> <input type="number"
										class="form-control" id="unitsInStock" name="unitsInStock"
										placeholder="재고 수량을 입력하세요." value="<%=product.getUnitsInStock() %>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-6 mb-3">
									<label for="manufacturer" class="text-black">제조사</label>
									<input type="text" class="form-control" id="manufacturer" name="manufacturer"
										placeholder="제조사를 입력하세요." value="<%=nvl(product.getManufacturer()) %>">
								</div>
								<div class="col-md-6 mb-3">
									<label for="category" class="text-black">상품 분류</label>
									<input type="text" class="form-control" id="category" name="category"
										placeholder="상품 분류를 입력하세요." value="<%=nvl(product.getCategory()) %>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="description" class="text-black">상품 설명</label>
									<textarea rows="5" class="form-control" id="description" name="description"
										placeholder="상품에 대한 상세정보를 입력하세요."><%=nvl(product.getDescription()) %></textarea>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label class="text-black">상품 상태</label>
									<%
									for (int k = 0; k < conditions.length; k++) {
									%>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="condition"
											id="condition<%=k + 1 %>" value="<%=conditions[k][0] %>" <%=k == checkedIndex ? "checked" : "" %>>
										<label class="form-check-label" for="condition<%=k + 1 %>"><%=conditions[k][1] %></label>
									</div>
									<%
									}
									%>
								</div>
							</div>

							<button type="button" onclick="checkEditProduct()" class="btn btn-primary me-1">수정하기</button>
							<a href="editProduct.jsp?edit=update" class="btn btn-dark">목록</a>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>
