<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up Page</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital@1&display=swap" rel="stylesheet">
<script src="js/jquery-3.7.0.js"></script>
<style>
	
	.container {
		width: 500px;
		height: 800px;
		margin: auto;
		border: 1px solid navy;
	}
	
	
	#txt {
		font-family: 'Playfair Display', serif;
		font-size: x-large;
		font-weight: bold;
		color: navy;
	}
		
	#title {
		font-family: 'Playfair Display', serif;
		text-align: center;
		font-size: 3em;
		color: navy;
		text-align: center;	
	}
	
	#logo {
		font-family: 'Playfair Display', serif;
		text-align: center;
		line-height: 200px;
		font-size: 3em;
		color: navy;
		margin-bottom: 0;
	}
	
	table {
		margin: auto;
		text-align: center;
	}
	
	tr {
		height: 60px;
	}
	
	#cancelBtn , #signupBtn {
		font-family: 'Playfair Display', serif;
		text-align: center;
		color: white;
		background-color: navy;
		width: 100px;
		height: 50px;
		border: 0;
		text-align: center;
		border-radius: 10px;
		
	}
	
	input , select, option, textarea {
		outline-color: navy;
		width: 200px;
		height: 30px;
	}
</style>

</head>
<body>
<h1 id="title">Share your happy moments</h1>
<div class="container">
<h1 id="logo">LifeHUB</h1>
	<form action="signup" method="post" name="frm">
		<table>
			<tr>
				<td id="txt">NAME</td>
				<td><input type="text" name="name" id="name"></td>
			</tr>
			<tr>
				<td id="txt">ID</td>
				<td>
					<input type="text" name="id" id="id">
				</td>
			</tr>
			<tr>
				<td id="txt">PASSWORD</td>
				<td><input type="password" name="pw" id="pw"></td>
			</tr>
			<tr>
				<td id="txt">RE-PASSWORD</td>
				<td><input type="password" name="repw" id="repw"></td>
			</tr>
			<tr>
				<td id="txt">TEL</td>
				<td><input type="text" name="tel" id="tel"></td>
			</tr>
			<tr>
				<td id="txt">GENDER</td>
				<td>
					<select name="gender">
						<option disabled>Select</option>
						<option value="여성">여성</option>
						<option value="남성">남성</option>
					</select>
				</td>
			</tr>
			<tr>
				<td id="txt">INFO</td>
				<td>
					<textarea rows="5" cols="20"></textarea>
				</td>
			</tr>
			<tr>
				<td id="txt">AGE</td>
				<td>
					<input type="text" name="age" id="age">
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="Sign Up" id="signupBtn" onclick="return signup()"></td>
				<td><a href="login.jsp"><button type="button" id="cancelBtn">Cancel</button></a></td>
			</tr>
		</table>	
	</form>
</div>

<script>
	function signup(){
		
		if ($('#name').val()=="") {
			alert('이름을 입력해주세요.');
			$('#name').focus();
			return false;
		}
		
		if ($('#id').val()=="") {
			alert('아이디를 입력하세요.');
			$('#id').focus();
			return false;
		}
		
		if ($('#id').val().match("admin")) {
			alert('사용할 수 없는 아이디입니다. \n admin 문자 사용불가.');
			$('#id').focus();
			return false;
		}
		
		if ($('#pw').val()=="") {
			alert('비밀번호를 입력하세요.');
			$('#pw').focus();
			return false;
		}
		if ($('#repw').val() == "") {
			alert('비밀번호 재확인을 해주세요.');
			$('#repw').focus();
			return false;
		}
		if ($('#tel').val() == "") {
			alert('연락처를 입력하세요.');
			$('#tel').focus();
			return false; 
		}
		if ($('#age').val()=="") {
			alert('나이를 입력하세요.');
			$('#age').focus();
			return false;
		}
		
		//비밀번호랑.. 비밀번호 재입력이랑 같은지 아닌지 확인해야함~~
		if ($('#pw').val() != $('#repw').val()) {
			alert('비밀번호가 일치하지않습니다.');
			$('#repw').focus();
			return false;
		}
		
		//아이디 중복 체크 해야대~~~
		//db에 저장되어있는 아이디랑 비교해서 확인 아작스,,
		const xhr = new XMLHttpRequest();
		xhr.onload = function(){
			let result = this.responseText;
			if (result == "idxx") {
				alert('이미 사용중인 아이디입니다.');
				$('#id').focus();
			}else {
				//강제로 폼 넘기는거랬음..
				frm.submit();
			}
		}
		
		xhr.open("post","idcheck");
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		const data = "id="+$('#id').val();
		xhr.send(data);
		
		return false;
		
	}
	
</script>
</body>
</html>