<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Post Upload</title>
<title>Sign Up Page</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital@1&display=swap" rel="stylesheet">
<script src="js/jquery-3.7.0.js"></script>
<style>

	.container {
		width: 600px;
		height: 700px;
		border: 1px solid navy;
		margin: auto;
	}
	
	#title {
		font-family: 'Playfair Display', serif;
		text-align: center;
		font-size: 3em;
		color: navy;
		text-align: center;	
	}
	
	.btn {
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
	
	#txt {
		width: 600px;
		height: 70px;
		text-align: center;
		font-size: 1.5em;
		font-weight: bold;
		line-height: 70px;
		border-bottom: 1px solid navy;
	}
	
	#fileupload {
		width: 590px;
		height: 350px;
		border: 1px solid navy;
		margin: auto;
		text-align: center;
		margin-top: 5px;
		line-height: 350px;
	}
	
	.cont {
		width: 590px;
		height: 150px;
		border: 1px solid navy;
		margin: auto;
		margin-top: 5px;
	}
	
	#btndiv {
		width: 590px;
		height: 100px;
		margin: auto;
		text-align: center;
		line-height: 100px;
	}
	
	.btn:first-child {
		margin-right: 20px;	
	}
	
	.btn:last-child {
		margin-left: 20px;
	}
	
	.sessionId {
		width: 500px;
		height: 40px;	
		display: inline-block;
		font-weight: bold;
		font-size: x-large;
	}
	
	#postCont{
		width: 585px;
		height: 90px;
		border: 0;
	}
	
	#postCont:focus {
  		outline: none;
	}
	
	.pfimg{
		width: 40px;
		height: 40px;
		display: inline-block;
		border-radius: 50px;
		border: 1px solid navy;
		margin: 5px;
	}
	
	.userInfo {
		display: flex;
		align-items: center;
	}
	
	.pfimage {
		width: 40px;
		height: 40px;
		border-radius: 50px;
	}
	
</style>
</head>
<body>
<h1 id="title">Share your happy moments</h1>
<div class="container">
	<form action="registpost" method="post" enctype="multipart/form-data">
		<div id="txt">새 게시물 등록</div>
		<div id="fileupload"><input type="file" name="postImg"></div>
		<div class="cont">
		<div class="userInfo">
			<div class="pfimg"><img src="pfImg/${user.pfImg }" class="pfimage"></div>
			<div class="sessionId">${id }</div>
		</div>
			<textarea id="postCont" name="postContent"></textarea>		
		</div>
		<div id="btndiv"><input type="submit" value="Upload" class="btn"><button type="button" class="btn">Cancel</button></div>
	</form>
</div>

<script>
	
	$('.btn').on('click',function(){
		//캔슬 버튼을 누르면 다시 메인 페이지로 이동
		location.href = "main.jsp";
	})	
	
</script>
</body>
</html>