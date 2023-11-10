<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<!-- 시간 -->
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 

<% //jsp 작성 
    request.setCharacterEncoding("utf-8"); //전페이지 request 
    String id = (String)session.getAttribute("id");
    if(id == null){
        out.print("<script>alert('로그인 해주세요.'); window.location.href='loginPage.html';</script>");
        return;
    }
    int replyUid = Integer.parseInt(request.getParameter("replyUid"));
    %>
    <script>
        console.log('<%=replyUid%>');
    </script>
    <%
    String replyMain = request.getParameter("replyMain");

    Class.forName("com.mysql.jdbc.Driver");
    //데이터 베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");
    String sql = "UPDATE reply SET reply_main = ? WHERE reply_uid = ?";

    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, replyMain);
    query.setInt(2, replyUid);


    query.executeUpdate();

    
    
    query.close();
    connect.close();

%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div>loading</div>
    <script>
        window.location.href = document.referrer;
    </script>
</body>