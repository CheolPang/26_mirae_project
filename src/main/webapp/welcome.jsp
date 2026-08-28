<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>CPShop | Welcome</title>
</head>
<body>
	
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="bundle.message">
		<%@ include file="menu.jsp" %>

		<!-- Start Hero Section -->
					<div class="hero">
						<div class="container">
							<div class="row justify-content-between">
								<div class="col-lg-5">
									<div class="intro-excerpt">
										<h1><fmt:message key="wtitle-1"/><br><fmt:message key="wtitle-2"/></h1>
										<p class="mb-4"><fmt:message key="wtitle-se"/></p>
										<p><a href="products.jsp" class="btn btn-white-outline me-2" role="button"><fmt:message key="product-list"/></a><a href="#" class="btn btn-white-outline"><fmt:message key="report"/></a></p>
									</div>
								</div>
								<div class="col-lg-7">
									<div class="hero-img-wrap">
										<img src="images/couch.png" class="img-fluid">
									</div>
								</div>
							</div>
						</div>
					</div>
				<!-- End Hero Section -->
		
				<!-- Start Product Section -->
				<div class="product-section">
					<div class="container">
						<div class="row">
		
							<!-- Start Column 1 -->
							<div class="col-md-12 col-lg-3 mb-5 mb-lg-0">
								<h2 class="mb-4 section-title"><fmt:message key="popular-list"/></h2>
								<p class="mb-4"><fmt:message key="popular-se"/></p>
								<p><a href="products.jsp" class="btn" role="button"><fmt:message key="deabogi"/></a></p>
							</div> 
							<!-- End Column 1 -->
		
							<!-- Start Column 2 -->
							<div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
								<a class="product-item" href="cart.html">
									<img src="images/product-1.png" class="img-fluid product-thumbnail">
									<h3 class="product-title">Nordic Chair</h3>
									<strong class="product-price">$50.00</strong>
		
									<span class="icon-cross">
										<img src="images/cross.svg" class="img-fluid">
									</span>
								</a>
							</div> 
							<!-- End Column 2 -->
		
							<!-- Start Column 3 -->
							<div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
								<a class="product-item" href="cart.html">
									<img src="images/product-2.png" class="img-fluid product-thumbnail">
									<h3 class="product-title">Kruzo Aero Chair</h3>
									<strong class="product-price">$78.00</strong>
		
									<span class="icon-cross">
										<img src="images/cross.svg" class="img-fluid">
									</span>
								</a>
							</div>
							<!-- End Column 3 -->
		
							<!-- Start Column 4 -->
							<div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
								<a class="product-item" href="cart.html">
									<img src="images/product-3.png" class="img-fluid product-thumbnail">
									<h3 class="product-title">Ergonomic Chair</h3>
									<strong class="product-price">$43.00</strong>
		
									<span class="icon-cross">
										<img src="images/cross.svg" class="img-fluid">
									</span>
								</a>
							</div>
							<!-- End Column 4 -->
		
						</div>
					</div>
				</div>
				<!-- End Product Section -->
		
				<!-- Start Why Choose Us Section -->
				<div class="why-choose-section">
					<div class="container">
						<div class="row justify-content-between">
							<div class="col-lg-6">
								<h2 class="section-title"><fmt:message key="whychoose-t"/></h2>
								<p><fmt:message key="whychoose-s"/></p>
		
								<div class="row my-5">
									<div class="col-6 col-md-6">
										<div class="feature">
											<div class="icon">
												<img src="images/truck.svg" alt="Image" class="imf-fluid">
											</div>
											<h3><fmt:message key="fast-shipping"/></h3>
											<p><fmt:message key="fast-shipping-se"/></p>
										</div>
									</div>
		
									<div class="col-6 col-md-6">
										<div class="feature">
											<div class="icon">
												<img src="images/bag.svg" alt="Image" class="imf-fluid">
											</div>
											<h3><fmt:message key="easy-buy"/></h3>
											<p><fmt:message key="easy-buy-se"/></p>
										</div>
									</div>
		
									<div class="col-6 col-md-6">
										<div class="feature">
											<div class="icon">
												<img src="images/support.svg" alt="Image" class="imf-fluid">
											</div>
											<h3><fmt:message key="24-report"/></h3>
											<p><fmt:message key="24-report-se"/>.</p>
										</div>
									</div>
		
									<div class="col-6 col-md-6">
										<div class="feature">
											<div class="icon">
												<img src="images/return.svg" alt="Image" class="imf-fluid">
											</div>
											<h3><fmt:message key="free-banpum"/></h3>
											<p><fmt:message key="free-banpum-se"/></p>
										</div>
									</div>
		
								</div>
							</div>
		
							<div class="col-lg-5">
								<div class="img-wrap">
									<img src="images/why-choose-us-img.jpg" alt="Image" class="img-fluid">
								</div>
							</div>
		
						</div>
					</div>
				</div>
				<!-- End Why Choose Us Section -->
		
				<!-- Start Testimonial Slider -->
				<div class="testimonial-section">
					<div class="container">
						<div class="row">
							<div class="col-lg-7 mx-auto text-center">
								<h2 class="section-title"><fmt:message key="sangpum-hoogi"/></h2>
							</div>
						</div>
		
						<div class="row justify-content-center">
							<div class="col-lg-12">
								<div class="testimonial-slider-wrap text-center">
		
									<div id="testimonial-nav">
										<span class="prev" data-controls="prev"><span class="fa fa-chevron-left"></span></span>
										<span class="next" data-controls="next"><span class="fa fa-chevron-right"></span></span>
									</div>
		
									<div class="testimonial-slider">
										
										<div class="item">
											<div class="row justify-content-center">
												<div class="col-lg-8 mx-auto">
		
													<div class="testimonial-block text-center">
														<blockquote class="mb-5">
															<p>&ldquo;<fmt:message key="hoogi-1"/>&rdquo;</p>
														</blockquote>
		
														<div class="author-info">
															<div class="author-pic">
																<svg xmlns="http://www.w3.org/2000/svg" height="80px" viewBox="0 -960 960 960" width="80px" fill="#e3e3e3"><path d="M222-255q63-44 125-67.5T480-346q71 0 133.5 23.5T739-255q44-54 62.5-109T820-480q0-145-97.5-242.5T480-820q-145 0-242.5 97.5T140-480q0 61 19 116t63 109Zm160.5-234.5Q343-529 343-587t39.5-97.5Q422-724 480-724t97.5 39.5Q617-645 617-587t-39.5 97.5Q538-450 480-450t-97.5-39.5ZM480-80q-82 0-155-31.5t-127.5-86Q143-252 111.5-325T80-480q0-83 31.5-155.5t86-127Q252-817 325-848.5T480-880q83 0 155.5 31.5t127 86q54.5 54.5 86 127T880-480q0 82-31.5 155t-86 127.5q-54.5 54.5-127 86T480-80Zm107.5-76Q640-172 691-212q-51-36-104-55t-107-19q-54 0-107 19t-104 55q51 40 103.5 56T480-140q55 0 107.5-16Zm-52-375.5Q557-553 557-587t-21.5-55.5Q514-664 480-664t-55.5 21.5Q403-621 403-587t21.5 55.5Q446-510 480-510t55.5-21.5ZM480-587Zm0 374Z"/></svg>
															</div>
															<h3 class="font-weight-bold">김** 님</h3>
															<span class="position d-block mb-3">일반 고객</span>
														</div>
													</div>
		
												</div>
											</div>
										</div> 
										<!-- END item -->
		
										<div class="item">
											<div class="row justify-content-center">
												<div class="col-lg-8 mx-auto">
		
													<div class="testimonial-block text-center">
														<blockquote class="mb-5">
															<p>&ldquo;<fmt:message key="hoogi-2"/>&rdquo;</p>
														</blockquote>
		
														<div class="author-info">
															<div class="author-pic">
																<svg xmlns="http://www.w3.org/2000/svg" height="80px" viewBox="0 -960 960 960" width="80px" fill="#e3e3e3"><path d="M222-255q63-44 125-67.5T480-346q71 0 133.5 23.5T739-255q44-54 62.5-109T820-480q0-145-97.5-242.5T480-820q-145 0-242.5 97.5T140-480q0 61 19 116t63 109Zm160.5-234.5Q343-529 343-587t39.5-97.5Q422-724 480-724t97.5 39.5Q617-645 617-587t-39.5 97.5Q538-450 480-450t-97.5-39.5ZM480-80q-82 0-155-31.5t-127.5-86Q143-252 111.5-325T80-480q0-83 31.5-155.5t86-127Q252-817 325-848.5T480-880q83 0 155.5 31.5t127 86q54.5 54.5 86 127T880-480q0 82-31.5 155t-86 127.5q-54.5 54.5-127 86T480-80Zm107.5-76Q640-172 691-212q-51-36-104-55t-107-19q-54 0-107 19t-104 55q51 40 103.5 56T480-140q55 0 107.5-16Zm-52-375.5Q557-553 557-587t-21.5-55.5Q514-664 480-664t-55.5 21.5Q403-621 403-587t21.5 55.5Q446-510 480-510t55.5-21.5ZM480-587Zm0 374Z"/></svg>
															</div>
															<h3 class="font-weight-bold">이** 님</h3>
															<span class="position d-block mb-3">금**** 주식회사 직원</span>
														</div>
													</div>
		
												</div>
											</div>
										</div> 
										<!-- END item -->
		
										<div class="item">
											<div class="row justify-content-center">
												<div class="col-lg-8 mx-auto">
		
													<div class="testimonial-block text-center">
														<blockquote class="mb-5">
															<p>&ldquo;<fmt:message key="hoogi-2"/>&rdquo;</p>
														</blockquote>
		
														<div class="author-info">
															<div class="author-pic">
																<svg xmlns="http://www.w3.org/2000/svg" height="80px" viewBox="0 -960 960 960" width="80px" fill="#e3e3e3"><path d="M222-255q63-44 125-67.5T480-346q71 0 133.5 23.5T739-255q44-54 62.5-109T820-480q0-145-97.5-242.5T480-820q-145 0-242.5 97.5T140-480q0 61 19 116t63 109Zm160.5-234.5Q343-529 343-587t39.5-97.5Q422-724 480-724t97.5 39.5Q617-645 617-587t-39.5 97.5Q538-450 480-450t-97.5-39.5ZM480-80q-82 0-155-31.5t-127.5-86Q143-252 111.5-325T80-480q0-83 31.5-155.5t86-127Q252-817 325-848.5T480-880q83 0 155.5 31.5t127 86q54.5 54.5 86 127T880-480q0 82-31.5 155t-86 127.5q-54.5 54.5-127 86T480-80Zm107.5-76Q640-172 691-212q-51-36-104-55t-107-19q-54 0-107 19t-104 55q51 40 103.5 56T480-140q55 0 107.5-16Zm-52-375.5Q557-553 557-587t-21.5-55.5Q514-664 480-664t-55.5 21.5Q403-621 403-587t21.5 55.5Q446-510 480-510t55.5-21.5ZM480-587Zm0 374Z"/></svg>
															</div>
															<h3 class="font-weight-bold">박** 님</h3>
															<span class="position d-block mb-3">일반 고객</span>
														</div>
													</div>
		
												</div>
											</div>
										</div> 
										<!-- END item -->
		
									</div>
		
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End Testimonial Slider -->
	
		<%@ include file="footer.jsp" %>
	</fmt:bundle>
</body>
</html>