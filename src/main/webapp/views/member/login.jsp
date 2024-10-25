<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
	width: 300px;
}

h3 {
	text-align: center;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input::placeholder {
	color: #aaa; /* placeholder 색상 */
}

.checkbox-group {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.checkbox-group {
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬 */
    align-items: center;
}

button {
	width: 100%;
	padding: 10px;
	background-color: #ff7f50; /* 주황색으로 변경 */
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button:hover {
	background-color: #ff6347; /* 버튼 hover 색상 */
}

.links {
	text-align: center;
	margin-top: 10px;
}

.links a:last-child {
    margin-top: 10px; /* 관리자 전용 링크에만 적용 */
    display: block; /* 블록 요소로 설정하여 줄 바꿈 */
}
</style>
</head>
<body>
	<div class="container">
		<h3>로그인</h3>
		<form action="login" method="post">
			<div class="form-group">
				<label for="userId"></label> <input type="text" name="id"
					id="userId" placeholder="아이디" required />
			</div>
			<div class="form-group">
				<label for="password"></label> <input type="password" name="pw"
					placeholder="비밀번호" required />
			</div>
			<div class="form-group checkbox-group">
			<input type="checkbox" id="saveId" name="saveId" /> <label for="saveId">아이디 저장</label>
			</div>
			<button type="submit">LOGIN</button>
			<div class="links">
				<a href="joinView">회원가입</a> | <a href="findIdView">아이디/비밀번호 찾기</a><a href="adminLogin">관리자전용</a>
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
