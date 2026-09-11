<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- footer.jsp도 menu.jsp와 같은 이유로 스스로 로케일/번들을 설정한다. --%>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
		<!-- Start Footer Section -->
		<footer class="footer-section">
			<div class="container relative">



				<div class="row">
					<div class="col-lg-8">
						<div class="subscription-form">
							<h3 class="d-flex align-items-center"><span class="me-1"><img src="<%=request.getContextPath()%>/images/envelope-outline.svg" alt="Image" class="img-fluid"></span><span><fmt:message key="footer-newsletter" /></span></h3>

							<fmt:message key="footer-name-placeholder" var="footerNamePh" />
							<fmt:message key="footer-email-placeholder" var="footerEmailPh" />
							<form action="#" class="row g-3">
								<div class="col-auto">
									<input type="text" class="form-control" placeholder="${footerNamePh}">
								</div>
								<div class="col-auto">
									<input type="email" class="form-control" placeholder="${footerEmailPh}">
								</div>
								<div class="col-auto">
									<button class="btn btn-primary">
										<span class="fa fa-paper-plane"></span>
									</button>
								</div>
							</form>

						</div>
					</div>
				</div>

				<div class="row g-5 mb-5">
					<div class="col-lg-4">
						<div class="mb-4 footer-logo-wrap"><a href="#" class="footer-logo">CPShop<span>.</span></a></div>
						<p class="mb-4"><fmt:message key="footer-tagline" /></p>

						<ul class="list-unstyled custom-social">
							<li><a href="#"><span class="fa fa-brands fa-facebook-f"></span></a></li>
							<li><a href="#"><span class="fa fa-brands fa-twitter"></span></a></li>
							<li><a href="#"><span class="fa fa-brands fa-instagram"></span></a></li>
							<li><a href="#"><span class="fa fa-brands fa-linkedin"></span></a></li>
						</ul>
					</div>

					<div class="col-lg-8">
						<div class="row links-wrap">
							<div class="col-6 col-sm-6 col-md-3">
								<ul class="list-unstyled">
									<li><a href="#"><fmt:message key="menu-product-list" /></a></li>
									<li><a href="#"><fmt:message key="menu-product-register" /></a></li>
									<li><a href="#"><fmt:message key="report" /></a></li>

								</ul>
							</div>
						</div>
					</div>

				</div>

				<div class="border-top copyright">
					<div class="row pt-4">
						<div class="col-lg-6">
							<p class="mb-2 text-center text-lg-start">Copyright &copy;<script>document.write(new Date().getFullYear());</script> CheolPang All Rights Reserved.<!-- License information: https://untree.co/license/ -->
          </p>
						</div>

						<div class="col-lg-6 text-center text-lg-end">
							<ul class="list-unstyled d-inline-flex ms-auto">
								<li class="me-4"><a href="#"><fmt:message key="footer-terms" /></a></li>
								<li><a href="#"><fmt:message key="footer-privacy" /></a></li>
							</ul>
						</div>

					</div>
				</div>

			</div>
		</footer>
		<!-- End Footer Section -->
</fmt:bundle>
	<script src="<%=request.getContextPath()%>/js/bootstrap.bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/tiny-slider.js"></script>
	<script src="<%=request.getContextPath()%>/js/custom.js"></script>
	<script src="<%=request.getContextPath()%>/js/validation.js"></script>
	<script src="<%=request.getContextPath()%>/js/basket.js"></script>
	<%@ include file="aiChatWidget.jsp"%>
