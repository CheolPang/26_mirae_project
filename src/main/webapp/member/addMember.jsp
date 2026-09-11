<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='<%=request.getParameter("language")%>' />
<fmt:bundle basename="bundle.message">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 회원가입</title>
<fmt:message key="member-id-required-js" var="msgIdRequired" />
<fmt:message key="member-pw-required-js" var="msgPwRequired" />
<fmt:message key="member-pw-confirm-required-js" var="msgPwConfirmRequired" />
<fmt:message key="member-pw-mismatch-js" var="msgPwMismatch" />
<fmt:message key="member-name-required-js" var="msgNameRequired" />
<fmt:message key="member-id-label" var="lblId" />
<fmt:message key="member-pw-label" var="lblPw" />
<fmt:message key="name-label" var="lblName" />
<fmt:message key="member-email-label" var="lblEmail" />
<fmt:message key="member-contact-label" var="lblContact" />
<fmt:message key="address-label" var="lblAddress" />
<script>
	function checkForm() {
		if (!document.newMember.id.value) {
			alert("${msgIdRequired}")
			return false;
		}
		if (!document.newMember.pw.value) {
			alert("${msgPwRequired}")
			return false;
		}
		if (!document.newMember.pw_confirm.value) {
			alert("${msgPwConfirmRequired}")
			return false;
		}
		if (document.newMember.pw.value != document.newMember.pw_confirm.value) {
			alert("${msgPwMismatch}")
			return false;
		}
		if (!document.newMember.name.value) {
			alert("${msgNameRequired}")
			return false;
		}
		const f = document.newMember;
		if (!checkBytes(f.id, 20, "${lblId}") || !checkBytes(f.pw, 20, "${lblPw}")
				|| !checkBytes(f.name, 30, "${lblName}") || !checkBytes(f.email, 30, "${lblEmail}")
				|| !checkBytes(f.contact, 30, "${lblContact}") || !checkBytes(f.address, 100, "${lblAddress}")) {
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<%@ include file="../menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="menu-signup" /></h1>
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
					<h2 class="h3 mb-3 text-black"><fmt:message key="member-info-input-heading" /></h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<form name="newMember" action="processAddMember.jsp" method="POST" onsubmit="return checkForm()">
							<c:if test="${param.error eq 'dup'}">
								<div class="alert alert-danger" role="alert"><fmt:message key="member-signup-error-dup" /></div>
							</c:if>
							<c:if test="${param.error eq 'fail'}">
								<div class="alert alert-danger" role="alert"><fmt:message key="member-signup-error-fail" /></div>
							</c:if>
							<fmt:message key="ph-email" var="phEmail" />
							<fmt:message key="ph-id" var="phId" />
							<fmt:message key="ph-password" var="phPassword" />
							<fmt:message key="ph-password-confirm" var="phPasswordConfirm" />
							<fmt:message key="ph-name" var="phName" />
							<fmt:message key="ph-birthday" var="phBirthday" />
							<fmt:message key="ph-address" var="phAddress" />
							<fmt:message key="ph-contact" var="phContact" />
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="email" class="text-black"><fmt:message key="member-email-label" /> <span
										class="text-danger">*</span></label> <input type="email"
										class="form-control" id="email" name="email" placeholder="${phEmail}" value="<c:out value='${param.email}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="id" class="text-black"><fmt:message key="member-id-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="id" name="id" placeholder="${phId}" value="<c:out value='${param.id}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="pw" class="text-black"><fmt:message key="member-pw-label" /> <span
										class="text-danger">*</span></label> <input type="password"
										class="form-control" id="pw" name="pw" placeholder="${phPassword}" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="pw_confirm" class="text-black"><fmt:message key="member-pw-confirm-label" /> <span
										class="text-danger">*</span></label> <input type="password"
										class="form-control" id="pw_confirm" name="pw_confirm" placeholder="${phPasswordConfirm}" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="name" class="text-black"><fmt:message key="name-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="name" name="name" placeholder="${phName}" value="<c:out value='${param.name}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="birthday" class="text-black"><fmt:message key="member-birthday-label" /> <span
										class="text-danger">*</span></label> <input type="date"
										class="form-control" id="birthday" name="birthday" placeholder="${phBirthday}" value="<c:out value='${param.birthday}'/>" required>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="address" class="text-black"><fmt:message key="address-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="address" name="address"
										placeholder="${phAddress}" value="<c:out value='${param.address}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="contact" class="text-black"><fmt:message key="member-contact-label" /> <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="contact" name="contact"
										placeholder="${phContact}" value="<c:out value='${param.contact}'/>" required>
								</div>
							</div>

							<div class="form-group mb-3">
								<label for="gender" class="text-black"><fmt:message key="member-gender-label" /> <span
									class="text-danger">*</span></label> <select id="gender"
									name="gender" class="form-control">
									<option value="남"><fmt:message key="member-gender-male" /></option>
									<option value="여" ${param.gender eq '여' ? 'selected' : ''}><fmt:message key="member-gender-female" /></option>
									<option value="기타" ${param.gender eq '기타' ? 'selected' : ''}><fmt:message key="member-gender-other" /></option>
									<option value="비공개" ${param.gender eq '비공개' ? 'selected' : ''}><fmt:message key="member-gender-private" /></option>
								</select>
							</div>


							<fmt:message key="menu-signup" var="signupBtnLabel" />
							<input type="submit" value="${signupBtnLabel}" class="btn btn-primary">
						</form>


					</div>
				</div>
			</div>
			<!-- </form> -->
		</div>
	</div>
	<%@ include file="../footer.jsp"%>

</body>
</html>
</fmt:bundle>
