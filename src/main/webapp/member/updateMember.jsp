<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 회원수정</title>
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
	<%
		String sessionId2 = (String) session.getAttribute("sessionId");
	%>
	<sql:setDataSource var="dataSource" url="jdbc:oracle:thin:@localhost:1521:xe" driver="oracle.jdbc.driver.OracleDriver" user="C##dbexam" password="m1234"/>

	<sql:query dataSource="${dataSource}" var="resultSet">
		select * from bs_member where id=?
		<sql:param value="<%=sessionId2 %>"/>
	</sql:query>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>회원수정</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<c:forEach var="row" items="${resultSet.rows}">
		<c:set value="${row.mail}" var="mail"/>
	
	
	<div class="untree_co-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12 mb-5 mb-md-0">
					<h2 class="h3 mb-3 text-black">회원 정보 입력</h2>
					<div class="p-3 p-lg-5 border bg-white signForm">
						<form name="newMember" action="processUpdateMember.jsp" method="POST">
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="email" class="text-black">이메일 <span
										class="text-danger">*</span></label> <input type="email"
										class="form-control" id="email" name="email" placeholder="이메일을 입력하세요." value='<c:out value="${row.mail}"/>' required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="id" class="text-black">아이디 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="id" name="id" placeholder="아이디를 입력하세요." value='<c:out value="${row.id}"/>' readonly>
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
										class="form-control" id="name" name="name" placeholder="이름을 입력하세요." value='<c:out value="${row.name}"/>' required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="birthday" class="text-black">생년월일 <span
										class="text-danger">*</span></label> <input type="date"
										class="form-control" id="birthday" name="birthday" placeholder="YYYY-MM-DD" value='<c:out value="${row.birth}"/>' required>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="address" class="text-black">주소 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="address" name="address"
										placeholder="주소를 입력하세요" value='<c:out value="${row.address}"/>' required>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12 mb-3">
									<label for="contact" class="text-black">전화번호 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="contact" name="contact"
										placeholder="전화번호를 입력하세요." value='<c:out value="${row.phone}"/>' required>
								</div>
							</div>

							<div class="form-group mb-3">
								<label for="gender" class="text-black">성별 <span
									class="text-danger">*</span></label> <select id="gender"
									name="gender" class="form-control">
									<option value="남" <c:if test="${row.gender eq '남'}">selected</c:if>>남성</option>
									<option value="여" <c:if test="${row.gender eq '여'}">selected</c:if>>여성</option>
									<option value="기타" <c:if test="${row.gender eq '기타'}">selected</c:if>>기타</option>
									<option value="비공개" <c:if test="${row.gender eq '비공개'}">selected</c:if>>공개하지 않음</option>
								</select>
							</div>
							
							
							<input type="button" value="수정" class="btn btn-primary me-1" onClick="checkForm()">
							<a href="deleteMember.jsp" class="btn btn-danger">탈퇴</a>
						</form>
						
						
					</div>
				</div>
			</div>
			<!-- </form> -->
		</div>
	</div>
	<%@ include file="../footer.jsp"%>
	</c:forEach>	
</body>
</html>