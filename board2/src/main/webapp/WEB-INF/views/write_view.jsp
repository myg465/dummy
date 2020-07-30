<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${writeResult==1 }">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		window.location.href="list";
	</script>
</c:if>
<h2>게시글 작성</h2>
<form action="writeOk" name="write_form" method="post">
	<table border="1">
		<tr>
			<th>제목</th>
			<th>내용</th>
			<th>아이디</th>
			
		</tr>
		<tr>
			<td>
			<input type="text" name="title" required>
			</td>
			<td>
			<textarea rows="5" cols="17" name="content" required></textarea>
			</td>
			<td>
			<input type="text" name="id" value="${authId }" readonly>
			</td>
		
		</tr>
	</table>
	<input type="submit" value="작성완료"><br>
</form>
	<a href="list"><button>취소</button></a>
</body>
</html>