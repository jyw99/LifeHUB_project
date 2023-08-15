<%@page import="java.sql.Connection"%>
<%@page import="vo.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LifeHUB HOME</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital@1&display=swap" rel="stylesheet">
<style>
	.container {
		display: grid;
		grid-template-columns: 100px 200px 200px 200px 200px 200px;
  		grid-template-rows:repeat(4,220px);
  		width: 1100px;
  		margin: auto;
	}
	
	.nav{
		grid-column-start: 1;
		grid-column-end: 2;
		grid-row-start: 1;
		grid-row-end : 5;
		border: 1px solid navy;
	}
	
	.content{
		grid-row-start: 1;
		grid-row-end : 5;
		grid-column-start: 2;
		grid-column-end: 6;
		border: 1px solid navy;
		overflow: scroll;
	}
	
	.title {
		font-family: 'Playfair Display', serif;
		font-weight: bold;
		font-size: x-large;
		text-align: center;
		margin: auto;
		margin-top: 50px;
	}
	
	table {
		margin: auto;
		margin-top: 20px;
	}
	
	img {
		margin: auto;
	}
	
	#image {
		width: 500px;
		height: 500px;
	}
	
	#pfimgdiv{
		width: 50px;
		height: 50px;
		border-radius: 50%;
		border: 1px solid navy;
		display: inline-block;
	}
	
	.pfImg{
		width: 100%;
		height: 100%;
		border-radius: 50%;
	}
	
	.menu {
		width: 45px;
		height: 45px;
		margin: auto;
		margin-top: 100px;
	}
	
	.mypost {
		border: 1px solid navy;
		border-radius: 50%;
		width: 45px;
		height: 45px;
	}
	
	.pagenation {
		width: 100%;
		text-align: center;
	}
	
	#reply{
		width: 400px;
		height: 100%;
		font-size: medium;
	}
	
	#reply:focus{
		outline: none;
	}
	
	#rpbtn {
		background-color: navy;
		color: white;
		width: 80px;
		border-radius: 5px;
	}

	#userid{
		display: inline-block;
		font-family: 'Playfair Display', serif;
		font-size: x-large;
		font-weight: bold;
		margin-left: 25px;

	}
	
	#btdiv{
		width : 100%;
		height: 15px;
	}
	
	.logout{
		font-family: 'Playfair Display', serif;
		font-size: large;
		font-weight: bold;
		color: navy;
	}
	
	.totalpf{
		display: flex;
		align-items: center;
	}
	
		.modal{
		display: none; 
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    /*background-color: rgba(0, 0, 0, 0.5);*/
	    justify-content: center;
	    align-items: center;
	}

	.modalContent {
    	background-color: rgba(0, 0, 0, 0.2);
    	padding: 20px;
    	border-radius: 3px;
    	position: relative;
    	/*max-width: 80%;*/
	}

	.closeBtn {
  		position: absolute;
    	top: 10px;
    	right: 10px;
    	cursor: pointer;
	}
	
	.mdpostImg {
		display: inline-block;
		vertical-align: top;
	}
	
	#mdpimg{
		width: 500px;
		height: 500px;
	}
	
	.mdpf {
		background: white;
		display: inline-block;
		vertical-align: top;
		width: 500px;
		height: 500px;
	}
	
	.md {
		display: flex;
		align-items: center;
	}
	
</style>
<script src="js/jquery-3.7.0.js"></script>
</head>
<body>

	<div class="container">
		<div class="nav">
			<div class="title"><a href="main.jsp">Life<br>HUB</a></div>
			<div class="menu"><a href="main.jsp"><img src="img/home.png" width='45px'></a></div>
			<div class="menu"><a href="search.jsp"><img src="img/search.png" width='45px'></a></div>
			<!-- 게시글 등록할 때 프로필사진도 같이.. 어케함,, -->
			<div class="menu"><a href="registPost.jsp"><img src="img/plus.png" width='45px'></a></div>
			<div class="menu mypost"><a href="mypost.jsp"><img src="pfImg/${user.pfImg }" class="pfImg"></a></div>
			<div class="menu logout"><a href="logout">Logout</a></div>
		</div>
		<div class="content">
			<table>
				<c:forEach var="post" items="${plist }">
				
				<tr>
					<td>
						<div class="totalpf">
							<div id="pfimgdiv"><img src="pfImg/${post.pfImg }" class="pfImg"></div>
							<div id="userid">${post.uid }</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2"><img src="files/${post.postImg }" id="image"></td>
				</tr>
				<tr>
					<td>${post.uid }</td>
					<td>${post.postContent }</td>
				</tr>
				<tr>
					<td colspan="2" onclick="openModal('${post.postImg }','${post.postContent }','${post.uid }')">
					댓글 <span id="rpcnt_${post.pno }">${post.replyCnt }</span>개 모두보기</td>
				</tr>
				<tr>
   					<td colspan="2"><input type="text" id="reply_txt_${post.pno }">
   					<button id="rpbtn" onclick="regReply(${post.pno })">Register</button></td>
				</tr>
				<tr id="btdiv"></tr>
				
				<div class="modal">
            		<div class="modalContent" id="modalContent_${post.pno}">
                		<span class="closeBtn" onclick="closeModal(${post.pno})">X</span>
                		<div class="mdPost">
                			<div class="mdpostImg"><img src="files/${post.postImg }" id="mdpimg"></div>
                			<div class="mdpf">
                				<div class="md">
                					<div class="mypost"><img src="pfImg/${post.pfImg }" width="45px" class="pfImg"></div>
                					<div id="mduid">${post.uid }</div>
                				</div>
                				<hr>
                				<div id="mdcont">${post.postContent }</div>
                				<hr>
                				<!-- 여기 댓글이 나와야함... -->
                				<%
                					//ReplyDao dao = new ReplyDao();
                					//dao.getReply(pno);
                				%>
                			</div>
                		</div>
            		</div>
        		</div>
				
				</c:forEach>				
				
			</table>
			<!-- 
			<div class="pagenation">
				<c:if test="${ endNum>lastNum }">
				<c:set var="endNum" value="${lastNum }" />
				</c:if>
				<c:if test="${startNum != 1 }">
					<a href="postlist?p=${startNum-1 }">◀</a>
				</c:if>
				<c:forEach var="i" begin="${startNum }" end="${endNum }">
					<a href="postlist?p=${ i}">${ i}</a> &nbsp; &nbsp;
				</c:forEach>
				<a href="postlist?p=${endNum+1 }">▶</a>
			</div>
			 -->
		</div>
	</div>
</body>
<script>
	//댓글 다는 ajax
	//버튼을 누르면 그럼 form action 쓰지말고 그냥 input 태그랑 button으로 
	function regReply(pno){
	let rpcnt = document.getElementById('rpcnt_'+pno);
	//const hdpno = document.getElementById('hdpno').value;
	let reply = document.getElementById('reply_txt_'+pno);
	
		if (reply.value == "") {
			alert('댓글을 입력해주세요.');
			reply.focus();
			return false;
		}
		
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
			rpcnt.innerHTML = this.responseText;
			reply.value=null;
		}
		xhttp.open("POST", "replyadd", true);
		xhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");

		let data = "pno=" + pno + "&reply=" + reply.value;
		xhttp.send(data);
	}
	
	
	function openModal(image,content,uid) {
		console.log(uid);
		var mdpimg = document.querySelector("#mdpimg");
		mdpimg.setAttribute('src', "files/"+image);
		var mdcont = document.querySelector("#mdcont");
		mdcont.innerHTML = content;
		var uid = document.querySelector("#mduid");
		mduid.innerHTML = uid;
	    var modal = document.querySelector(".modal");
	    //var modalContent = document.querySelector("#modalContent_" + pno);
	
	    modal.style.display = "flex";

	}
	
	function closeModal(pno) {
	    var modal = document.querySelector(".modal");
	    var modalContent = document.querySelector("#modalContent" + pno);
	
	    modal.style.display = "none";
	}
</script>
</html>