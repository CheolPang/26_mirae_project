<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="shortcut icon" href="favicon.png">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
	<link href="css/tiny-slider.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="myStyle.css" rel="stylesheet">
	<title>CPShop</title>
</head>
<body>
<!-- Start Header/Navigation -->
		<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
				<a href="#" class="navbar-brand">관리자 모드<span>.</span></a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurniAdmin" aria-controls="navbarsFurniAdmin" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurniAdmin">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">					
						<li><a class="nav-link" href="addProduct.jsp">상품 등록</a></li><!-- products register-->
						<li><a class="nav-link" href="editProduct.jsp?edit=update">상품 수정</a></li><!-- products update-->
						<li><a class="nav-link" href="editProduct.jsp?edit=delete">상품 삭제</a></li><!-- products delete-->
					</ul>
				</div>

			</div>
				
		</nav>
		<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
				<a class="navbar-brand" href="welcome.jsp">CPShop<span>.</span></a>

				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurni">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
						<li class="nav-item time">
							<a class="nav-link" href="welcome.jsp">
								<small>
									<% 
									 	Date day = new java.util.Date();
										String am_pm;
										int hour = day.getHours();
										int minute = day.getMinutes();
										int second = day.getSeconds();
										
										String rHour = String.valueOf(hour);
									    String rMin = String.valueOf(minute);
									    String rSec = String.valueOf(second);
										
										if(hour/12==0) {
											am_pm = "AM";
										} else {
											am_pm = "PM";
											hour -= 12;
										}
										
										if (hour < 10) {
											rHour = "0" + String.valueOf(hour);
										}
										if (minute < 10) {
											rMin = "0" + String.valueOf(minute);
										}
										if (second < 10) {
											rSec = "0" + String.valueOf(second);
										}
										
										
										String CT = rHour + ":" + rMin + ":" + rSec + " " + am_pm;
										out.print("마지막 접속 시각: "+CT+"\n");
									%>
								</small>
							</a><!-- products list -->
						</li>
						<li><a class="nav-link" href="products.jsp">상품 목록</a><!-- products list --></li>
						<li><a class="nav-link" href="about.html">문의</a></li><!-- contact -->

						        <li class="nav-item dropdown">
						          <a class="nav-link dropdown-toggle" href="#" id="navbarLangDropdownLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						            언어
						          </a>
						          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarLangDropdownLink">
						            <li><a class="dropdown-item" href="?language=ko">Korean</a></li>
						            <li><a class="dropdown-item" href="?language=en">English</a></li>
						          </ul>
						        </li>
					</ul>

					<ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarMyPageDropdownLink" role="button" data-bs-toggle="dropdown" aria-expanded="false" href="#"><img src="images/user.svg"></a>
							<ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarMyPageDropdownLink">
						            <li><a class="dropdown-item" href="login.jsp">회원 로그인</a></li>
						            <li><a class="dropdown-item" href="logout.jsp">회원 로그아웃</a></li>
						            <li><a class="dropdown-item" href="#">회원 가입</a></li>
						            <li><a class="dropdown-item" href="#">회원 수정</a></li>
						            <li><hr class="dropdown-divider"></li>
						            <li><a class="dropdown-item" href="#">주문 정보</a></li>
						            <li><a class="dropdown-item" href="#">배송 정보</a></li>
							</ul>
						</li>
						<li><a class="nav-link" href="cart.jsp"><img src="images/cart.svg"></a></li>
					</ul>
				</div>

			</div>
				
		</nav>
		<!-- End Header/Navigation -->

</body>