<%@page import="mvc.model.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 게시판</title>
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
	<div class="untree_co-section before-footer-section">
		<div class="container">
			<div class="row mb-5">
				<table>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>수정일</th>
						<th>조회</th>
						<th>글쓴이</th>
					</tr>
					<%
						List boardlist = (List) request.getAttribute("boardlist");
						for(int i = 0; i < boardlist.size(); i++) {
							BoardDTO boardDTO = (BoardDTO) boardlist.get(i);

					%>
					<tr>
						<td><%=boardDTO.getNum() %></td>
						<td><%=boardDTO.getSubject() %></td>
						<td><%=boardDTO.getRegist_day() %></td>
						<td><%=boardDTO.getUpdate_day() %></td>
						<td><%=boardDTO.getHit() %></td>
						<td><%=boardDTO.getName() %></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
		</div>
	</div>	
	
	<%@ include file="/footer.jsp" %>
</body>
</html>