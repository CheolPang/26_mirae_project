<%@page import="mvc.model.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CPShop | 게시판</title>
</head>
<body>
	<%@ include file="/menu.jsp"%>
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
		<form action="<c:url value="/BoardListAction.do"/>" method="POST">
			<div class="container">
				<%
				int pageNum = (Integer) request.getAttribute("pageNum");
				int total_record = (Integer) request.getAttribute("total_record");
				int total_page = (Integer) request.getAttribute("total_page");
				%>

				<div class="row mb-5">
					<div class="boardBar">
						<div class="pageNum text-start">
							전체
							<%=total_record%>건
						</div>
						<div class="pageNum text-end">
							<select name="items">
								<option value="subject">제목에서</option>
								<option value="content">본문에서</option>
								<option value="name">글쓴이에서</option>
							</select> 
							<input type="text" name="text" /> 
							<input type="submit" value="검색" class="btn btn-sm btn-primary ms-1" />
							<a href="" class="btn btn-sm btn-danger">검색 초기화</a>
						</div>
					</div>

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
						for (int i = 0; i < boardlist.size(); i++) {
							BoardDTO boardDTO = (BoardDTO) boardlist.get(i);
						%>
						<tr>
							<td><%=boardDTO.getNum()%></td>
							<td><%=boardDTO.getSubject()%></td>
							<td><%=boardDTO.getRegist_day()%></td>
							<td><%=boardDTO.getUpdate_day()%></td>
							<td><%=boardDTO.getHit()%></td>
							<td><%=boardDTO.getName()%></td>
						</tr>
						<%
						}
						%>
					</table>
				</div>

			</div>
		</form>
	</div>

	<%@ include file="/footer.jsp"%>
</body>
</html>