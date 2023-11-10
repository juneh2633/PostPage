var replyBox = document.createElement('div');
replyBox.className = "reply_box";
console.log(replyBox.id);
document.getElementById("postReadFooter").appendChild(replyBox);
var replyElement = document.createElement("div");
replyElement.className = "reply_userId";
replyElement.innerHTML = '<%= userId %>';
replyBox.appendChild(replyElement);
var replyElement = document.createElement("div");
replyElement.className = "reply_main";
replyElement.innerHTML = '<%= replyMain %>';
replyBox.appendChild(replyElement);
var replyElement = document.createElement("div");
replyElement.className = "reply_date";
replyElement.innerHTML = '<%= replyUpdateTime %>';
replyBox.appendChild(replyElement);     
var replyUpdateButton = document.createElement("input");
var replyDeleteButton = document.createElement("input");
replyUpdateButton.id = 'replyUpdate<%= replyUid %>';
replyDeleteButton.id = 'replyDelete<%= replyUid %>';
replyUpdateButton.className = "replyUpdateButton";
replyDeleteButton.className = "replyUpdateButton";
if('<%= userId %>' == '<%= id%>'){
    replyUpdateButton.setAttribute('style','display: block;');
    replyUpdateButton.setAttribute('type', 'button');
    replyUpdateButton.setAttribute('value', '수정');
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
replyBox.appendChild(replyUpdateButton); 
replyBox.appendChild(replyDeleteButton); 