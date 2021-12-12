<%@page import="com.soon.chan.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>

<style>
.members{
	margin-left: 1170px;
}

.button {
	margin-left: 930px;
}

.table {
	margin-left: 400px;
	margin-top: 100px;
}
</style>
<body>
	<%
		Member member = (Member) session.getAttribute("member");
	%>
	
	<div class="members">
	<p>${member.userName }(${member.userId }) 님 환영합니다.</p>
	<a href="<%=request.getContextPath()%>/member/logout">로그아웃</a> 
	</div>
		
	<div class="table">
		<h1 class="free">자유게시판</h1>
		<form id="write">
			<div class="button">
				<button>글쓰기</button>
			</div>
		</form>
		<table width="1000" height="400">
			<tr bgcolor="#fcf6c1">
				<td align="center" width="80">번호</td>
				<td align="center" width="400">제목</td>
				<td align="center" width="120">작성자</td>
				<td align="center" width="80">조회</td>
				<td align="center" width="80">추천</td>
				<td align="center" width="100">작성일</td>
			</tr>

			<c:forEach var="chan" items="${list }" varStatus="status">
				<tr>
					<td align="center">${chan.boardNo }</td>
					<td align="center"><a href="detail?boardNo=${chan.boardNo}&page=${currentPage}">${chan.boardTitle }</a></td>
					<td align="center">${chan.boardId }</td>
					<td align="center">${chan.boardCnt }</td>
					<td align="center"></td>
					<td align="center">${chan.boardDate }</td>
				</tr>
			</c:forEach>
			
		<!-- 앞 페이지 번호 처리 -->
	 		<tr align="center" height="20">
				<td colspan="5"><c:if test="${currentPage <= 1}"> < </c:if>
					<c:if test="${currentPage > 1}">
						<c:url var="blistST" value="list">
							<c:param name="page" value="${currentPage-1}" />
						</c:url>
					<a href="${blistST}"> < </a>
					</c:if> <!-- 끝 페이지 번호 처리 --> <c:set var="endPage" value="${maxPage}" /> 
				<c:forEach var="p" begin="${startPage+1}" end="${endPage}">
					<c:if test="${p eq currentPage}">
						<font color="red" size="4"><b>${p}</b></font>
					</c:if>
					<c:if test="${p ne currentPage}">
						<c:url var="blistchk" value="list">
							<c:param name="page" value="${p}" />
						</c:url>
						<a href="${blistchk}">${p}</a>
					</c:if>
				</c:forEach> 
				<c:if test="${currentPage >= maxPage}"> > </c:if> 
					<c:if test="${currentPage < maxPage}">
						<c:url var="blistEND" value="list">
							<c:param name="page" value="${currentPage+1}" />
						</c:url>
					<a href="${blistEND}"> > </a>
				</c:if></td>
			</tr>
		</table>
	</div>
</body>

<script>	
	$(".button").on("click", function() { // 글쓰기 버튼눌렀을때 confirm창
		var write1 = confirm("글 쓰기 하시겠습니까?");
			
 			if(write1 == true) {
				var sessionUserId = '${sessionScope.member.userId}';
						
				if(sessionUserId == 'null' || sessionUserId == ''){
					alert("로그인 후 글 쓰기가 가능합니다.");
					return;
				}	
			}else{
				return false;
			} 
			
 			var frm = document.getElementById("write");
			frm.action = "write";
			frm.method = "get";
			frm.submit();
		});
</script>
</html>