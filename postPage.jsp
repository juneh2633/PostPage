<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="CSS/elementCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/headerCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/loginPageCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/postingCSS.css">
    <title>Document</title>
</head>

<body>
    <%
        String id = (String)session.getAttribute("id");
        if(id == null){
            out.print("<script>alert('로그인 해주세요.'); window.location.href='loginPage.html';</script>");
        }
        
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
        <div class="postingBox">
            <input type="button" class="backBtn" value="<-" onclick="history.back();" />
            <div class="postingHeader">
                <h2>글쓰기</h2>
            </div>
            <form action="JSP/insertPostApp.jsp" class="postingMain">
                <div class="postingMain">
                    <input type="text" class="titleText" name="title" placeholder="제목은 30자 이내만 가능합니다." maxlength='30'>
                    <textarea class="postText" name="maintext" placeholder="본문" rows="10" cols="10" wrap="on" maxlength="500"></textarea>
                    
                </div>
                <div class="postingFooter">
                    <input type="submit" class="postingButton" value="완료">
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