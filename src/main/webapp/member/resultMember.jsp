<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 회원 정보</title>
</head>
<body>
	<%@ include file="../menu.jsp" %>
		<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>회원 정보</h1>
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
			<%
				String msg = request.getParameter("msg");
				if(msg != null) {
					if (msg.equals("")) {
						out.print("회원정보가 존재하지 않습니다.");
					} else if (msg.equals("1")) {
						out.print("회원가입이 완료되었습니다. 다시 로그인해주세요.");
					} else if (msg.equals("2")) {
						String loginId = (String) session.getAttribute("sessionId");
						out.print(loginId+"님 로그인되었습니다. 환영합니다.");
					}
				} else {
					out.print("회원정보가 존재하지 않습니다.");
				}
			%>
			</div>
		</div>
	</div>
	<%@ include file="/footer.jsp" %>
</body>
</html>