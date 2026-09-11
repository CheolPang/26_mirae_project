<%@page import="mvc.model.BoardDTO"%>
<%@page import="java.util.List"%>
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
<title>CPShop | <fmt:message key="board-title" /></title>
</head>
<body>
	<%@ include file="/menu.jsp"%>
	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">


			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1><fmt:message key="board-title" /></h1>
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
						<div class="shop-count mb-0">
							<fmt:message key="board-total-count" />
							<strong><%=total_record%></strong><fmt:message key="board-count-unit" />
						</div>
						<div class="d-flex align-items-center flex-wrap gap-2">
							<fmt:message key="board-search-subject" var="boardSearchSubject" />
							<fmt:message key="board-search-content" var="boardSearchContent" />
							<fmt:message key="board-search-writer" var="boardSearchWriter" />
							<select name="items" class="form-select form-select-sm w-auto">
								<option value="subject" ${param.items eq 'subject' ? 'selected' : ''}>${boardSearchSubject}</option>
								<option value="content" ${param.items eq 'content' ? 'selected' : ''}>${boardSearchContent}</option>
								<option value="name" ${param.items eq 'name' ? 'selected' : ''}>${boardSearchWriter}</option>
							</select>
							<input type="text" name="text" class="form-control form-control-sm w-auto" value="<c:out value='${param.text}'/>" />
							<fmt:message key="board-search-btn" var="boardSearchBtn" />
							<input type="submit" value="${boardSearchBtn}" class="btn btn-sm btn-primary" />
							<fmt:message key="board-search-reset-btn" var="boardSearchResetBtn" />
							<a href="<c:url value='/BoardListAction.do?pageNum=1'/>" class="btn btn-sm btn-danger">${boardSearchResetBtn}</a>
						</div>
					</div>

					<div class="site-blocks-table">
						<table class="table">
							<thead>
								<tr>
									<th class="board-num"><fmt:message key="board-num-th" /></th>
									<th class="board-subject"><fmt:message key="board-subject-th" /></th>
									<th class="board-date"><fmt:message key="board-regist-date-th" /></th>
									<th class="board-date"><fmt:message key="board-update-date-th" /></th>
									<th class="board-hit"><fmt:message key="board-hit-th" /></th>
									<th class="board-name"><fmt:message key="board-writer-th" /></th>
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
									<td colspan="6" class="table-empty"><fmt:message key="board-no-post" /></td>
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
						<fmt:message key="board-page-nav-aria" var="boardPageNavAria" />
						<fmt:message key="prev-btn" var="boardPrevAria" />
						<fmt:message key="board-next-aria" var="boardNextAria" />
						<nav aria-label="${boardPageNavAria}">
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
										<li class="page-item"><a class="page-link" href="${prevUrl}" aria-label="${boardPrevAria}">&laquo;</a></li>
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
										<li class="page-item"><a class="page-link" href="${nextUrl}" aria-label="${boardNextAria}">&raquo;</a></li>
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
						<a href="${writeUrl}" class="text-end btn btn-primary board-write-btn"><fmt:message key="board-write-btn" /></a>
					</c:if>
				</div>

			</div>

		</form>
	</div>

	<%@ include file="/footer.jsp"%>
</body>
</html>
</fmt:bundle>
