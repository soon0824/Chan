<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>	
	$(function(){
		$("#btnlogin").on("click", function(){
	
			var frmData = $("#frmlogin").serialize(); // 직렬화
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
	<h1>로그인</h1>
	
	
	<form id="frmlogin">
		<div>
			<input type="text" name="userId" placeholder="아이디">
		</div>
		
		<div>
			<input type="password" name="userPwd" placeholder="비밀번호">
		</div>
		
		<div>
			<button type="button" id="btnlogin">로그인</button>
		</div>
		
		<br>
		
		<div>
			<a href="<%=request.getContextPath() %>/member/join">회원가입</a>
		</div>
	</form>	
</body>	
</html>