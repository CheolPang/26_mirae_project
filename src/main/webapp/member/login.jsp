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
		<div class="container-fluid">
			<div class="row">
				<div>
					<ul class="nav justify-content-center" id="titleLine">
						<li class="nav-item text-success">
							<h1><b>로그인</b></h1>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col p-5">
					<form action="./processLoginMember.jsp" method="post">
						<div class="error">
							<%
								String error = request.getParameter("error");
								if (error != null) {
									out.println("<div class='alert alert-danger' role='alert'>권한이 없는 계정입니다. 아이디 또는 비밀번호를 다시 확인해주세요.</div>");
								}
							%>
						</div>

						<div class="mb-3">
						    <label for="inputId" class="form-label">아이디</label>
						    <input type="text" class="form-control" id="inputId" aria-describedby="emailHelp" name="id">
					    	<div id="idHelp" class="form-text">아이디를 입력해주세요.</div>
						</div>
						<div class="mb-3">
					    	<label for="inputPw" class="form-label">비밀번호</label>
					    	<input type="password" class="form-control" id="inputPw" name="pw">
					    	<div id="pwHelp" class="form-text">비밀번호를 입력해주세요.</div>
					  	</div> 
					  	<button type="submit" class="btn btn-primary">로그인</button>
					</form>
				</div>
			</div>
		</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>