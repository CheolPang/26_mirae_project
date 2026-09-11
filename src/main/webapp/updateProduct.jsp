<%@page import="dto.Product"%>
<%@page import="dao.ProductDAO"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%!
	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}
%>
<%
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

	String[][] conditions = {
		{"New", "condition_New"}, {"Old", "condition_Old"}, {"Refurbished", "condition_Refurbished"}, {"Recycled", "condition_Recycling"}
	};
	int checkedIndex = 0;
	for (int k = 0; k < conditions.length; k++) {
		if (conditions[k][0].equalsIgnoreCase(product.getCondition())) checkedIndex = k;
	}
%>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | <fmt:message key="update-product-title" /></title>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="update-product-title" /></h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="shop-section">
		<div class="container">
			<h2 class="h3 mb-3 text-black"><fmt:message key="update-product-title" /></h2>
			<% if ("upload".equals(request.getParameter("error"))) { %>
			<div class="alert alert-danger" role="alert"><fmt:message key="error-upload-image" /></div>
			<% } else if ("db".equals(request.getParameter("error"))) { %>
			<div class="alert alert-danger" role="alert"><fmt:message key="error-db-save" /></div>
			<% } %>
			<form action="./processUpdateProduct.jsp?id=<%=product.getProductId() %>" name="updateProduct" method="POST" enctype="multipart/form-data">
				<div class="row g-5">
					<!-- 왼쪽 : 상품 상세와 같은 이미지 영역 -->
					<div class="col-lg-5">
						<fmt:message key="current-image" var="currentImageAlt" />
						<div class="product-detail-image">
							<img alt="${currentImageAlt}" src="${pageContext.request.contextPath}/upload/<%=product.getFilename() %>">
						</div>
						<div class="mt-3">
							<label for="productImage" class="text-black"><fmt:message key="edit-image-optional" /></label>
							<input type="file" class="form-control" id="productImage" name="productImage">
						</div>
					</div>

					<!-- 오른쪽 : 입력 폼 -->
					<div class="col-lg-7">
						<div class="p-3 p-lg-5 border bg-white signForm">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="productId" class="text-black"><fmt:message key="productId" /></label>
									<input type="text" class="form-control" id="productId" name="productId"
										value="<%=product.getProductId() %>" readonly>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<fmt:message key="ph-pname" var="phPname" />
									<label for="productName" class="text-black"><fmt:message key="pname" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="productName" name="productName"
										placeholder="${phPname}" value="<%=nvl(product.getPname()) %>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-6 mb-3">
									<fmt:message key="ph-unitPrice" var="phUnitPrice" />
									<label for="unitPrice" class="text-black"><fmt:message key="unitPrice" /> <span
										class="text-danger">*</span></label> <input type="number"
										class="form-control" id="unitPrice" name="unitPrice"
										placeholder="${phUnitPrice}" value="<%=product.getUnitPrice() %>">
								</div>
								<div class="col-md-6 mb-3">
									<fmt:message key="ph-unitsInStock" var="phUnitsInStock" />
									<label for="unitsInStock" class="text-black"><fmt:message key="unitsInStock" /> <span
										class="text-danger">*</span></label> <input type="number"
										class="form-control" id="unitsInStock" name="unitsInStock"
										placeholder="${phUnitsInStock}" value="<%=product.getUnitsInStock() %>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-6 mb-3">
									<fmt:message key="ph-manufacturer" var="phManufacturer" />
									<label for="manufacturer" class="text-black"><fmt:message key="manufacturer" /></label>
									<input type="text" class="form-control" id="manufacturer" name="manufacturer"
										placeholder="${phManufacturer}" value="<%=nvl(product.getManufacturer()) %>">
								</div>
								<div class="col-md-6 mb-3">
									<fmt:message key="ph-category" var="phCategory" />
									<label for="category" class="text-black"><fmt:message key="category" /></label>
									<input type="text" class="form-control" id="category" name="category"
										placeholder="${phCategory}" value="<%=nvl(product.getCategory()) %>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<fmt:message key="ph-description" var="phDescription" />
									<label for="description" class="text-black"><fmt:message key="description" /></label>
									<textarea rows="5" class="form-control" id="description" name="description"
										placeholder="${phDescription}"><%=nvl(product.getDescription()) %></textarea>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label class="text-black"><fmt:message key="condition" /></label>
									<%
									for (int k = 0; k < conditions.length; k++) {
									%>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="condition"
											id="condition<%=k + 1 %>" value="<%=conditions[k][0] %>" <%=k == checkedIndex ? "checked" : "" %>>
										<label class="form-check-label" for="condition<%=k + 1 %>"><fmt:message key="<%=conditions[k][1]%>" /></label>
									</div>
									<%
									}
									%>
								</div>
							</div>

							<button type="button" onclick="checkEditProduct()" class="btn btn-primary me-1"><fmt:message key="update-btn" /></button>
							<a href="editProduct.jsp?edit=update" class="btn btn-dark"><fmt:message key="list-btn" /></a>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>
</fmt:bundle>
