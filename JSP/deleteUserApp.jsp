<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 

<% 
    String id = (String)session.getAttribute("id");
    request.setCharacterEncoding("utf-8"); //전페이지 request 
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");
    String postUid = request.getParameter("postUid");
    String sql = "UPDATE user SET deleted = 1 where id = ? ";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id);
    try{
        query.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류'); history.back();</script>");
        return;
    }    
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
        alert("계정이 탈퇴되었습니다.")
        location.href="../loginPage.html"
    </script>
</body>