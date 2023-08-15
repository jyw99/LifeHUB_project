<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.7.0.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital@1&display=swap" rel="stylesheet">
</head>
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
	
	.logout{
		font-family: 'Playfair Display', serif;
		font-size: large;
		font-weight: bold;
		color: navy;
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
	
	.pfImg{
		width: 100%;
		height: 100%;
		border-radius: 50%;
	}
	
	.txt {
		font-family: 'Do Hyeon', sans-serif;
		font-size: 1.5em;
	}
	
	.mypf {
		border: 1px solid navy;
		border-radius: 50%;
		width: 180px;
		height: 180px;
		display: inline-block;
		margin-right: 20px;
	}
	
	.uid {
		font-size: 2.3em;
	}
	
	.user {
		margin-left: 20px;
	}
	
	.pf{
		display: flex;
		justify-content: center;
		margin-top: 40px;
		margin-bottom: 40px;
	}
	
	#myPostImg{
		width: 250px;
		height: 250px;
	}
	
	.mylist {
		display: grid;
  		grid-template-columns: repeat(3, 1fr);
  		grid-gap: 10px;
	}

	.item {
  		display: flex;
  		justify-content: center;
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
		<div class="pf">
			<div class="mypf"><img src='pfImg/${user.pfImg }' class="pfImg"></div>
			<div class="user">
				<div class="txt uid">${user.uid }</div>
				<div class="txt">게시 <span>3</span> 팔로워 <span>100</span> 팔로잉 <span>100</span></div>
				<div>${user.info }여기 소개 들어가는건디</div>
				<button>마이페이지</button><button>프로필편집</button>
			</div>
		</div>
		<hr>
		<div class="mylist">
			<c:forEach var="mlist" items="${mylist }">
				<!-- 여기 사진 3개씩 들어가고 3개가 다 채워지면 다음 줄에 사진 -->
				<div class="item"><img src="files/${mlist.postImg }" id="myPostImg" onclick="openModal('${mlist.postImg }','${mlist.postContent }')"></div>
				
				<div class="modal">
            		<div class="modalContent" id="modalContent_${mlist.pno}">
                		<span class="closeBtn" onclick="closeModal(${mlist.pno})">X</span>
                		<div class="mdPost">
                			<div class="mdpostImg"><img src="files/${mlist.postImg }" id="mdpimg"></div>
                			<div class="mdpf">
                				<div class="md">
                					<div class="mypost"><img src="pfImg/${mlist.pfImg }" width="45px" class="pfImg"></div>
                					<div>${mlist.uid }</div>
                				</div>
                				<hr>
                				<div id="mdcont">${mlist.postContent }</div>
                			</div>
                		</div>
            		</div>
        		</div>
			</c:forEach>
		</div>
		
	</div>
</div>

<script>
	function openModal(image,content) {
		var mdpimg = document.querySelector("#mdpimg");
		mdpimg.setAttribute('src', "files/"+image);
		var mdcont = document.querySelector("#mdcont");
		mdcont.innerHTML = content;
	    var modal = document.querySelector(".modal");
	    //var modalContent = document.querySelector("#modalContent_" + pno);
	
	    modal.style.display = "flex";

	}
	
	function closeModal(pno) {
	    var modal = document.querySelector(".modal");
	    var modalContent = document.querySelector("#modalContent" + pno);
	
	    modal.style.display = "none";
	}

	/*function openModal(pno) {
        var modal = document.querySelector(".modal");
        var modalContent = document.querySelector("#modalContent_" + pno);
        var modalPostImg = document.querySelector("#modalPostImg_" + pno);
        
        // 모달 내용 업데이트
        modalPostImg.src = "files/" + modalPostImg.getAttribute('src');

        modal.style.display = "flex"; // 모달 보이기
    }

    function closeModal(pno) {
        var modal = document.querySelector(".modal");
        var modalContent = document.querySelector("#modalContent_" + pno);
        var modalPostImg = document.querySelector("#modalPostImg_" + pno);

        modal.style.display = "none";
        modalPostImg.src = ""; // 이미지 초기화
    }*/
</script>
 

</body>
</html>