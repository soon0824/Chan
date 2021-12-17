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
	margin-right: 270px;
}

#like, .like_cnt{
	width : 50px;
	height : 50px;
	margin-left: 900px;
}

#unlike, .like_cnt{
	width : 50px;
	height : 50px;
	margin-left: 900px;
}
</style>
<body>
	<%
		Member member = (Member) session.getAttribute("member");
	%>
	<div>
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
			작성자 : ${b.boardId } 조회수 : ${b.boardViews }
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
		
		<div class="board-like"></div>
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
	
	
	// 상세보기 들어오면 좋아요 버튼 나타내기
	var like = "${isliked}"; // 1:좋아요, 0:좋아요x
	var cnt = "${likecnt}"; // 좋아요 갯수
	var tagHtml = "";
	
	if(like == 1){
		tagHtml = '<a><img src = "../resources/img/fullheart.png" id="unlike"><br><span class = "like_cnt">${likecnt }</span></a>';
	} else {
		tagHtml = '<a><img src = "../resources/img/emptyheart.png" id="like"><br><span class = "like_cnt">${likecnt }</span></a>';
	}
	$(".board-like").append(tagHtml);
	
	// 좋아요 아이디 체크
	function checkId(){
		var sessionUserId = '${sessionScope.member.userId}';
		var boardId = '${b.boardId}';
		
		if (sessionUserId == 'null' || sessionUserId == '') {
           	alert("로그인 후 좋아요가 가능합니다.");
			return true;
		}
		if (sessionUserId == boardId) {
           	alert("본인 글에는 좋아요를 할 수 없습니다.");
			return true;
		} else {
			return false;
		}
	}
	
	// 좋아요 / 해제
	$(".board-like").click(function() {
		if (checkId() == false) {
			$.ajax({
				url	 	: "clickLike",
				type 	: "POST",
				data 	: {
					boardNo : '${b.boardNo }',
					boardId : '<%=member.getUserId()%>'
				},
				success : function(cnt) {
					$(".board-like").empty(); // 기존 image 지우기
					
					var tagHtml = "";
					
					if(like == 0){
						like = 1;  // 좋아요 상태로 바꾸기
						tagHtml = '<a><img src = "../resources/img/fullheart.png" id="unlike"><br><span class = "like_cnt">'+cnt+'</span></a>';
					} else {
						like = 0; // 해제 상태로 바꾸기
						tagHtml = '<a><img src = "../resources/img/emptyheart.png" id="like"><br><span class = "like_cnt">'+cnt+'</span></a>';
					}
					$(".board-like").append(tagHtml);
				},
				error	:function(e){
					alert(e);
				}
			});
		}
	});
</script>
</html>