<%@page import="com.soon.chan.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/smarteditor/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>

</head>
<style>
.free{
	margin-left: 400px;
}
.table{
	margin-left: 400px;
}
.button{
	margin-left: 1330px;
}
</style>

<body>
	<%
		Member member = (Member) session.getAttribute("member");
	%>

	<h1 class="free">자유게시판</h1>

	<form id="update2">
		<input type="hidden" name="boardNo" value="${b.boardNo }" />
		<table class="table">
				<input type="hidden" name="userId" value="<%=member.getUserId()%>">
			<tr>
				<td>제목</td>
				<td><textarea rows="3" cols="141" class="title" name="boardTitle" id="boardTitle">${b.boardTitle }</textarea></td>
			</tr>

			<tr>
				<td id="boardContent1">내용</td>
				<td><textarea rows="35" cols="140" id="ir1" name="boardContent">${b.boardContent }</textarea></td>
			</tr>
		</table>
	</form>
	
	<div class="button">
		<button type="button" id="writebtn" name="writebtn">저장</button>
		<button type="button" id="cancelbtn" onclick="history.back(-1)">취소</button>
	</div>
</body>

<script type="text/javascript">
		//스마트에디터	
		var oEditors=[]; 
		nhn.husky.EZCreator.createInIFrame({
			oAppRef:oEditors,
			elPlaceHolder:"ir1",
			sSkinURI: "<%=request.getContextPath()%>/smarteditor/SmartEditor2Skin.html",
					fCreator:"createSEditor2"
					});
		
			//버튼을 누를때 실행, 글쓰기 confirm창
			$(function() {
				$("#writebtn").on("click",function() {
						var title=$("#boardTitle").val();
	
						oEditors.getById["ir1"].exec(
								"UPDATE_CONTENTS_FIELD", []);
						//스마트 에디터 값을 텍스트컨텐츠로 전달 / 값을 불러올 땐 document.get으로 받아오기
						var content = document.getElementById("ir1").value;
						var result = confirm("글 수정 하시겠습니까?");
						
						if(result == true){
							var frm = document.getElementById("update2");
							frm.action = "update2";
							frm.method = "post";
							frm.submit();
						} else {
							return false;
						}
					})
				});
</script>
</html>