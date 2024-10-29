<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #ffffff;
}

.container {
	background: white;
	padding: 20px;
	border-radius: 8px;
	width: 330px; /* 너비 유지 */
	/* 그림자 및 테두리 제거 */
}

h3 {
	text-align: center;
	margin-bottom: 20px; /* 아래쪽 마진 추가 */
}

h2 {
	text-align: center;
	margin-bottom: 20px; /* 아래쪽 마진 조정 */
}

.form-group {
	margin-bottom: 15px; /* 아래쪽 마진 조정 */
}

input[type="text"], input[type="password"] {
	width: calc(100% + 100px); /* 기존 너비 유지 */
	padding: 10px;
	border: 1px solid #ccc; /* 1픽셀 회색 테두리 */
	border-radius: 4px;
	box-sizing: border-box;
	margin-left: -50px; /* 왼쪽으로 이동 */
	background-color: #ffffff; /* 배경색을 하얀색으로 변경 */
}

input::placeholder {
	color: #aaa; /* placeholder 색상 */
}

.checkbox-group {
	display: flex;
	align-items: center; /* 체크박스와 레이블을 수직으로 정렬 */
	justify-content: flex-end; /* 체크박스 왼쪽 정렬 */
	margin-left: auto; /* 왼쪽 마진 자동으로 설정하여 오른쪽으로 이동 */
	margin-right: -52px; /* 오른쪽 마진 추가 */
}

button {
	width: calc(100% + 100px); /* 입력 필드와 동일한 너비 */
	padding: 10px;
	background-color: #ff7f50; /* 주황색으로 변경 */
	color: white;
	border: none; /* 테두리 제거 */
	border-radius: 4px;
	cursor: pointer;
	margin-left: -50px; /* 왼쪽으로 이동 */
}

button:hover {
	background-color: #ff6347; /* 버튼 hover 색상 */
}

.links {
    display: flex; /* 플렉스박스를 사용하여 정렬 */
    align-items: center; /* 수직 정렬 */
    justify-content: flex-start; /* 왼쪽 정렬 */
    margin-top: 10px; /* 위쪽 여백 추가 */
    /* 아래 여백이나 다른 속성들을 추가해 자유롭게 조정 가능 */
}

.links a {
	margin: 0 3px; /* 양쪽에 여백 추가 */
}
</style>


</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="container">
		<h3>
			<img src="resources/img/common/logo.png" alt="이런저런"
				style="width: 80%; height: auto;" />
		</h3>
		<h2>이런저런에 오신 것을 환영합니다!</h2>
		<form action="login" method="post">
			<div class="form-group">
				<label for="userId"></label> <input type="text" name="id"
					id="userId" placeholder="ID" required />
			</div>
			<div class="form-group">
				<label for="password"></label> <input type="password" name="pw"
					placeholder="PASSWORD" required />
			</div>
			<div class="form-group checkbox-group"
				style="justify-content: flex-end;">
				<label for="saveId" style="margin-right: 5px;">아이디 저장</label> <input
					type="checkbox" id="saveId" name="saveId" />
			</div>
			<button type="submit">LOGIN</button>
			<div class="links">
				<a href="joinView">회원가입</a> <span>|</span> <a href="findIdView">아이디/비밀번호
					찾기</a> <span>|</span> <a href="adminLogin">관리자전용</a>
			</div>
		</form>
	</div>

	<script>
		var msg = '${msg}';
		if (msg != '') {
			alert(msg);
		}

		// 폼 제출 시 쿠키에 ID 저장
		$('form').on('submit', function() {
			if ($('#saveId').is(':checked')) {
				setCookie('userId', $('#userId').val(), 7); // 7일 동안 유효한 쿠키
			} else {
				setCookie('userId', '', -1); // 체크 해제 시 쿠키 삭제
			}
		});

		// 쿠키 설정 함수
		function setCookie(name, value, days) {
			var expires = '';
			if (days) {
				var date = new Date();
				date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
				expires = "; expires=" + date.toUTCString();
			}
			document.cookie = name + "=" + (value || "") + expires + "; path=/";
		}

		// 쿠키 가져오는 함수
		function getCookie(name) {
			var nameEQ = name + "=";
			var ca = document.cookie.split(';');
			for (var i = 0; i < ca.length; i++) {
				var c = ca[i];
				while (c.charAt(0) === ' ')
					c = c.substring(1, c.length);
				if (c.indexOf(nameEQ) === 0)
					return c.substring(nameEQ.length, c.length);
			}
			return null;
		}

		// 페이지 로드 시 쿠키에서 ID를 가져와서 입력 필드에 채워넣기
		$(document).ready(function() {
			var userId = getCookie('userId');
			if (userId) {
				$('#userId').val(userId);
				$('#saveId').prop('checked', true); // 체크박스도 체크
			}
		});
	</script>
</body>
</html>
