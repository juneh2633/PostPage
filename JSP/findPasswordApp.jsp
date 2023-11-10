<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<% 
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value");
    String nameValue = request.getParameter("name_value");
    String emailValue = request.getParameter("email_value");
    idValue = idValue.replaceAll("\\s", "");
    nameValue = nameValue.replaceAll("\\s", "");
    emailValue = emailValue.replaceAll("\\s", "");
    if(idValue.length()==0){
        out.println("<script>alert('아이디를 입력해주세요.'); history.back();</script>");
        return;       
    }
    if(idValue.length()>15){
    out.println("<script>alert('접근불가'); history.back();</script>");
    return;
    }
    if(nameValue.length()==0){
        out.println("<script>alert('이름을 입력해주세요.'); history.back();</script>");
        return;       
    }
    if(nameValue.length()>15){
    out.println("<script>alert('접근불가'); history.back();</script>");
    return;
    }
    if(emailValue.length()==0){
        out.println("<script>alert('이메일을 입력해주세요.'); history.back();</script>");
        return;
    }
    if(emailValue.length()>30){
        out.println("<script>alert('접근불가'); history.back();</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="../CSS/elementCSS.css">
    <link type="text/css" rel="stylesheet" href="../CSS/headerCSS.css">
    <link type="text/css" rel="stylesheet" href="../CSS/loginPageCSS.css">
    <title>Document</title>
</head>

<body>
    <header>
        <div class="icon">=</div>
        <a href="postListPage.jsp">
            <div class="title">Post HomePage
                <span>Post</span>
            </div>
        </a>
        <nav>
            <div class="elementMenu">
                <a href="infoReadPage.jsp">내 정보</a>
                <div class="dropMenu">
                    <div><a href="#">내 정보 보기</a></div>
                    <div><a href="#">회원 탈퇴</a></div>
                </div>
            </div>
    
            <div class="elementMenu">
                <a href="postListPage.jsp">게시판</a>
                <div class="dropMenu">
                    <div><a href="postListPage.jsp">글 목록</a></div>
                    <div><a href="postPage.jsp">글 쓰기</a></div>
                </div>
            </div>
        </nav>
    </header>
    <main>
        <div class="loginBox">
            <div class="loginHeader">
                <h3>비밀번호는 다음과 같습니다.</h3>
            </div>
            <div class="loginMain">
                <div id="idList">
<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");
    String sql = "SELECT * FROM user WHERE id= ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    ResultSet result = query.executeQuery();
    boolean passwordExist = false;
    String password = "";
    if(result.next()){
        if(result.getString(4).equals(emailValue)){
            if(result.getString(2).equals(nameValue)){
                passwordExist = true;
                password=result.getString(3);
%>
    <script>
        var idBox = document.createElement('div');
        var maskId = "**" + '<%=password%>'.substring(2);
        console.log(maskId);
        idBox.innerHTML = maskId;
        document.getElementById("idList").appendChild(idBox);        
    </script>
<%
            }
        }
    }
    if(passwordExist == false){
        out.println("<script>alert('존재하지 않는 계정입니다.'); history.back();</script>");
        return;        
    }
%>


                </div>
            </div>
            <div class="loginFooter">
                <input type="button" value="로그인 페이지로 돌아가기" onclick="location.href='../loginPage.html';">
            </div>
        </div>
    </main>
    <footer>
        <div>문의</div>
        <div>전화번호: 010-8549-0120</div>
        <div>이메일:juneh2633@gmail.com</div>
    </footer>
    <script></script>

</body>