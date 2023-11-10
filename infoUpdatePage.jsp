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

        </div>
    </header>

    <main>
        <div class="signupBox">
            <div class="signupHeader">
                <h2>정보 수정</h2>
            </div>
            <form action="JSP/updateUserInfoApp.jsp">
                <div class="signupMain">

                    <div class="inputBox">
                        <div class="inputInfo">이름</div>
                        <input type='text' name="name_value" class="signupInputBox" placeholder="이름" maxlength = '15' value = " <%= name %> ">
                    </div>
                    <div class="inputBox">
                        <div class="inputInfo">비밀번호</div>
                        <input type='password' name="password_value" class="signupInputBox" placeholder="비밀번호"maxlength='15' value = "<%= password %>">
                    </div>
                    <div class="inputBox">
                        <div class="inputInfo">확인</div>
                        <input type='password' name="password_check_value" class="signupInputBox" placeholder="비밀번호 확인"
                            maxlength='15' value = "<%= password %>" >
                    </div>
                    <div class="inputBox">
                        <div class="inputInfo">이메일</div>
                        <input type='text' name="email_value" class="signupInputBox" placeholder="이메일" maxlength='30' value = " <%= email %> ">
                    </div>
                    <div class="inputBox">
                        <div class="inputInfo">생년월일</div>
                        <input type='text' name="birthdate_value" class="signupInputBox"
                            placeholder="생년월일 8자리(ex)20000324)" maxlength='8' value = "<%= birthdate %>">
                    </div>
                    <div class="inputBox">
                        <div class="inputInfo">전화번호</div>
                        <input type='text' name="phonenumber_value" class="signupInputBox" placeholder="-없이 11자리"
                            maxlength='11' value = " <%= phonenumber %> ">
                    </div>

                </div>
                <div class="signupFooter">
                    <input type="submit" class="signupButton" value="수정완료">


                </div>
            </form>
        </div>
    </main>

    <footer>
        <div>문의</div>
        <div>전화번호: 010-8549-0120</div>
        <div>이메일:juneh2633@gmail.com</div>
    </footer>
    <script src=""></script>
</body>

</html>