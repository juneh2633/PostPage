<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%
	String id = (String)session.getAttribute("id");
	//자식클래스 변수 String = (자식타입) 부모타입 데이터
	if(id == null){
        out.println("<script>alert('로그인 해주세요'); history.back(); </script>");
        return;
	}

%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div>loading</div>
    <script>
        location.href = "../postListPage.html"
    </script>
</body>