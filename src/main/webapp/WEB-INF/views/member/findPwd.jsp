<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>

<style>
.findPwd{
	margin-left: 700px;
	margin-top: 200px;
}	
.userId{
	margin-left: 700px;
}
.userPhone{
	margin-left: 700px;
}
.find{
	margin-left: 800px;
}
.join{
	margin-left: 700px;
}
</style>

<script>
	$(function(){
		$("#find").click(function(){
			var userId = $("#userId").val();
			var userPhone = $("#userPhone").val();
			
			$.ajax({
				url		: "chkPwd",
				type	: "POST",
				data	: {
					"userId" : userId,
					"userPhone" : userPhone
				},
				success	: function(data){
					console.log("data : " + JSON.stringify(data));
				},
				error	: function(e){
					alert(e);
				}
			})
		})
	})
</script>

<body>
	<h2 class="findPwd">비밀번호찾기</h2>
	<form id="chkPwd">
		<div class="userId">
			<input type="text" id="userId" placeholder="아이디" style="width:250px; height:30px;">
		</div>
		<br>
		<div class="userPhone">
			<input type="text" id="userPhone" placeholder="전화번호" style="width:250px; height:30px;">
		</div>
	</form>
	<br>
	
	<div class="find">
		<button type="button" id="find">찾기</button>
	</div>
	<br>	
	<div class="join">
		<a href="<%=request.getContextPath() %>/member/findId">아이디찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;	
		<a href="<%=request.getContextPath() %>/member/join">회원가입</a><br><br>
		로그인 페이지로 돌아가기 <a href="<%=request.getContextPath() %>/member/login">로그인</a>
	</div>
</body>
</html>