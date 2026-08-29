<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbconn</title>
</head>
<body>
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "C##dbexam";
		String pw = "m1234";
				
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("데이터베이스 등록 성공");
		conn = DriverManager.getConnection(url, user, pw);
		System.out.println("데이터베이스 접속 성공");
	} catch (Exception e) {
		System.out.println("데이터베이스 연결 실패");
		System.out.println("Exception : "+e.getMessage());
	}
	
	%>
</body>
</html>