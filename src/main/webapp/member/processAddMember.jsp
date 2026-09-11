<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>processAddMember</title>
</head>
<body>
<%  request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("pw");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");//String month = request.getParameterValues("birthmm")[0];
    String birth = request.getParameter("birthday");
    String mail = request.getParameter("email");
    String phone = request.getParameter("contact");
    String address = request.getParameter("address");
%>

<sql:setDataSource var="dataSource" url="jdbc:oracle:thin:@localhost:1521:xe" driver="oracle.jdbc.driver.OracleDriver" user="C##dbexam" password="m1234"/>

<sql:query dataSource="${dataSource}" var="dupCheck">
	select count(*) as cnt from bs_member where id=?
	<sql:param value="<%=id %>"/>
</sql:query>
<c:if test="${dupCheck.rows[0].cnt > 0}">
	<jsp:forward page="addMember.jsp?error=dup"/>
</c:if>

<c:catch var="insertError">
<sql:update dataSource="${dataSource}" var="resultSet">
	insert into bs_member values(?,?,?,?,?,?,?,?, sysdate, bs_seq_num.nextval, sysdate, sysdate)
	<sql:param value="<%=id %>"/>
	<sql:param value="<%=password %>"/>
	<sql:param value="<%=name %>"/>
	<sql:param value="<%=gender %>"/>
	<sql:param value="<%=birth %>"/>
	<sql:param value="<%=mail %>"/>
	<sql:param value="<%=phone %>"/>
	<sql:param value="<%=address %>"/>
</sql:update>
</c:catch>
<c:if test="${insertError != null}">
	<% System.out.println("processAddMember 에러 : " + pageContext.getAttribute("insertError")); %>
	<jsp:forward page="addMember.jsp?error=fail"/>
</c:if>

<c:if test="${resultSet>=1}">
	<c:redirect url="resultMember.jsp?msg=1"/>
</c:if>

</body>
</html>