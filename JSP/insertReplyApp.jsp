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
    String replyMain = request.getParameter("replyMain");
    String postUid = request.getParameter("postUid");

    if(replyMain.length()==0){
        out.println("<script>alert('댓글을 입력해주세요.'); history.back();</script>");
        return;       
    }
    if(replyMain.length()>200){
        out.println("<script>alert('댓글이 너무 깁니다.'); history.back();</script>");
        return;
    }  
    Class.forName("com.mysql.jdbc.Driver");
    Date currentDate = new Date();
    Timestamp currentTimestamp = new Timestamp(currentDate.getTime());
    //데이터 베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");

    String sql = "INSERT INTO reply (id, post_uid, reply_main) VALUES (?, ?, ?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id);
    query.setString(2, postUid);
    query.setString(3, replyMain);

 
    //  query 전송
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
        //history.back();
        window.location.href = document.referrer;
    </script>
</body>