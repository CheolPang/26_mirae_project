<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | Login</title>
</head>
<body>
	<%@ include file="../menu.jsp" %>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="menu-login" /></h1>
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
					<h2 class="h3 mb-3 text-black"><fmt:message key="member-login-subheading" /></h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<form action="./processLoginMember.jsp" method="post">
							<%
								String error = request.getParameter("error");
								if (error != null) {
							%>
							<div class='alert alert-danger' role='alert'><fmt:message key="member-login-error" /></div>
							<%
								}
							%>
							<fmt:message key="ph-id" var="phId" />
							<fmt:message key="ph-password" var="phPassword" />
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="inputId" class="text-black"><fmt:message key="member-id-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="inputId" name="id" placeholder="${phId}" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="inputPw" class="text-black"><fmt:message key="member-pw-label" /> <span
										class="text-danger">*</span></label> <input type="password"
										class="form-control" id="inputPw" name="pw" placeholder="${phPassword}" required>
								</div>
							</div>

							<fmt:message key="menu-login" var="loginBtnLabel" />
							<input type="submit" value="${loginBtnLabel}" class="btn btn-primary me-1">
							<a href="./addMember.jsp" class="btn btn-dark"><fmt:message key="menu-signup" /></a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>
</fmt:bundle>
