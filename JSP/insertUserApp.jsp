<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 

<% 
    request.setCharacterEncoding("utf-8"); //전페이지 request 
    String idValue = request.getParameter("id_value");
    String nameValue = request.getParameter("name_value");
    String passwordValue = request.getParameter("password_value");
    String passwordCheckValue = request.getParameter("password_check_value");
    String emailValue = request.getParameter("email_value");
    String birthdateValue = request.getParameter("birthdate_value");
    String phonenumberValue = request.getParameter("phonenumber_value");
    idValue = idValue.replaceAll("\\s", "");
    nameValue = nameValue.replaceAll("\\s", "");
    passwordValue = passwordValue.replaceAll("\\s", "");
    emailValue = emailValue.replaceAll("\\s", "");
    birthdateValue = birthdateValue.replaceAll("\\s", "");
    phonenumberValue = phonenumberValue.replaceAll("\\s", "");
    if(idValue.length()==0){
        out.println("<script>alert('아이디를 입력해주세요.'); history.back();</script>");
        return;       
    }
    if(idValue.length() <= 3){
        out.println("<script>alert('아이디는 4자 이상 넣어주세요.'); history.back();</script>");
        return;       
    }
    if(idValue.length()>15){
        out.println("<script>alert('아이디는 15자를 넘어갈 수 없습니다.'); history.back();</script>");
        return;       
    }
    if(nameValue.length()==0){
        out.println("<script>alert('이름을 입력해주세요.'); history.back();</script>");
        return;
    }
    if(nameValue.length()>15){
        out.println("<script>alert('이름은 15자를 넘어갈 수 없습니다.'); history.back();</script>");
        return;
    }
    if(passwordValue.length()==0){
        out.println("<script>alert('비밀번호를 입력해주세요.'); history.back();</script>");
        return;
    }
    if(passwordValue.length()<=3){
        out.println("<script>alert('비밀번호는 4자 이상 넣어주세요.'); history.back();</script>");
        return;
    }
    if(passwordValue.length()>15){
        out.println("<script>alert('비밀번호는 15자를 넘어갈 수 없습니다.'); history.back();</script>");
        return;
    }
    if(passwordCheckValue.length()==0){
        out.println("<script>alert('비밀번호 확인을 입력해주세요.'); history.back();</script>");
        return;
    }
    if (!passwordValue.equals(passwordCheckValue)) {        
        out.println("<script>alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.'); history.back();</script>");
        return;
    }
    if (emailValue.length()==0) {
        out.println("<script>alert('이메일을 입력해주세요.'); history.back();</script>");
        return;
    }
    if (emailValue.length()>30) {
        out.println("<script>alert('이메일은 30자를 넘어갈 수 없습니다.'); history.back();</script>");
        return;
    }
    if (birthdateValue.length() != 8) {
        out.println("<script>alert('생년월일은 8자리로 입력해주세요.'); history.back();</script>");
        return;
    }
    if (phonenumberValue.length() != 11) {
        out.println("<script>alert('전화번호 010xxxxyyyy로 입력해주세요.'); history.back();</script>");
        return;
    }    
    Class.forName("com.mysql.jdbc.Driver");
    // 현재 시간 얻기
    Date currentDate = new Date();
    Timestamp currentTimestamp = new Timestamp(currentDate.getTime());
    
    //데이터 베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/post_page", "juneh","2633");
    
    String sqlIdCheck = "SELECT * FROM user";
    PreparedStatement queryIdCheck = connect.prepareStatement(sqlIdCheck);
    
    ResultSet result = queryIdCheck.executeQuery();
    while(result.next()){
        if( idValue.equals( result.getString(1) ) ){
            out.println("<script>alert('중복되는 아이디가 존재합니다. 다른 아이디를 입력해주세요.'); history.back();</script>");
            return;
        }
    }
    String sql = "INSERT INTO user (id, name, password, email, birthdate, phonenumber, deleted) VALUES (?, ?, ?, ?, ?, ? , 0)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, nameValue);
    query.setString(3, passwordValue);
    query.setString(4, emailValue);
    query.setString(5, birthdateValue);
    query.setString(6, phonenumberValue);
    //  query 전송
    try{
        query.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('날짜를 다시 입력해주세요'); history.back();</script>");
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
        alert("회원가입에 성공하였습니다. 로그인 해주세요.")
        location.href="../loginPage.html"
    </script>
</body>