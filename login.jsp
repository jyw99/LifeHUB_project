<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LifeHUB</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital@1&display=swap" rel="stylesheet">
<style>
	
	.container {
		width: 900px;
		height: 900px;
		margin: auto;
		margin-top: 100px;
	}

	.slide_div {
		width: 400px;
		height: 700px;
		overflow: hidden;
		float: left;
	}
	
	.slideimg {
		display: none;
		width: 400px;
		height: 700px;
	}
	
	.slideimg.on {
		display: block;
	}
	
	.signup {
		width: 400px;
		height: 140px;
		border: 1px solid gray;
		margin-top: 20px;
	}
	
	.login {
		width: 400px;
		height: 500px;
		border: 1px solid gray;
		margin-top: 20px;
	}
	
	.login_cotainer {
		width: 400px;
		height: 700px;
		float: left;
		margin-left: 20px;
	}
	
	#logo {
		font-family: 'Playfair Display', serif;
		text-align: center;
		line-height: 200px;
		font-size: 2em;
		color: navy;
		margin-bottom: 0;
	}
	
	#txt {
		font-family: 'Playfair Display', serif;
		font-size: x-large;
		font-weight: bold;
		color: navy;
	}
	
	#sbtn {
		color: white;
		background-color: navy;
		width: 100px;
		height: 50px;
		border: 0;
		text-align: center;
		border-radius: 10px;
		font-family: 'Playfair Display', serif;
	}
	
	#title {
		font-family: 'Playfair Display', serif;
		text-align: center;
		font-size: 3em;
		color: navy;	
	}
	
	h3 {
		color: navy;
		text-align: center;
		line-height: 50px;
		margin-bottom: 0;
	}
	
	a{
		font-family: 'Playfair Display', serif;
		color: navy;
		font-weight: bold;
		font-size: x-large;
	}
	
	#id, #pw {
		outline-color: navy;
		width: 200px;
		height: 30px;
	}

	.signup {
		text-align: center;
	}
	
	table {
		margin: auto;
		text-align: center;
	}
	
</style>
</head>
<body>
	<div class="container">
	<h1 id="title">Share your happy moments</h1>
		<div class="slide_div">
			<img class="slideimg" src="img/main_img1.jpg"> 
			<img class="slideimg" src="img/main_img2.jpg">
			<img class="slideimg" src="img/main_img3.jpg"> 
			<img class="slideimg" src="img/main_img4.jpg">
		</div>
		<div class="login_cotainer">
			<div class="login">
			<h1 id="logo">LifeHUB</h1>
			<form name="frm" action="movemain" method="post">
					<table>
						<tr>
							<td id="txt">ID</td>
							<td><input type="text" name="id" id="id"></td>
						</tr>
						<tr>
							<td id="txt">PASSWORD</td>
							<td><input type="password" name="pw" id="pw"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="submit" value="Login" id="sbtn" onclick="return login()"></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="signup">
				<h3>아직 회원이 아니신가요?</h3>
				<a href="signupForm.jsp">Sign Up</a>
			</div>
		</div>
	</div>
	<script>

	const images = document.querySelectorAll('.slideimg');
	let current = 0;

	function showSlide() {
		for (let i = 0; i < images.length; i++) {
			images[i].classList.remove('on');
		}
		current++;
		if (current > images.length) {
			current = 1;
		}
		images[current - 1].classList.add('on');
		setTimeout(showSlide, 3000);
	}

	showSlide();
</script>
<script>
	
		//const sbtn = document.getElementById('sbtn');
		
		function login(e){
			const id = document.getElementById('id');
			const pw = document.getElementById('pw');
			if (id.value == "") {
				alert('아이디를 입력해주세요.');
				id.focus();
				return false;
			}
			if (pw.value == "") {
				alert('비밀번호를 입력해주세요.');
				pw.focus();
				return false;
			}
			
			//데이터 베이스랑 값 비교해서 아이디 비교
			const xhr = new XMLHttpRequest();
			xhr.onload = function(){
				let result = this.responseText;
				if (result != "1") {
					alert('아이디 또는 비밀번호가 일치하지 않습니다.');
					id.focus();
				} else{
					frm.submit();
					//return true;
				}
				
			}
			
			xhr.open("post","loginCheck");
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			const data = "id="+id.value+"&pw="+pw.value;
			xhr.send(data);
			
			return false;
		
		}

</script>
	
	
	
<script>

</script>
</body>
</html>