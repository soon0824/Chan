<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.join{
	margin-left: 700px;
	margin-top: 200px;
}
.join2{
	margin-left: 700px;
}
</style>

<script>
	$(function(){
		$("#doJoin").on("click", function(){
	
			var frmData = $("#frmJoin").serialize(); // 직렬화
			console.log("회원가입 ajax시작");
			$.ajax({
				url 	: "doJoin",
				type 	: "POST",
				data 	: frmData,
				success	: function(data){
					location.href="<%=request.getContextPath()%>/member/login";
				},
				error	: function(data){
					console.log(data);
				}
			})
		});
	});
</script>

<body>
	<h1 class="join">회원가입</h1>
	<form id="frmJoin"> <!-- 아이디,비밀번호,이름,닉네임,전화번호 -->
		<div class="join2">
			<div><input type="text" id="userId" name="userId" placeholder="아이디를 입력해주세요" style="width:200px; height:30px;"></div>
			<br>
			<div><input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력해주세요" style="width:200px; height:30px;"></div>
			<br>
			<div><input type="text" id="userName" name="userName" placeholder="이름을 입력해주세요" style="width:200px; height:30px;"></div>
			<br>
			<div><input type="text" id="userNickName" name="userNickName" placeholder="닉네임을 입력해주세요" style="width:200px; height:30px;"></div>
			<br>
			<div><input type="text" id="userPhone" name="userPhone" placeholder="전화번호를 입력해주세요" style="width:200px; height:30px;"></div>
			<br>
			<div>
				<button type="button" id="doJoin">회원가입</button>&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="reset" class="insideBtn" onclick="history.back(-1)">취소</button>
			</div>
		</div>
		
	</form>
</body>
</html>