<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 문의</title>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>
							<fmt:message key="report" />
						</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->
	<!-- Start Contact Form -->
	<div class="untree_co-section">
		<div class="container">

			<div class="block">
				<div class="row justify-content-center">


					<div class="col-md-8 col-lg-8 pb-4">


						<div class="row mb-5">
							<h3 class="mb-3"><fmt:message key="contact-heading" /></h3>
							<div class="col-lg-4">

								<div
									class="service no-shadow align-items-center link horizontal d-flex active"
									data-aos="fade-left" data-aos-delay="0">
									<div class="service-icon color-1 mb-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" class="bi bi-geo-alt-fill"
											viewBox="0 0 16 16">
                      <path
												d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z" />
                    </svg>

									</div>
									<!-- /.icon -->
									<div class="service-contents">
										<p>서울특별시 서초구 서초대로 123</p>
									</div>
									<!-- /.service-contents-->
								</div>
								<!-- /.service -->
							</div>

							<div class="col-lg-4">
								<div
									class="service no-shadow align-items-center link horizontal d-flex active"
									data-aos="fade-left" data-aos-delay="0">
									<div class="service-icon color-1 mb-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" class="bi bi-envelope-fill"
											viewBox="0 0 16 16">
                      <path
												d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555zM0 4.697v7.104l5.803-3.558L0 4.697zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757zm3.436-.586L16 11.801V4.697l-5.803 3.546z" />
                    </svg>
									</div>
									<!-- /.icon -->
									<div class="service-contents">
										<p>support@cpshop.com</p>
									</div>
									<!-- /.service-contents-->
								</div>
								<!-- /.service -->
							</div>

							<div class="col-lg-4">
								<div
									class="service no-shadow align-items-center link horizontal d-flex active"
									data-aos="fade-left" data-aos-delay="0">
									<div class="service-icon color-1 mb-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" class="bi bi-telephone-fill"
											viewBox="0 0 16 16">
                      <path fill-rule="evenodd"
												d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z" />
                    </svg>
									</div>
									<!-- /.icon -->
									<div class="service-contents">
										<p>02-1234-5678</p>
									</div>
									<!-- /.service-contents-->
								</div>
								<!-- /.service -->
							</div>
						</div>
						<h3 class="mb-3"><fmt:message key="faq-heading" /></h3>
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="false" aria-controls="collapseOne">
										<fmt:message key="faq-q-shipping" /></button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<strong><fmt:message key="faq-a-shipping-1" /></strong>
										<fmt:message key="faq-a-shipping-2" />
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										<fmt:message key="faq-q-return" /></button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<fmt:message key="faq-a-return" />
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree"
										aria-expanded="false" aria-controls="collapseThree">
										<fmt:message key="faq-q-cancel" /></button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<fmt:message key="faq-a-cancel" />
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFour"
										aria-expanded="false" aria-controls="collapseFour">
										<fmt:message key="faq-q-payment" /></button>
								</h2>
								<div id="collapseFour" class="accordion-collapse collapse"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<fmt:message key="faq-a-payment" />
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFive"
										aria-expanded="false" aria-controls="collapseFive">
										<fmt:message key="faq-q-assembly" /></button>
								</h2>
								<div id="collapseFive" class="accordion-collapse collapse"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<fmt:message key="faq-a-assembly" />
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseSix"
										aria-expanded="false" aria-controls="collapseSix">
										<fmt:message key="faq-q-warranty" /></button>
								</h2>
								<div id="collapseSix" class="accordion-collapse collapse"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<fmt:message key="faq-a-warranty" />
									</div>
								</div>
							</div>
						</div>

					</div>

				</div>

			</div>

		</div>


	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
</fmt:bundle>
