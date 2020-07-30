<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/join.js" charset="utf-8"></script>
</head>
<body>
	<c:if test="${joinResult==1 }">
		<script type="text/javascript">
			alert("가입이 정상적으로 완료되었습니다. 로그인 화면으로 이동합니다.");
			window.location.href="login";
		</script>
	</c:if>
	<h2>회원가입</h2>
	<form action="joinOk" name="join_form" method="post" onsubmit="return allCheck();">
	
		<label for="id">아이디 : </label>
		<input type="text" name="id" id="id"><br><br>
		<a onclick="idCheck();"><button type="button">중복확인</button> </a><br>
		<p id="checkResult" style="color: red;"></p>
		<input type="hidden" name="check" id="check">
		<label for="pw">패스워드 : </label>
		<input type="text" name="pw" id="pw"><br>
		<label for="pw">패스워드 확인 : </label>
		<input type="text" name="pw2" id="pw2"><br>
		<label for="name">이름 </label>
		<input type="text" name="name" id="name"><br>
		
		<input type="submit" value="가입하기">
	</form>
		<a href="login"><button>취소</button> </a>
	
	


</body>
</html>