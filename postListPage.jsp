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
    <link type="text/css" rel="stylesheet" href="CSS/postListCSS.css">
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
        <div class="postListBox">
            <div class="postListHeader">
                <h2>게시판</h2>
            </div>
            <div class="postListMain" id="postEmptyList">
                <div class="post_info_box">
                    <div class="post_uid">
                        번호
                    </div>
                    <div class="post_userId">
                        유저
                    </div>
                    <div class="post_title">
                        제목
                    </div>
                    <div class="post_date">
                        날짜
                    </div>
                </div>


            </div>
            <div class="postListFooter">
                <form action="postPage.jsp">
                    <input type="submit" class="postListButton" value="글쓰기">    
                </form>
                
               
            </div>
        </div>
    </main>

    <footer>
        <div>문의</div>
        <div>전화번호: 010-8549-0120</div>
        <div>이메일:juneh2633@gmail.com</div>
    </footer>

    <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");
        String sql = "SELECT * FROM post";
        PreparedStatement query = connect.prepareStatement(sql);
        ResultSet result = query.executeQuery();
        int postUid = 0;
        String writerId = "";
        String title = "";
        Date postUpdateTime = null;
        int postDelete = 0;
        while(result.next()){
            postUid = result.getInt(1);
            writerId = result.getString(2);
            title = result.getString(3);
            postUpdateTime = result.getDate(6);
            postDelete = result.getInt(7);
            if(postDelete==0){

    %>
        <script>
            
            var postBox = document.createElement('div');
            postBox.id= '<%= postUid %>';
            postBox.className = "post_box";
            console.log(postBox.id); 
            document.getElementById("postEmptyList").appendChild(postBox);
            var postElement = document.createElement("div");
            postElement.className = "post_uid";
            postElement.innerHTML = '<%= postUid %>';
            postBox.appendChild(postElement);
            var postElement = document.createElement("div");
            postElement.className = "post_userId";
            postElement.innerHTML = '<%= writerId %>';
            postBox.appendChild(postElement);   
            var postElement = document.createElement("a");
            postElement.setAttribute("href", "postReadPage.jsp?postUid="+'<%= postUid %>');
            postElement.className = "post_title";
            postElement.innerHTML = '<%= title %>';
            postBox.appendChild(postElement);     
            var postElement = document.createElement("div");
            postElement.className = "post_date";
            postElement.innerHTML = '<%= postUpdateTime %>';
            postBox.appendChild(postElement);     
        </script>
    <%
            }
        }
        result.close();
        query.close();
        connect.close();
    %>
</body>

</html>