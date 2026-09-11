<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<h1>로그인</h1>
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
					<h2 class="h3 mb-3 text-black">회원 로그인</h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<form action="./processLoginMember.jsp" method="post">
							<%
								String error = request.getParameter("error");
								if (error != null) {
									out.println("<div class='alert alert-danger' role='alert'>권한이 없는 계정입니다. 아이디 또는 비밀번호를 다시 확인해주세요.</div>");
								}
							%>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="inputId" class="text-black">아이디 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="inputId" name="id" placeholder="아이디를 입력하세요." required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="inputPw" class="text-black">비밀번호 <span
										class="text-danger">*</span></label> <input type="password"
										class="form-control" id="inputPw" name="pw" placeholder="비밀번호를 입력하세요." required>
								</div>
							</div>

							<input type="submit" value="로그인" class="btn btn-primary me-1">
							<a href="./addMember.jsp" class="btn btn-dark">회원가입</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>