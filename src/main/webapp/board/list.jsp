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
								<option value="subject" ${param.items eq 'subject' ? 'selected' : ''}>제목에서</option>
								<option value="content" ${param.items eq 'content' ? 'selected' : ''}>본문에서</option>
								<option value="name" ${param.items eq 'name' ? 'selected' : ''}>글쓴이에서</option>
							</select> 
							<input type="text" name="text" value="<c:out value='${param.text}'/>" /> 
							<input type="submit" value="검색" class="btn btn-sm btn-primary ms-1" />
							<a href="<c:url value='/BoardListAction.do?pageNum=1'/>" class="btn btn-sm btn-danger">검색 초기화</a>
						</div>
					</div>

					<div class="site-blocks-table">
						<table class="table">
							<thead>
								<tr>
									<th class="board-num">번호</th>
									<th class="board-subject">제목</th>
									<th class="board-date">작성일</th>
									<th class="board-date">수정일</th>
									<th class="board-hit">조회</th>
									<th class="board-name">글쓴이</th>
								</tr>
							</thead>
							<tbody>
								<%
								List boardlist = (List) request.getAttribute("boardlist");
								for (int i = 0; i < boardlist.size(); i++) {
									BoardDTO boardDTO = (BoardDTO) boardlist.get(i);
								%>
								<tr>
									<td><%=boardDTO.getNum()%></td>
									<td class="text-center board-subject">
										<a href="./BoardViewAction.do?num=<%=boardDTO.getNum() %>&pageNum=<%=pageNum %>" class="h5 text-black"><%=boardDTO.getSubject()%></a>
									</td>
									<td class="board-date"><%=boardDTO.getRegist_day()%></td>
									<td class="board-date"><%=boardDTO.getUpdate_day()%></td>
									<td><%=boardDTO.getHit()%></td>
									<td><%=boardDTO.getName()%></td>
								</tr>
								<%
								}
								if (boardlist.isEmpty()) {
								%>
								<tr>
									<td colspan="6" class="table-empty">게시글이 없습니다.</td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 페이지 번호(가운데) + 글쓰기 버튼(오른쪽, 로그인한 경우만) -->
				<div class="board-footer">
					<c:set value="<%=pageNum%>" var="pageNum" />
					<c:set value="<%=total_page%>" var="totalPage" />
					<c:if test="${totalPage > 0}">
						<nav aria-label="게시판 페이지">
							<ul class="pagination mb-0">
								<%-- 이전 --%>
								<c:choose>
									<c:when test="${pageNum > 1}">
										<c:url value="./BoardListAction.do" var="prevUrl">
											<c:param name="pageNum" value="${pageNum - 1}" />
											<c:if test="${not empty param.text}">
												<c:param name="items" value="${param.items}" />
												<c:param name="text" value="${param.text}" />
											</c:if>
										</c:url>
										<li class="page-item"><a class="page-link" href="${prevUrl}" aria-label="이전">&laquo;</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item disabled"><span class="page-link">&laquo;</span></li>
									</c:otherwise>
								</c:choose>

								<%-- 페이지 번호 --%>
								<c:forEach var="i" begin="1" end="${totalPage}">
									<c:url value="./BoardListAction.do" var="pageUrl">
										<c:param name="pageNum" value="${i}" />
										<c:if test="${not empty param.text}">
											<c:param name="items" value="${param.items}" />
											<c:param name="text" value="${param.text}" />
										</c:if>
									</c:url>
									<c:choose>
										<c:when test="${pageNum == i}">
											<li class="page-item active" aria-current="page"><span class="page-link">${i}</span></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="${pageUrl}">${i}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<%-- 다음 --%>
								<c:choose>
									<c:when test="${pageNum < totalPage}">
										<c:url value="./BoardListAction.do" var="nextUrl">
											<c:param name="pageNum" value="${pageNum + 1}" />
											<c:if test="${not empty param.text}">
												<c:param name="items" value="${param.items}" />
												<c:param name="text" value="${param.text}" />
											</c:if>
										</c:url>
										<li class="page-item"><a class="page-link" href="${nextUrl}" aria-label="다음">&raquo;</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item disabled"><span class="page-link">&raquo;</span></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
					</c:if>

					<c:if test="${not empty sessionId}">
						<c:url value="/BoardWriteForm.do" var="writeUrl">
							<c:param name="id" value="${sessionId}" />
						</c:url>
						<a href="${writeUrl}" class="text-end btn btn-primary board-write-btn">글 작성</a>
					</c:if>
				</div>

			</div>

		</form>
	</div>

	<%@ include file="/footer.jsp"%>
</body>
</html>