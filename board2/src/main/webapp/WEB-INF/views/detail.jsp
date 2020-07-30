<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판 글읽기</title>
<script type="text/javascript" src="js/detail.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
   <h2>글읽기</h2>
   <p>로그인 사용자: ${name } 님 <a href="logout" onclick="return confirm('로그아웃 하시겠습니까?')"><button>로그아웃</button></a></p>
   
   <table border="1">
   		<tr>
   			<th>제목</th>
   			<th>아이디</th>
   			<th>작성일</th>
   		</tr>
   		<tr>
   			<td>${detail_view.title }</td>
   			<td>${detail_view.id }</td>
   			<td><fmt:formatDate value="${detail_view.created_date }" dateStyle="short"/> </td>
   		</tr>
   		<tr>
   			<th  colspan="3">내용</th>
   		</tr>
   		<tr>
   			<td colspan="3">
   				${detail_view.content }
   			</td>
   			
   		</tr>
   </table>
   <div>
  	  <h4>댓글</h4>
	  <table border="1">
	   		<c:forEach var="reply" items="${reply_view }">
	   			<!-- 본인 댓글이 아닐경우 -->
	   			<c:if test="${authId!=reply.user_id }">
			   		<tr>
			   			<th>내용</th>
			   			<td>${reply.reply_content}</td>
			   		</tr>
			   		<tr>
			   			<th>아이디</th>
			   			<td>${reply.user_id }</td>
			   		</tr>
			   		<tr>
			   			<th>작성일</th>
			   			<td><fmt:formatDate value="${reply.reply_date }" dateStyle="short"/></td>
			   		</tr>
			   		<tr>
			   			<th>수정일</th>
			   			<td><fmt:formatDate value="${reply.reply_modified_date }" dateStyle="short"/></td>
			   		</tr>
			   		<tr>
			   			<th colspan="2">
			   			-------------------------------
			   			</th>
			   		</tr>
		   		</c:if>
		   		
		   		<c:if test="${authId==reply.user_id }">
		   			<tr id="re_modify_form">
				   		<td>
			  				<textarea rows="5" cols="17" name="reply_content" id="re_modify_content">
${reply.reply_content }
			  				</textarea>
			  			</td>
			  			<td>
			  				<span>작성자 : ${reply.user_id }</span><br>
			  				<a onclick="re_modify(${reply.reply_id})"><button type="button">수정</button></a>
			   				<a onclick="re_delete(${reply.reply_id});"><button type="button">삭제</button></a>
			  			</td>
		  			</tr>
		  			<tr>
			   			<th colspan="2">
			   			-------------------------------
			   			</th>
			   		</tr>
		   		</c:if>
	   		</c:forEach>
	   		<tr id="re_write_form">
		   		<td>
	  				<textarea rows="5" cols="17" name="reply_content" id="re_write_content"></textarea>
	  			</td>
	  			<td>
	  				<a onclick="re_write('${authId}','${detail_view.board_id }');"><button>작성</button></a>
	  			</td>
  			</tr>
  			
  			
	   </table>
   
   </div>
   
   <a href="list"><button type="button">목록</button></a>
   <c:if test="${authId==detail_view.id }">
 		<a href="modify?board_id=${detail_view.board_id }"><button>수정</button></a><br>
 		<a href="delete?board_id=${detail_view.board_id }" onclick="return confirm('정말로 삭제하시겠습니까?')"><button>삭제</button></a>
	</c:if>
   
</body>
</html>