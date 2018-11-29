<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>첫번째 로그인</title>
<link rel="stylesheet" href="css/default.css">
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>


<script>
	$(document).ready(function() {

		var changeBtn1 = $("<a/>", {
			"class" : "loginZ",
			"text" : "로그인 div의 z-index 변경"
		});
		changeBtn1.click(function() {
			$("#loginDiv").css("z-index", 0);
		});
		$("#loginDiv").prepend(changeBtn1);

		var changeBtn2 = $("<a/>", {
			"class" : "loginZ",
			"text" : "로그인 div의 z-index 원복"
		});
		changeBtn2.click(function() {
			$("#loginDiv").css("z-index", 2);
		});
		$("#mainDiv").prepend(changeBtn2);

	});
</script>
</head>
<body>
	<div id="loginDiv">
		<h1>로그인 div 입니다.</h1>
		<h4>z-index:1</h4>
	</div>
	
	<div id="mainDiv">
			<h1>메인화면 div 입니다.</h1>
			<h4>z-index:2</h4>
	</div>
	

</body>
</html>