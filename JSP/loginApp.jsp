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
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value");
    String passwordValue = request.getParameter("password_value");
    if(idValue.length()==0){
        out.println("<script>alert('아이디를 입력해주세요.'); history.back();</script>");
        return;       
    }
    if(passwordValue.length()==0){
        out.println("<script>alert('비밀번호를 입력해주세요.'); history.back();</script>");
        return;
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");

    String sql = "SELECT * FROM user";
    PreparedStatement query = connect.prepareStatement(sql);
    ResultSet result = query.executeQuery();
    boolean loginCheck = false;
    while(result.next()){
        if( result.getInt(8)== 1){
            continue;
        }
        if( idValue.equals( result.getString(1) ) ){
            if( passwordValue.equals( result.getString(3))){
                loginCheck = true;
                session.setAttribute("id", result.getString(1));
            }
            else{
                break;
            }
        }
    }
    if(!loginCheck){
        out.println("<script>alert('아이디 또는 비밀번호가 잘못되었습니다.'); history.back();</script>");
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
        alert("환영합니다.")

        location.href = "../postListPage.jsp"
    </script>
</body>