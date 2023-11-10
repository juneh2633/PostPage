function updateUserInfoEvent(info) {
    let option = "width = 500, height = 500, top = 100, left = 200, scrollbars = no, location = no";
    option = option;
    window.open("../PostPage/infoUpdatePage.jsp?updateInfo="+info, option);
}
function replyEvent(postUid) {
    var replyMain = document.getElementById("replyMain").value;
    console.log("replyEvent 실행");
    window.location.href="../PostPage/JSP/insertReplyApp.jsp?postUid="+postUid+"&replyMain="+replyMain;
}

function postDeleteEvent(postUid) {
    if (confirm("정말 삭제하시겠습니까?")) {
        window.location.href="../PostPage/JSP/deletePostApp.jsp?postUid="+postUid;     
    }
    
}

function userDeleteEvent(id) {
    if (confirm("계정을 삭제해도 글은 지워지지 않습니다.\n정말 삭제하시겠습니까?")) {
        window.location.href="../PostPage/JSP/deleteUserApp.jsp?id="+id;    
    }
   
}
function replyDeleteEvent(replyUid) {
    window.location.href="../PostPage/JSP/deleteReplyApp.jsp?replyUid="+replyUid;   
}
function replyUpdateEvent(replyUid) {
    
    console.log("함수 실행완");
    var reply = document.getElementById('reply_main' + replyUid);
    reply.style.display = "none";
    var replyDate = document.getElementById('reply_date' + replyUid);
    replyDate.style.display = "none";
    var replyDeleteButton = document.getElementById('replyDelete' + replyUid);
    
    var replyUpdateButton = document.getElementById('replyUpdate' + replyUid);
    replyUpdateButton.value = "완료";
    replyDeleteButton.value = "취소";
    replyUpdateButton.style.display = "inline";
    replyDeleteButton.style.display = "inline";   
    replyUpdateButton.setAttribute('type', 'submit');
    replyDeleteButton.setAttribute('onclick', 'replyUpdateCancel()');
    var replyUpdateText = document.getElementById('replyUpdateText' + replyUid);
    replyUpdateText.style.display = "block";
    replyUpdateText.style.width = "350px";
    replyUpdateText.style.height = "100px";
    replyUpdateText.style.wrap = "on";
    replyUpdateText.style.resize = "none";
    var form = document.getElementById('replyForm' + replyUid);
    form.setAttribute("action","../PostPage/JSP/updateReplyApp.jsp")
    
}
function replyUpdateCancel() {
    location.reload();
}

function postUpdateEvent() {
    var mainText = document.getElementById('mainText');
    mainText.style.display = "none";
    var postUpdateText = document.getElementById('postUpdateText');
    postUpdateText.style.display = "block";
    postUpdateText.style.resize = "none";
    postUpdateText.style.width = "400px";
    postUpdateText.style.height = "300px";
    var postDelete = document.getElementById('postDelete');
    var postUpdate = document.getElementById('postUpdate');
    postUpdate.value = "완료";
    postDelete.value = "취소";
    postUpdate.setAttribute('type', 'submit');
    postDelete.setAttribute('onclick', 'replyUpdateCancel()');
    
}
function userUpdateEvent() {
    window.location.href = "../PostPage/infoUpdatePage.jsp";
}