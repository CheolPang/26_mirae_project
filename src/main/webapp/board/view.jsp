<%@page import="mvc.model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		BoardDTO notice = (BoardDTO) request.getAttribute("board");
		int num = (Integer) request.getAttribute("num");
		int now = (Integer) request.getAttribute("pageNum");
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
				<form name="newWrite" action="./BoardWriteAction.do" method="post"
					onsubmit="return checkForm()">
					<input type="hidden" class="form-control" id="id" name="id"
						value="${sessionId}">
					<div class="mb-3">
						<label for="name" class="form-label">이름</label> <input type="text"
							class="form-control" id="name" name="name"
							value="<%=notice.getName() %>" readonly>
					</div>
					<div class="mb-3">
						<label for="subject" class="form-label">제목</label> <input
							type="text" class="form-control" id="subject" name="subject"
							placeholder="제목을 입력해주세요." value="<%=notice.getSubject() %>"
							readonly>
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<textarea class="form-control" name="content" id="content"
							rows="15" placeholder="내용을 입력해주세요." readonly><%=notice.getContent()%></textarea>
					</div>

					<c:set var="userId" value="<%=notice.getId()%>" />
					<c:if test="${sessionId eq userId}">
						<div class="mb-3">
							<input type="button" class="btn btn-primary" value="수정" onclick="location.href='./board/editForm.jsp?edit=edit&num=<%=num %>&pageNum=<%=now %>'" />
							<input type="button" class="btn btn-danger" value="삭제" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='./board/editForm.jsp?edit=delete&num=<%=num %>&pageNum=<%=now %>'" />
						</div>
					</c:if>
				</form>
			</div>
			</div>
		</div>
	<%@ include file="/footer.jsp" %>
</body>
</html>