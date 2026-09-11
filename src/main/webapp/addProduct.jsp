<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String adminCheckId = (String) session.getAttribute("sessionId");
	if (!"admin".equals(adminCheckId)) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 관리자 상품 등록</title>
</head>
<body>
	<fmt:setLocale value='<%=request.getParameter("language")%>' />
	<fmt:bundle basename="bundle.message">
		<%@ include file="menu.jsp"%>

		
			<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="title" /></h1>
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
					<h2 class="h3 mb-3 text-black"><fmt:message key="add-product-heading" /></h2>
					<% if ("dup".equals(request.getParameter("error"))) { %>
					<div class="alert alert-danger" role="alert"><fmt:message key="error-dup" /></div>
					<% } else if ("upload".equals(request.getParameter("error"))) { %>
					<div class="alert alert-danger" role="alert"><fmt:message key="error-upload-image" /></div>
					<% } else if ("db".equals(request.getParameter("error"))) { %>
					<div class="alert alert-danger" role="alert"><fmt:message key="error-db-save" /></div>
					<% } %>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<fmt:message key="ph-productId" var="phProductId" />
						<fmt:message key="ph-pname" var="phPname" />
						<fmt:message key="ph-unitPrice" var="phUnitPrice" />
						<fmt:message key="ph-description" var="phDescription" />
						<fmt:message key="ph-manufacturer" var="phManufacturer" />
						<fmt:message key="ph-category" var="phCategory" />
						<fmt:message key="ph-unitsInStock" var="phUnitsInStock" />
						<form action="./processAddProduct.jsp" name="newProduct"
							method="POST" enctype="multipart/form-data">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="productId" class="text-black"><fmt:message key="productId" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="productId" name="productId"
										placeholder="${phProductId}">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="productName" class="text-black"><fmt:message key="pname" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="productName" name="productName"
										placeholder="${phPname}">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="unitPrice" class="text-black"><fmt:message key="unitPrice" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="unitPrice" name="unitPrice"
										placeholder="${phUnitPrice}">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="description" class="text-black"><fmt:message key="description" /></label>
									<textarea rows="5" class="form-control" id="description"
										name="description" placeholder="${phDescription}"></textarea>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="manufacturer" class="text-black"><fmt:message key="manufacturer" /></label>
									<input type="text" class="form-control" id="manufacturer"
										name="manufacturer" placeholder="${phManufacturer}">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="category" class="text-black"><fmt:message key="category" /></label>
									<input type="text" class="form-control" id="category"
										name="category" placeholder="${phCategory}">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="unitsInStock" class="text-black"><fmt:message key="unitsInStock" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="unitsInStock" name="unitsInStock"
										placeholder="${phUnitsInStock}">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label class="text-black"><fmt:message key="condition" /></label>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="condition"
											id="condition1" value="New" checked> <label
											class="form-check-label" for="condition1"><fmt:message
												key="condition_New" /></label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="condition"
											id="condition2" value="Old"> <label
											class="form-check-label" for="condition2"><fmt:message
												key="condition_Old" /></label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="condition"
											id="condition3" value="Refurbished"> <label
											class="form-check-label" for="condition3"><fmt:message
												key="condition_Refurbished" /></label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="condition"
											id="condition4" value="Recycled"> <label
											class="form-check-label" for="condition4"><fmt:message
												key="condition_Recycling" /></label>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="img" class="text-black"><fmt:message key="imageUpload" /> <span
										class="text-danger">*</span></label> <input type="file"
										class="form-control" id="img" name="imageUpload">
									<div class="form-text"><fmt:message key="productImage" /></div>
								</div>
							</div>

							<button type="button" onclick="checkAddProduct()" class="btn btn-primary">
								<fmt:message key="submit" />
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
		<%@ include file="footer.jsp"%>
	</fmt:bundle>
</body>
</html>