<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 관리자 상품 등록</title>
</head>
<body>
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="bundle.message">
		<%@ include file="menu.jsp" %>
		
		<div class="container-fluid">
			<div class="row">
				<div>
					<ul class="nav justify-content-center" id="titleLine">
						<li class="nav-item text-success">
							<h1><b><fmt:message key="title"/></b></h1>
						</li>
					</ul>
				</div>
			</div>
		</div>
		

			<div class="row">
				<div class="col">
					<form action="./processAddProduct.jsp" name="newProduct" method="POST" enctype="multipart/form-data" class="p-5 m-3">
						
						<div class="mb-3">
					    	<label for="productId" class="form-label"><fmt:message key="productId"/></label>
					    	<input type="text" class="form-control" id="productId" name="productId">
					    	<div class="form-text">상품의 코드를 입력해주세요.</div>
					    </div>
					    
						<div class="mb-3">
					    	<label for="productName" class="form-label"><fmt:message key="pname"/></label>
					    	<input type="text" class="form-control" id="productName" name="productName">
					    	<div class="form-text">상품명을 입력해주세요.</div>
					    </div>
					    
						<div class="mb-3">
					    	<label for="unitPrice" class="form-label"><fmt:message key="unitPrice"/></label>
					    	<input type="text" class="form-control" id="unitPrice" name="unitPrice">
					    	<div class="form-text">상품 가격을 입력해주세요.</div>
					    </div>
					    
						<div class="mb-3">
					    	<label for="description" class="form-label"><fmt:message key="description"/></label>
					    	<textarea cols="50" rows="5" class="form-control" id="description" name="description"></textarea>
					    	<div class="form-text">상품에 대한 상세정보를 입력해주세요.</div>
					    </div>
					    
						<div class="mb-3">
					    	<label for="manufacturer" class="form-label"><fmt:message key="manufacturer"/></label>
					    	<input type="text" class="form-control" id="manufacturer" name="manufacturer">
					    	<div class="form-text">상품의 제조사를 입력해주세요.</div>
					    </div>
					    
						<div class="mb-3">
					    	<label for="category" class="form-label"><fmt:message key="category"/></label>
					    	<input type="text" class="form-control" id="category" name="category">
					    	<div class="form-text">상품의 분류를 입력해주세요.</div>
					 	</div>
					 	
						<div class="mb-3">
					    	<label for="unitsInStock" class="form-label"><fmt:message key="unitsInStock"/></label>
					    	<input type="text" class="form-control" id="unitsInStock" name="unitsInStock">
					    	<div class="form-text">상품의 재고수량을 입력해주세요.</div>
					 	</div>
					 	
						<div class="mb-3">
					    	<label for="condition class="form-label"><fmt:message key="condition"/></label>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="condition" id="condition1" value="New" checked>
							  <label class="form-check-label" for="condition1"><fmt:message key="condition_New"/></label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="condition" id="condition2" value="Old">
							  <label class="form-check-label" for="condition2"><fmt:message key="condition_Old"/></label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="condition" id="condition3" value="Refurbished">
							  <label class="form-check-label" for="condition3"><fmt:message key="condition_Refurbished"/></label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="condition" id="condition4" value="Recycled">
							  <label class="form-check-label" for="condition4"><fmt:message key="condition_Recycling"/></label>
							</div>
							<br>
							<div class="mb-3">
						    	<label for="imageUpload" class="form-label"><fmt:message key="imageUpload"/></label>
						    	<input type="file" class="form-control" id="img" name="imageUpload">
						    	<div class="form-text"><fmt:message key="productImage"/></div>
						 	</div>
					 	</div>
	
					 	
					 
						<button type="button" onclick="checkAddProduct()" class="btn btn-primary"><fmt:message key="submit"/></button>
					</form>
				</div>
			</div>
		</div>
		
		<%@ include file="footer.jsp" %>
	</fmt:bundle>
</body>
</html>