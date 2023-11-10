<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="CSS/elementCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/headerCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/loginPageCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/signupPageCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/infoCSS.css">
    <title>Document</title>
</head>

<body>
    <%
        request.setCharacterEncoding("utf-8");
        String id = (String)session.getAttribute("id");
        if(id == null){
            out.print("<script>alert('로그인 해주세요.'); window.location.href='loginPage.html';</script>");
            return;
        }
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");
        String sql = "SELECT * FROM user WHERE id = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, id);
        ResultSet result = query.executeQuery();
        String name = "";
        String password = "";
        String email = "";
        String phonenumber = "";
        Date birthdate = null;
        Date userCreateDate = null;
        if(result.next()){
            name = result.getString(2);
            password = result.getString(3);
            email = result.getString(4);
            birthdate = result.getDate(5);
            phonenumber = result.getString(6);
            userCreateDate = result.getDate(7);
        }

        result.close();
        query.close();
        connect.close();
    %>
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
                    <div><a href="infoReadPage.jsp">내 정보 보기</a></div>
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
        <div class="loginMenu">
            <div>
                id: <%= id %>
            </div>
            <form action="JSP/logoutApp.jsp">
                <input type="submit" class="logoutButton" value="로그아웃">
            </form>
        </div>
    </header>

    <main>
        <div class="infoMainBox">
            <div class="infoHeader">
                <h2>내 정보</h2>
            </div>
            <div class="infoMain">
                <div class="inputBox">
                    <div class="inputInfo">이름</div>
                    <div class="infoBox"><%= name %></div>
                </div>
                <div class="inputBox">
                    <div class="inputInfo">아이디</div>
                    <div class="infoBox"><%= id %></div>
                </div>
                <div class="inputBox">
                    <div class="inputInfo">비밀번호</div>
                    <div class="infoBox"><%= password  %></div>
                </div>
                <div class="inputBox">
                    <div class="inputInfo">이메일</div>
                    <div class="infoBox"><%= email %></div>
                </div>
                <div class="inputBox">
                    <div class="inputInfo">생년월일</div>
                    <div class="infoBox"><%= birthdate%></div>
                </div>
                <div class="inputBox">
                    <div class="inputInfo">전화번호</div>
                    <div class="infoBox"><%= phonenumber%></div>
                </div>
                <div class="inputBox">
                    <div class="inputInfo">생성일</div>
                    <div class="infoBox"><%= userCreateDate%></div>
                </div>
            </div>
            <input id="userUpdateButton" type="button" class="updateId" value="수정">
            <input id="userDeleteButton" type="button" class="deleteId" value="계정탈퇴">
        </div>
    </main>


    <footer>
        <div>문의</div>
        <div>전화번호: 010-8549-0120</div>
        <div>이메일:juneh2633@gmail.com</div>
    </footer>
    <script src="JavaScript/updateData.js"></script>
    <script>
        document.getElementById("userDeleteButton").setAttribute('onclick', 'userDeleteEvent("<%=id%>")');
        document.getElementById("userUpdateButton").setAttribute('onclick', 'userUpdateEvent()');
    </script>
</body>

</html>