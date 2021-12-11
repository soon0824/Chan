<%@page import="com.soon.chan.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>

<style>
.free {
	margin-left: 400px;
	margin-top: 100px;
	margin-bottom: 50px;	
}

.title {
	margin-left: 400px;
	margin-bottom: 50px;
}

.id{
	margin-left: 400px;
}

.content{
	margin-left: 400px;
}
.page{
	float: right;
	margin-top: 100px;
	margin-right: 200px;
}
</style>
<body>
	<%
		Member member = (Member) session.getAttribute("member");
	%>

	<div>
		<h1 class="free">자유게시판</h1>
	</div>
	<hr width="70%">
	 
	<div class="title">
			<h1>${b.boardTitle}</h1>	
			${b.boardDate }
			<form id="button"> 
				<input type="hidden" name="boardNo" value="${b.boardNo }">
				
				<input type="button" value="신고" id="declaration"> 
				<input type="button" value="수정" id="modify"> 
				<input type="button" value="삭제" id="delete">
			</form>
	</div>
	
	<div class="id">
		작성자 : ${b.boardId } 조회수 : ${b.boardCnt }
	</div>
	
	<hr width="70%">
	
	<div class="content">
		<h1>글내용</h1>
		${b.boardContent }
	</div>
	
	<hr width="70%">
	
	<div class="page">
		<c:url var="list" value="list">
			<c:param name="page" value="${currentPage}" />
		</c:url>
		<a href="${list}">목록</a>
	</div>
</body>

<script>	
	// 삭제 아이디 체크
	$("#delete").on("click", function() {		
		var delete1 = confirm("삭제하시겠습니까?");
		var sessionUserId = '${sessionScope.member.userId}';
		var boardId = '${b.boardId}';
					
		if(delete1){ // 확인누르면 
		if (sessionUserId == 'null' || sessionUserId == '') {
			alert("로그인 후 삭제 가능합니다")
			return false;
		}
		if (boardId == 'null' || boardId == '') {
	        alert('작성자가 아니므로 글 삭제가 되지 않습니다');
			return false;
		}
		if (boardId != sessionUserId) {
           	alert('작성자가 아니므로 글 삭제가 되지 않습니다');
			return false;	
		}
			var frm = document.getElementById("button");
			frm.action = "delete";
			frm.method = "post";
			frm.submit();
		}else { // 취소누르면
			return false;
		}
	});
	
	// 수정 아이디 체크
	$("#modify").on("click", function() {		
		var delete1 = confirm("수정하시겠습니까?");
		var sessionUserId = '${sessionScope.member.userId}';
		var boardId = '${b.boardId}';
					
		if(delete1){ // 확인누르면 
		if (sessionUserId == 'null' || sessionUserId == '') {
			alert("로그인 후 수정 가능합니다")
			return false;
		}
		if (boardId == 'null' || boardId == '') {
	        alert('작성자가 아니므로 글 수정이 되지 않습니다');
			return false;
		}
		if (boardId != sessionUserId) {
           	alert('작성자가 아니므로 글 수정이 되지 않습니다');
			return false;	
		}
			var frm = document.getElementById("button");
			frm.action = "update";
			frm.method = "post";
			frm.submit();
		}else { // 취소누르면
			return false;
		}
	});
</script>
</html>