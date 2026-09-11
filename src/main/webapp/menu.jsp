<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String sessionId = (String) session.getAttribute("sessionId");

	String langQuery = request.getQueryString() == null ? ""
			: request.getQueryString().replaceAll("(^|&)language=[^&]*", "").replaceFirst("^&", "");
	String langHref = ("?" + (langQuery.isEmpty() ? "" : langQuery + "&") + "language=")
			.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;");
%>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.png">
	<link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/tiny-slider.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/myStyle.css" rel="stylesheet">
	<title>CPShop</title>
</head>
<body>
<!-- Start Header/Navigation -->
		<c:choose>
			<c:when test="${sessionId eq 'admin'}">
					<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
				<a href="#" class="navbar-brand"><fmt:message key="menu-admin-mode" /><span>.</span></a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurniAdmin" aria-controls="navbarsFurniAdmin" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurniAdmin">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
						<li><a class="nav-link" href="<c:url value="/addProduct.jsp"/>"><fmt:message key="menu-product-register" /></a></li><!-- products register-->
						<li><a class="nav-link" href="<c:url value="/editProduct.jsp?edit=update"/>"><fmt:message key="menu-product-update" /></a></li><!-- products update-->
						<li><a class="nav-link" href="<c:url value="/editProduct.jsp?edit=delete"/>"><fmt:message key="menu-product-delete" /></a></li><!-- products delete-->
					</ul>
				</div>

			</div>

		</nav>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
		<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
				<a class="navbar-brand" href="<c:url value="/welcome.jsp"/>">CPShop<span>.</span></a>

				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurni">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
						<li class="nav-item time">
							<a class="nav-link" href="<c:url value="/welcome.jsp"/>">
								<small>
									<%
										LocalDateTime day = LocalDateTime.now();
										String am_pm;
										int hour = day.getHour();
										int minute = day.getMinute();
										int second = day.getSecond();

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
									%>
									<fmt:message key="menu-last-access"><fmt:param value="<%=CT%>"/></fmt:message>
								</small>
							</a><!-- products list -->
						</li>
						<li><a class="nav-link" href="<c:url value="/products.jsp"/>"><fmt:message key="menu-product-list" /></a><!-- products list --></li>
						<li><a class="nav-link" href="<c:url value='/BoardListAction.do?pageNum=1'/>"><fmt:message key="menu-board" /></a></li><!-- contact -->
						<li><a class="nav-link" href="<c:url value="/contact.jsp"/>"><fmt:message key="report" /></a></li><!-- contact -->

						        <li class="nav-item dropdown">
						          <a class="nav-link dropdown-toggle" href="#" id="navbarLangDropdownLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						            <fmt:message key="menu-language" />
						          </a>
						          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarLangDropdownLink">
						            <li><a class="dropdown-item" href="<%=langHref %>ko">Korean</a></li>
						            <li><a class="dropdown-item" href="<%=langHref %>en">English</a></li>
						          </ul>
						        </li>
					</ul>

					<ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarMyPageDropdownLink" role="button" data-bs-toggle="dropdown" aria-expanded="false" href="#"><img src="<%=request.getContextPath()%>/images/user.svg"></a>
							<ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarMyPageDropdownLink">
									<c:choose>
										<c:when test="${empty sessionId}">
								            <li><a class="dropdown-item" href="<c:url value="/member/login.jsp"/>"><fmt:message key="menu-login" /></a></li>
								            <li><a class="dropdown-item" href="<c:url value="/member/addMember.jsp"/>"><fmt:message key="menu-signup" /></a></li>
								        </c:when>
								        <c:otherwise>
								            <li><a class="dropdown-item"><fmt:message key="menu-logged-in-as"><fmt:param value="<%=sessionId%>"/></fmt:message></a></li>
								            <li><a class="dropdown-item" href="<c:url value="/member/logout.jsp"/>"><fmt:message key="menu-logout" /></a></li>
								            <li><a class="dropdown-item" href="<c:url value="/member/updateMember.jsp"/>"><fmt:message key="menu-update-member" /></a></li>
							            </c:otherwise>
						            </c:choose>
							</ul>
						</li>
						<li><a class="nav-link" href="<c:url value="/cart.jsp"/>"><img src="<%=request.getContextPath()%>/images/cart.svg"></a></li>
					</ul>
				</div>

			</div>

		</nav>
		<!-- End Header/Navigation -->

</body>
</fmt:bundle>
