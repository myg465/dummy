<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/login.js" charset="utf-8"></script>
</head>
<body>
	<h2>로그인</h2>
	<form name="login_form" >
		<label for="id">아이디 : </label>
		<input type="text" name="id" id="id">
		<label for="pw">패스워드 : </label>
		<input type="text" name="pw" id="pw">
	
	</form>
	
	<div>
		<a onclick="login();"><button type="button">로그인</button></a>
		<a href="join"><button>회원가입</button></a>
	</div>
	<p id="loginResult" style="color: red"></p>


</body>
</html>