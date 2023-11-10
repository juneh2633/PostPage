<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>세션의 정보 가져오기</h1>
	<%
		String id = (String) session.getAttribute("id");
		out.print(id);
	%>
</body>
</html>