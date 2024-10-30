<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>운동 프로필 작성</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 20px;
}

.container {
	max-width: 600px;
	margin: 0 auto;
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.profile-header {
	text-align: center;
	margin-bottom: 20px;
}

.profile-header img {
	width: 100px; /* 프로필 이미지 크기 */
	height: 100px; /* 프로필 이미지 크기 */
	border-radius: 50%;
	object-fit: cover;
}

.profile-header h2 {
	margin: 10px 0 0;
	font-size: 24px;
	color: #333;
}

.message {
	text-align: center;
	margin: 20px 0;
	font-size: 18px;
	color: #555;
}

.button-container {
	text-align: center;
}

.btn {
	background-color: #007bff;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s;
}

.btn:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<div class="profile-header">
			<img
				src="${profile.image != null && profile.image != '' ? '/photo/' + profile.image : 'resources/img/common/profile.png'}"
				alt="회원 이미지" />
			<h2>${sessionScope.loginId}</h2>
		</div>
		<div class="message">
			아직 운동프로필이 작성되지 않았습니다.<br> 프로필 최초 작성 시, 10p가 지급되며 내성향에 맞는 운동메이트를
			구할 확률이 높아집니다.
		</div>

		<div class="button-container">
			<button class="btn"
				onclick="location.href='firstExerciseProfileView'">최초 작성하기</button>
		</div>
	</div>

	<script>
		
	</script>
</body>
</html>
