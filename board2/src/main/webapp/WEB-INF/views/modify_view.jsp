<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글수정</title>
</head>
<body>
	<c:if test="${modifyResult==1 }">
		<script type="text/javascript">
			alert("저장이 완료되었습니다.");
			window.location.href="list";
		</script>
	</c:if>
	<h2>글수정</h2>
	<form action="modifyOk" name="modify_form" method="post">
		<input type="hidden" name="board_id" value="${modify_view.board_id }">
		<table border="1">
			<tr>
				<th>제목</th>
				<th>내용</th>
				<th>아이디</th>
				
			</tr>
			<tr>
				<td>
				<input type="text" name="title" value=" ${modify_view.title }" required>
				</td>
				<td>
				<textarea rows="5" cols="17" name="content" required>
${modify_view.content }
				</textarea>
				</td>
				<td>
				${modify_view.id }
				</td>
			
			</tr>
		</table>
		<input type="submit" value="저장"><br>
	</form>
		<a href="list"><button>취소</button></a>
</body>
</html>