<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/default.css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<title>test2 카카오톡 로그인</title>
	<script>
		$(document).ready(function(){
			
			// 사용할 앱의 JavaScript 키를 설정해줍니다.
			Kakao.init("02e05e570f32543c770341b3ad72747d");
			
			// 로컬스토리지를 초기화 해줍니다.
			if(window.localStorage){
				localStorage.clear();
			}
			
			// 카카오 로그인 버튼을 생성합니다.
			function createKakaotalkLogin(){
				localStorage.clear();
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var loginBtn = $("<a/>",{"class":"kakao-login-btn","text":"로그인"});
				loginBtn.click(function(){
					Kakao.Auth.login({
						persistAccessToken: false,
						persistRefreshToken: false,
						success: function(authObj) {
							getKakaotalkUserProfile();
							createKakaotalkLogout();
							alert(JSON.stringify(authObj));
						},
						fail: function(err) {
							console.log(err);
						}
					});
				});
				$("#kakao-logged-group").prepend(loginBtn)
			}
			
			// 카카오 로그아웃 버튼을 생성합니다.
			function createKakaotalkLogout(){
				localStorage.clear();
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var logoutBtn = $("<a/>",{"class":"kakao-logout-btn","text":"로그아웃"});
				logoutBtn.click(function(){
					Kakao.Auth.logout(function(data){
					});
					createKakaotalkLogin();
					$("#kakao-profile").text("");
				});
				$("#kakao-logged-group").prepend(logoutBtn);
			}
			
			// 카카오 유저 프로필을 생성합니다.
			function getKakaotalkUserProfile(){
				Kakao.API.request({
					url: '/v1/user/me',
					success: function(res) {
						$("#kakao-profile").append(res.id);
						$("#kakao-profile").append(res.properties.nickname);
						//$("#kakao-profile").append($("<img/>",{"src":res.properties.profile_image,"alt":res.properties.nickname+"님의 프로필 사진"}));
					},
					fail: function(error) {
						console.log(error);
					}
				});
			}
			
			
			if(Kakao.Auth.getRefreshToken()!=undefined&&Kakao.Auth.getRefreshToken().replace(/ /gi,"")!=""){
				createKakaotalkLogout();
				getKakaotalkUserProfile();
			}else{
				createKakaotalkLogin();
			}
		});
	</script>
</head>
<body>
	<a id="kakao-login-btn"></a>
	<div id="kakao-logged-group"></div>
	<div id="kakao-profile"></div>
</body>
</html>