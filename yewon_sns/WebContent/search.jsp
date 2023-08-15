<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LifeHUB Search</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital@1&display=swap" rel="stylesheet">
<style>
	.container {
		display: grid;
		grid-template-columns: 100px 200px 200px 200px 200px 200px;
		grid-template-rows: repeat(4, 220px);
		width: 1100px;
		margin: auto;
	}
	
	.nav {
		grid-column-start: 1;
		grid-column-end: 2;
		grid-row-start: 1;
		grid-row-end: 5;
		border: 1px solid navy;
	}
	
	.content {
		grid-row-start: 1;
		grid-row-end: 5;
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
	
	.menu {
		width: 45px;
		height: 45px;
		margin: auto;
		margin-top: 100px;
	}
	
	.pfImg{
		width: 100%;
		height: 100%;
		border-radius: 50%;
	}
	
	.logout{
		font-family: 'Playfair Display', serif;
		font-size: large;
		font-weight: bold;
		color: navy;
	}
	
	#pfimgdiv{
		width: 50px;
		height: 50px;
		border-radius: 50%;
		border: 1px solid navy;
		display: inline-block;
	}
	
	.mypost {
		border: 1px solid navy;
		border-radius: 50%;
		width: 45px;
		height: 45px;
	}
	
	#sid {
		width: 700px;
		height: 50px;
		margin-top : 40px;
		border: 1px solid navy;
		border-radius: 10px;
	}
	
	#sid:focus {
		outline-color: navy;
	}
	
	.scont {
		width: 100%;
		display: flex;
  		justify-content: center; /* 가로 가운데 정렬 */
	}
	
	#resultId
	
	
</style>
</head>
<body>
<div class="container">
		<div class="nav">
			<div class="title"><a href="main.jsp">Life<br>HUB</a></div>
			<div class="menu"><a href="main.jsp"><img src="img/home.png" width='45px'></a></div>
			<div class="menu"><a href="search.jsp"><img src="img/search.png" width='45px'></a></div>
			<div class="menu"><a href="registPost.jsp"><img src="img/plus.png" width='45px'></a></div>
			<div class="menu mypost"><a href="mypost.jsp"><img src="pfImg/${user.pfImg }" class="pfImg"></a></div>
			<div class="menu logout"><a href="logout">Logout</a></div>
		</div>
		<div class="content">
			<div class="scont">
				<input type="text"  id="sid">
			</div>
			<div id="resultId"></div>
		</div>
	</div>

<script>
	//아이디 검색... keyup
	const putId = document.getElementById('sid');
	const resultId = document.getElementById('resultId');
	putId.addEventListener("keyup", searchId);

	function searchId(){
		
		//putid 값을 받아서 trim() 함수로 공백을 지우고 그 값이 빈 문자열이면 result.innerHTML 지우고 함수 종료
		const keyword = putId.value.trim();
			if (keyword == "") {
				resultId.innerHTML = "";
				return false;
			}
			
		const xhr = new XMLHttpRequest();
		xhr.onload = function() {
			//검색할 때 마다 초기화 해줘야지 검색값이 누적안됨!!!
			resultId.innerHTML = "";
			
			const result = this.responseText;
			const user = JSON.parse(this.responseText);
	
			//alert(user);
			for (var i = 0; i < user.length; i++) {
				resultId.innerHTML += "<div id='pfimgdiv'><a href=''><img src='pfImg/"+user[i].pfImg+"' class='pfImg'></a></div><div id='userid'><a href=''>"+user[i].uid+"</a></div>";
			}
		}
		xhr.open("GET", "searchId?uid="+putId.value, true);
		xhr.send();
	}
</script>
</body>
</html>