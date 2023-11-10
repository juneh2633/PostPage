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
    <link type="text/css" rel="stylesheet" href="CSS/postReadCSS.css">
    <link type="text/css" rel="stylesheet" href="CSS/replyCSS.css">
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
        
        String postUid = request.getParameter("postUid");
        String sql = "SELECT * FROM post WHERE post_uid = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, postUid);
        ResultSet result = query.executeQuery();
        String writerId = "";
        String title = "";
        String maintext = "";
        int deleted = 0;
        if(result.next()){
            writerId = result.getString(2);
            title = result.getString(3);
            maintext = result.getString(4);
            deleted = result.getInt(7);
        }
        
        if(deleted==1){
            out.print("<script>alert('삭제 된 게시글입니다.'); window.location.href='postListPage.jsp';</script>");
            return;
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
        <div class="postReadBox">
            <input type="button" class="backBtn" value="<-" onclick="history.back();" />
            <div class="postReadHeader">
                <div class="postReadTitle">
                    <%= title %> 
                </div>
                <div class="writer">
                    작성자: <%= writerId %>   
                </div>                
            </div>
            <div class="postReadMain">
                <div class="postReadText">
                    <form action="JSP/updatePostApp.jsp">
                        <div id="mainText">
                            <pre><%= maintext %></pre>
                        </div>
                        
                        <textarea id="postUpdateText" name="maintext" class="postText" style="display: none;" rows="10" cols="10" wrap="on" maxlength="500" ><%= maintext %></textarea>
                        <input id="postUpdate" type="button" value="수정" ondblclick="postUpdateEvent()">
                        <input id="postDelete" type="button" value="삭제">           
                        <input id="postUid" type="hidden" name="postUid" value="<%=postUid%>">
                    </form>

                </div>
            </div>
            
            <div id="postReadFooter" class="postReadFooter">
                <div class="replyOnBox">
                    <input id="replyMain" type="text" class="commentInput" name="reply" placeholder="댓글 달기" maxlength='200'>
                    <input id="replyOn" type="button" class="commentButton" value="댓글 작성">
                    
                </div>

            </div>
        </div>
    </main>

    <footer>
        <div>문의</div>
        <div>전화번호: 010-8549-0120</div>
        <div>이메일:juneh2633@gmail.com</div>
    </footer>

    <script>
        var replyOn = document.getElementById("replyOn");
        replyOn.setAttribute('onclick', 'replyEvent(' + '<%=postUid%>' + ')');
        document.getElementById("postDelete").setAttribute('onclick', 'postDeleteEvent(' + '<%=postUid%>' + ')');
    </script>
    <%
        if(!id.equals(writerId)){
    %>

    <script>
            document.getElementById("postUpdate").style.display = 'none';
            document.getElementById("postDelete").style.display = 'none';
    </script>
    <%
        }


        String replySql = "SELECT * FROM reply WHERE post_uid = ?";
        PreparedStatement replyQuery = connect.prepareStatement(replySql);
        replyQuery.setString(1,postUid);
        ResultSet replyResult = replyQuery.executeQuery();
        int replyUid = 0;
        String userId = "";
        String replyMain= "";
        Date replyUpdateTime = null;
        while(replyResult.next()){
            replyUid = replyResult.getInt(1);
            userId= replyResult.getString(2);
            replyMain = replyResult.getString(4);
            replyUpdateTime = replyResult.getDate(5);
    %>  
        <script>
            var replyBox = document.createElement('div');
            replyBox.className = "reply_box";
            console.log(replyBox.id);
            document.getElementById("postReadFooter").appendChild(replyBox);
            var replyElement = document.createElement("div");
            replyElement.className = "reply_userId";
            replyElement.innerHTML = '<%= userId %>';
            replyBox.appendChild(replyElement);
            var replyElement = document.createElement("div");
            replyElement.id = 'reply_main<%= replyUid %>';
            replyElement.className = "reply_main";
            replyElement.innerHTML = '<%= replyMain %>';
            replyBox.appendChild(replyElement);
            var replyElement = document.createElement("div");
            replyElement.id = 'reply_date<%= replyUid %>';
            replyElement.className = "reply_date";
            replyElement.innerHTML = '<%= replyUpdateTime %>';
            replyBox.appendChild(replyElement);     
            var form = document.createElement("form");
            form.id = 'replyForm<%= replyUid %>';
            replyBox.appendChild(form);
            var replyUpdateText = document.createElement("textarea");
            replyUpdateText.id = 'replyUpdateText<%= replyUid %>';
            replyUpdateText.innerHTML ='<%= replyMain %>';
            replyUpdateText.name = "replyMain";
            replyUpdateText.style.display = "none";
    
            var replyUpdateButton = document.createElement("input");
            var replyDeleteButton = document.createElement("input");
            var replyUid= document.createElement("input");
            replyUpdateButton.id = 'replyUpdate<%= replyUid %>';
            replyDeleteButton.id = 'replyDelete<%= replyUid %>';
            replyUpdateButton.className = "replyUpdateButton";
            replyDeleteButton.className = "replyUpdateButton";
            replyUid.name = "replyUid";
            replyUid.type = "text";
            replyUid.value = '<%= replyUid %>';
            replyUid.setAttribute('style', 'display: none;');
            if('<%= userId %>' == '<%= id%>'){
                replyUpdateButton.setAttribute('style','display: block;');
                replyUpdateButton.setAttribute('type', 'button');
                replyUpdateButton.setAttribute('value', '수정');
                replyUpdateButton.setAttribute('ondblclick', 'replyUpdateEvent(<%=replyUid%>)');
                console.log("buttpm");
                replyDeleteButton.setAttribute('style', 'display: block;');
                replyDeleteButton.setAttribute('type', 'button');
                replyDeleteButton.setAttribute('value', '삭제');
                replyDeleteButton.setAttribute('onclick', 'replyDeleteEvent(<%=replyUid%>)');
            }
            else{
                replyUpdateButton.setAttribute('style', 'display: none;');
                replyDeleteButton.setAttribute('style', 'display: none;');
            }
            form.appendChild(replyUpdateText);
            form.appendChild(replyUpdateButton); 
            form.appendChild(replyDeleteButton); 
            form.appendChild(replyUid);
        </script>
    <%
        }    

        result.close();
        query.close();
        connect.close();
    %>

        <script src="JavaScript/updateData.js"></script>
</body>

</html>