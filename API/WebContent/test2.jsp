<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/default.css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

</head>
<body>
	<div id="loginDiv">
		<div id="kakao_btn_changed1">
			<a id="custom-login-btn" href="javascript:loginWithKakao()"> <img src="main.png" width="300" /></a>
		</div>
	</div>
	
	<div id="mainDiv">
		<h1>로그인 성공해서 mainDiv가 올라왔습니다.</h1>
		<div id="kakao_btn_changed2">
			<a id="custom-logout-btn" href="javascript:logoutWithKakao()"> <img src="dog.jpg" width="300" /></a>
			<div id="kakao-profile"></div>
		</div>
	</div>


<script type='text/javascript'>

		// 버튼 이미지 전환 
		$(document).ready(function() {
			
			// 저장된 쿠키값 확인 후 값에 따라 로그인 및 로그아웃 버튼 생성 처리를 합니다.
			var cookiedata = document.cookie;

			if (cookiedata.indexOf('kakao_login=done') < 0) {
				createLoginKakao();
			} else {
				afterLogin();
				getKakaotalkUserProfile()
				createLogoutKakao();
			}
			
			
			
			
			/* $("#custom-login-btn, #custom-logout-btn").hover(function() {
				$("#custom-login-btn img").attr('src','main.png');
				$("#custom-logout-btn img").attr('src','dog.jpg');
			},
			
			function() {
				$("#custom-login-btn img").attr('src','main.png');
				$("#custom-logout-btn img").attr('src','dog.jpg');
			});
 			*/
		});
		
		// z-index 전환용 함수 선언
		function afterLogin(){	// 로그인 시
			$("#loginDiv").css("z-index", 0);
		}
		
		function afterLogout(){ // 로그아웃 시
			$("#loginDiv").css("z-index", 2);
		}
		
		/* 로그인 관련 쿠키 생성 및 삭제 */
		function setCookie(name, value, expired) {

			var date = new Date();
			date.setHours(date.getHours() + expired);
			var expried_set = "expries=" + date.toGMTString();
			document.cookie = name + "=" + value + "; path=/;" + expried_set
					+ ";"
					
			

		}

		/* 쿠키 삭제 다른방법
		 function deleteCookie( name ){
		
		 var date = new Date();
		 date.setHours(date.getHours() - 1);
		 var expried_set = "expries="+date.toGMTString();
		 document.cookie = name + "="  + "; path=/;" + expried_set + ";"
		 }
		 */

		// 
		
		// cookie를 불러오는 함수를 선언합니다.
		function getCookie(name) {

			var nameofCookie = name + "=";
			var x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameofCookie.length);
				if (document.cookie.substring(x, y) == nameofCookie) {
					if ((endofCookie = document.cookie.indexOf(";", y)) == -1)
						endofCookie = document.cookie.length;
					return unescape(document.cookie.substring(y, endofCookie));
				}
				x = document.cookie.indexOf(" ", x) + 1;
				if (x == 0)
					break;
			}

			return "";
		}

		// 카카오 script key 입력
		Kakao.init("02e05e570f32543c770341b3ad72747d");

		// 로그인 처리
		function loginWithKakao() {

			Kakao.Auth.cleanup();
			Kakao.Auth.login({
				persistAccessToken : true,
				persistRefreshToken : true,
				success : function(authObj) {
					setCookie("kakao_login", "done", 1); // 쿠키생성 (로그인)
					//alert(cookiedata);
					createLogoutKakao();
					afterLogin();
					//window.location.href = "../.html";
					getKakaotalkUserProfile();
				},
				fail : function(err) {
					alert(JSON.stringify(err));
				}

			});
		}

		// 로그아웃 처리
		function logoutWithKakao() {
			Kakao.Auth.cleanup();
			Kakao.Auth.logout();
			alert('카카오 로그아웃 완료!');
			setCookie("kakao_login", "", 0, 0); // 쿠키삭제 (로그아웃)
			afterLogout(); 
			alert(getCookie());
			//deleteCookie( "kakao_login" ); 쿠키삭제 다른 방법
			//createLoginKakao();
			//window.location.href = "../index.html";
		}

		// 로그인 버튼생성
		function createLoginKakao() {
			var login_btn = "<a id='custom-login-btn' href='javascript:loginWithKakao()'>"
					+ "<img src='main.png' width='300'/>"
					+ "</a>";
			document.getElementById('kakao_btn_changed1').innerHTML = login_btn;
		}

		// 로그아웃 버튼생성
		function createLogoutKakao() {
			var logout_btn = "<a id='custom-logout-btn' href='javascript:logoutWithKakao()'>"
					+ "<img src='dog.jpg' width='300'/>"
					+ "</a><br>";
			document.getElementById('kakao_btn_changed2').innerHTML = logout_btn;
		}
		
		// 카카오 유저 프로필을 생성합니다.
		function getKakaotalkUserProfile(){
			Kakao.API.request({
				url: '/v1/user/me',
				success: function(res) {
				// 페이지 refresh 시 데이터 로드 안되는 줄 알고 sessionStorage 사용 했으나 되는걸로 확인, session 스토리지 사용 안해도 됩니다.
				/* 	sessionStorage.setItem('id', res.id);
					sessionStorage.setItem('nickname', res.properties['nickname']);
					sessionStorage.setItem('img',res.properties.profile_image);
					$("#kakao_btn_changed2").append(sessionStorage.getItem('id')+"<br>");
					$("#kakao_btn_changed2").append(sessionStorage.getItem('nickname')+"<br>");
					$("#kakao_btn_changed2").append($("<img />",{"src":sessionStorage.getItem('img'), "alt":res.properties.nickname+"님의 프로필 사진"}));
				 */
				$("#kakao_btn_changed2").append(res.id+"<br>");
				$("#kakao_btn_changed2").append(res.properties['nickname']+"<br>");
				$("#kakao_btn_changed2").append($("<img />",{"src":res.properties.profile_image, "alt":res.properties.nickname+"님의 프로필 사진"}));
				},
				fail: function(error) {
					console.log(error);
				}
			});
		}
		
		

		//]]>
	</script>
</body>
</html>