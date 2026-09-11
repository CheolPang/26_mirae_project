<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 회원가입</title>
<script>
	function checkForm() {
		if (!document.newMember.id.value) {
			alert("아이디를 입력해주세요.")
			return false;
		}
		if (!document.newMember.pw.value) {
			alert("비번을 입력해주세요.")
			return false;
		}
		if (!document.newMember.pw_confirm.value) {
			alert("비번확인을 입력해주세요.")
			return false;
		}
		if (document.newMember.pw.value != document.newMember.pw_confirm.value) {
			alert("비번을 동일하게 입력해주세요.")
			return false;
		}
		if (!document.newMember.name.value) {
			alert("이름을 입력해주세요.")
			return false;
		}
		// bs_member 칼럼 크기(바이트)를 넘으면 가입이 실패하므로 미리 막는다
		const f = document.newMember;
		if (!checkBytes(f.id, 20, "아이디") || !checkBytes(f.pw, 20, "비밀번호")
				|| !checkBytes(f.name, 30, "이름") || !checkBytes(f.email, 30, "이메일")
				|| !checkBytes(f.contact, 30, "전화번호") || !checkBytes(f.address, 100, "주소")) {
			return false;
		}
		// form 의 onsubmit 에서 호출되므로 submit() 대신 true 를 돌려주면 전송된다
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
						<h1>회원가입</h1>
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
					<h2 class="h3 mb-3 text-black">회원 정보 입력</h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<%-- onsubmit 이 없으면 checkForm()(비밀번호 확인 등)이 실행되지 않는다 --%>
						<form name="newMember" action="processAddMember.jsp" method="POST" onsubmit="return checkForm()">
							<%-- processAddMember.jsp 가 가입에 실패하면 error 와 입력값을 가지고 이 페이지로 forward 한다 --%>
							<c:if test="${param.error eq 'dup'}">
								<div class="alert alert-danger" role="alert">이미 사용 중인 아이디입니다. 다른 아이디를 입력해 주세요.</div>
							</c:if>
							<c:if test="${param.error eq 'fail'}">
								<div class="alert alert-danger" role="alert">회원가입에 실패했습니다. 입력한 내용의 길이를 확인해 주세요.</div>
							</c:if>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="email" class="text-black">이메일 <span
										class="text-danger">*</span></label> <input type="email"
										class="form-control" id="email" name="email" placeholder="이메일을 입력하세요." value="<c:out value='${param.email}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="id" class="text-black">아이디 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="id" name="id" placeholder="아이디를 입력하세요." value="<c:out value='${param.id}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="pw" class="text-black">비밀번호 <span
										class="text-danger">*</span></label> <input type="password"
										class="form-control" id="pw" name="pw" placeholder="비밀번호를 입력하세요." required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="pw_confirm" class="text-black">비밀번호 확인 <span
										class="text-danger">*</span></label> <input type="password"
										class="form-control" id="pw_confirm" name="pw_confirm" placeholder="비밀번호를 다시 입력하세요." required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="name" class="text-black">이름 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="name" name="name" placeholder="이름을 입력하세요." value="<c:out value='${param.name}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="birthday" class="text-black">생년월일 <span
										class="text-danger">*</span></label> <input type="date"
										class="form-control" id="birthday" name="birthday" placeholder="YYYY-MM-DD" value="<c:out value='${param.birthday}'/>" required>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="address" class="text-black">주소 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="address" name="address"
										placeholder="주소를 입력하세요" value="<c:out value='${param.address}'/>" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="contact" class="text-black">전화번호 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="contact" name="contact"
										placeholder="전화번호를 입력하세요." value="<c:out value='${param.contact}'/>" required>
								</div>
							</div>

							<div class="form-group mb-3">
								<label for="gender" class="text-black">성별 <span
									class="text-danger">*</span></label> <select id="gender"
									name="gender" class="form-control">
									<option value="남">남성</option>
									<option value="여" ${param.gender eq '여' ? 'selected' : ''}>여성</option>
									<option value="기타" ${param.gender eq '기타' ? 'selected' : ''}>기타</option>
									<option value="비공개" ${param.gender eq '비공개' ? 'selected' : ''}>공개하지 않음</option>
								</select>
							</div>
							
							
							<input type="submit" value="회원가입" class="btn btn-primary">
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