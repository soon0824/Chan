<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
.login{
	margin-left: 700px;
	margin-top: 200px;
}
.login2{
	margin-left: 700px;
}
.btnLogin{
	margin-left: 700px;
}
.findId{
	margin-left: 700px;
}
</style>

<script>	
	$(function(){	
		$("#btnLogin").on("click", function(){
			var frmData = $("#frmlogin").serialize(); // 직렬화
			var userId = $("#userId").val();
			var userPwd = $("#userPwd").val();
			
			if(userId == 'null' || userId == ''){
				alert("아이디를 입력해주세요");
				return false;
			}
			
			if(userPwd == 'null' || userPwd == ''){
				alert("비밀번호를 입력해주세요");
				return false;
			}
						
			console.log("로그인 ajax시작");
			$.ajax({
				url 	: "loginPost",
				type 	: "POST",
				data 	: frmData,
				success	: function(data){
					location.href="<%=request.getContextPath()%>/board/list";
				},
				error	: function(data){
					console.log(data);
				}
			}) 
		});
	});
</script>

<body>
	<h1 class="login">로그인</h1>
	
	<form id="frmlogin">
	<div class=login2>
		<div><input type="text" id="userId" name="userId" placeholder="아이디" style="width:250px; height:30px;"></div>
		<br>
		<div><input type="password" id="userPwd" name="userPwd" placeholder="비밀번호" style="width:250px; height:30px;"></div>
		<br>
	</div>
		<div class="findId">
			<a href="<%=request.getContextPath() %>/member/findId">아이디찾기</a> 
			<a href="<%=request.getContextPath() %>/member/findPwd">비밀번호찾기</a>
			<a href="<%=request.getContextPath() %>/member/join">회원가입</a>
		</div>
		<br>
		<div class="btnLogin"><button type="button" id="btnLogin">로그인</button></div>
	</form>	
</body>	
</html>