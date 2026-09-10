<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 게시판</title>
<script>
	function checkForm() {
		if(!document.newWrite.subject.value) {
			alert("제목을 입력해주세요.");
			return false;
		}
		if(!document.newWrite.content.value) {
			alert("내용을 입력해주세요.");
			return false;
		}
		document.newWrite.submit();
	}
</script>

</head>
<body>
	<%@ include file="/menu.jsp" %>
	<%
		String name = (String) request.getAttribute("name");
	%>
		<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>게시판</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->
	<div class="container">
			<div class="row">
				<div class="col p-5">
					<form name="newWrite" action="./BoardWriteAction.do" method="post" onsubmit="return checkForm()">
						<input type="hidden" class="form-control" id="id" name="id" value="${sessionId}">
						<div class="mb-3">
						    <label for="name" class="form-label">이름</label>
						    <input type="text" class="form-control" id="name" name="name" value="${name}" readonly>
						</div>
						<div class="mb-3">
						    <label for="subject" class="form-label">제목</label>
						    <input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력해주세요.">
						</div>
						<div class="mb-3">
						    <label for="content" class="form-label">내용</label>
						    <textarea class="form-control" name="content" id="content" rows="15" placeholder="내용을 입력해주세요."></textarea>
						</div>
						<div class="mb-3">
						    <input type="submit" class="btn btn-primary" value="등록" />
						    <input type="reset" class="btn btn-danger" value="취소" />
						    <input type="button" class="btn btn-dark" value="이전" onclick="history.back()"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	<%@ include file="/footer.jsp" %>
</body>
</html>