<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		document.newMember.submit();
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
						<form name="newMember" action="processAddMember.jsp" method="POST">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="email" class="text-black">이메일 <span
										class="text-danger">*</span></label> <input type="email"
										class="form-control" id="email" name="email" placeholder="이메일을 입력하세요." required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="id" class="text-black">아이디 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="id" name="id" placeholder="아이디를 입력하세요." required>
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
									<label for="name" class="text-black">이름 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="name" name="name" placeholder="이름을 입력하세요." required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="birthday" class="text-black">생년월일 <span
										class="text-danger">*</span></label> <input type="date"
										class="form-control" id="birthday" name="birthday" placeholder="YYYY-MM-DD" required>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="address" class="text-black">주소 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="address" name="address"
										placeholder="주소를 입력하세요" required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="contact" class="text-black">전화번호 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="contact" name="contact"
										placeholder="전화번호를 입력하세요." required>
								</div>
							</div>

							<div class="form-group mb-3">
								<label for="gender" class="text-black">성별 <span
									class="text-danger">*</span></label> <select id="gender"
									class="form-control">
									<option value="male">남성</option>
									<option value="female">여성</option>
									<option value="other">기타</option>
									<option value="private">공개하지 않음</option>
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