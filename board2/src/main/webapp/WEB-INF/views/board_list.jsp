<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/list_style.css">
</head>
<body>
	<c:if test="${deleteResult==1 }">
		<script type="text/javascript">
			alert("저장이 완료되었습니다.");
		</script>
	</c:if>
   <h2>게시판</h2>
   <p>로그인 사용자: ${name } 님 <a href="logout" onclick="return confirm('로그아웃 하시겠습니까?')"><button>로그아웃</button></a></p>
   
   <table border="1">
   		<tr>
   			<th>제목</th>
   			<th>아이디</th>
   			<th>작성일</th>
   			<th>수정일</th>
   		</tr>
   		<c:forEach var="list" items="${boardList }">
   		<tr>
   			<td><a href="detail?board_id=${list.board_id}">${list.title }</a></td>
   			<td>${list.id }</td>
   			<td><fmt:formatDate value="${list.created_date }" dateStyle="short"/> </td>
   			<td><fmt:formatDate value="${list.modified_date }" dateStyle="short"/> </td>
   		</tr>
   		
   		</c:forEach>
   		
   		
   </table>
   <a href="write"><button>글작성</button></a><br><br>
   
   <ul class="page_div">
   	<li>
     	  <a href="list?page=1"><button type="button">처음</button></a>
     	</li>
       <c:if test="${page<=1}">
     	  <li><button type="button">이전</button></li>
       </c:if>
      
    <c:if test="${page>1}">
      <li>
        <a href="list?page=${page-1}"><button type="button">이전</button></a>
      </li>
      	
      </c:if>
      
      <!-- 순차적 페이지 번호 출력 -->
      <c:forEach var="a" begin="${startPage}" end="${endPage}" step="1">
      	<c:choose>
			<c:when test="${a==page}">
				<li style="background: #dfdfdf ;">
				  <div><button type="button">${a }</button></div>
				</li>
			</c:when>
			<c:when test="${a!=page}">
	      		<a href="list?page=${a}">
					<li>
						  <button type="button">${a}</button>
					</li>
				</a>
			</c:when>
		</c:choose>
      </c:forEach>
      
      <!-- 다음페이지 이동 -->
      <c:if test="${page>=maxPage}">
      	<li><button type="button">다음</button></li>
      </c:if>
      <c:if test="${page<maxPage}">
     		<a href="list?page=${page+1}">
	      <li><button type="button">다음</button></li>
	    </a>
      </c:if>
      
      <!-- 마지막페이지 이동 -->
    		   <a href="list?page=${maxPage}">
    	  <li>
    	      <button type="button">마지막</button>
    	  </li>
      </a>
      
    </ul>

</body>
</html>