<%@page import="mvc.model.BoardDAO"%>
<%@page import="mvc.model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String edit = request.getParameter("edit");

	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO board = dao.getBoardByNum(num, pageNum);

	String loginId = (String) session.getAttribute("sessionId");
	if (board == null || loginId == null || !loginId.equals(board.getId())) {
		response.sendRedirect(request.getContextPath() + "/BoardViewAction.do?num=" + num + "&pageNum=" + pageNum);
		return;
	}

	if ("delete".equals(edit)) {
		dao.deleteBoard(num);
		response.sendRedirect(request.getContextPath() + "/BoardListAction.do?pageNum=" + pageNum);
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 게시판</title>
<script>
	function checkForm() {
		if(!document.editWrite.subject.value) {
			alert("제목을 입력해주세요.");
			return false;
		}
		if(!document.editWrite.content.value) {
			alert("내용을 입력해주세요.");
			return false;
		}
		document.editWrite.submit();
	}
</script>

</head>
<body>
	<%@ include file="/menu.jsp" %>
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
					<form name="editWrite" action="<%=request.getContextPath()%>/BoardUpdateAction.do" method="post" onsubmit="return checkForm()">
						<input type="hidden" name="num" value="<%=num %>">
						<input type="hidden" name="pageNum" value="<%=pageNum %>">
						<div class="mb-3">
						    <label for="name" class="form-label">이름</label>
						    <input type="text" class="form-control" id="name" name="name" value="<%=board.getName() %>" readonly>
						</div>
						<div class="mb-3">
						    <label for="subject" class="form-label">제목</label>
						    <input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력해주세요." value="<%=board.getSubject() %>">
						</div>
						<div class="mb-3">
						    <label for="content" class="form-label">내용</label>
						    <textarea class="form-control" name="content" id="content" rows="15" placeholder="내용을 입력해주세요."><%=board.getContent() %></textarea>
						</div>
						<div class="mb-3">
						    <input type="submit" class="btn btn-primary" value="수정" />
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
