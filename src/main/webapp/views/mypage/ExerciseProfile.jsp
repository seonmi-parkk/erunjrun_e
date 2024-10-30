<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 보기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f4f4f4;
}

.container {
	background: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	max-width: 600px;
	margin: 0 auto;
}

.profile-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
	text-align: left;
}

.profile-header img {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	object-fit: cover;
	margin-right: 15px;
}

.profile-header h2 {
	margin: 0;
	font-size: 24px;
	color: #333;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: inline-block;
	margin-bottom: 5px;
	color: #555;
	background-color: #f9f9f9;
	padding: 4px 10px;
	border-radius: 4px;
	font-size: 14px;
}

input[type="text"], input[type="email"], input[type="number"] {
	width: calc(100% - 20px);
	padding: 10px;
	border: none;
	border-radius: 4px;
	box-sizing: border-box;
	background-color: transparent;
	display: block;
}

.submit-group {
	text-align: center;
	margin-top: 20px;
}

.submit-group a {
	display: inline-block;
	padding: 10px;
	background-color: #ff7f50;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	text-align: center;
	width: 100%;
	margin-top: 10px;
}

button {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

button:hover {
	background-color: #218838;
}

#map {
	margin-top: 20px;
	border: 1px solid #ddd;
	border-radius: 4px;
	height: 300px;
}

.radio-group {
	display: flex;
}

.radio-group label {
	margin: 0;
}

.divider {
	border: none;
	border-top: 2px solid black;
	margin: 10px 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="profile-header">
				<h2>${member.nickname}</h2>
		</div>
		<hr class="divider">
		<form id="profile" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${sessionScope.loginId}" />
			<div class="form-group">
				<label>성별</label> <input type="text" value="${member.gender}" readonly />
			</div>
			<c:choose>
				<c:when test="${not empty profile.image}">
					<img class="profile-image" src="/photo/${profile.image}"
						alt="회원 이미지" />
				</c:when>
				<c:otherwise>
					<img class="profile-image" src="resources/img/common/profile.png"
						alt="기본 프로필 이미지" />
				</c:otherwise>
			</c:choose>
			<div class="form-group">
				<label>연령대</label> <input type="text" id="ageGroup" readonly />
			</div>
			<div class="form-group">
				<label>운동 시간 (분)</label> <input type="number" name="exercise_min" id="exercise_min" value="${mypage.exercise_min}" placeholder="분" readonly />
			</div>
			<div class="form-group">
				<label>운동 거리 (km)</label> <input type="number" name="exercise_dis" id="exercise_dis" value="${mypage.exercise_dis}" placeholder="km" readonly />
			</div>
			<div class="form-group">
				<label>나의 성향</label> <input type="text" value="${mypage.exercise}" readonly />
			</div>
			<div class="form-group">
				<label>원하는 운동 메이트 성향</label> <input type="text" value="${mypage.mate}" readonly />
			</div>
			<div class="form-group">
				<label>소개글</label> <input type="text" value="${mypage.content}" readonly />
			</div>
			<div class="form-group">
				<label>운동 지역</label> <input type="text" name="detail_address" id="address" value="${mypage.detail_address}" readonly />
			</div>
			<div class="submit-group">
				<a href="ExerciseProfileUpdateView">수정하기</a>
			</div>
		</form>
	</div>
	<script>
		$(document).ready(function() {
			var birthString = "${birthString}"; // JSP에서 JavaScript로 변수 전달
			console.log("생년월일:", birthString); // 값 확인

			// 나이 계산 로직
			if (birthString.length === 8 && !isNaN(birthString)) {
				const birthYear = parseInt(birthString.substring(0, 4), 10);
				const birthMonth = parseInt(birthString.substring(4, 6), 10);
				const birthDay = parseInt(birthString.substring(6, 8), 10);

				const currentDate = new Date();
				const currentYear = currentDate.getFullYear();
				const currentMonth = currentDate.getMonth() + 1; // 0부터 시작하므로 +1
				const currentDay = currentDate.getDate();

				let age = currentYear - birthYear;

				// 생일이 지나지 않았다면 나이 하나 감소
				if (currentMonth < birthMonth || (currentMonth === birthMonth && currentDay < birthDay)) {
					age--;
				}

				let ageGroup;
				if (age < 20) {
					ageGroup = "10대";
				} else if (age < 25) {
					ageGroup = "20~25대";
				} else if (age < 30) {
					ageGroup = "26~30대";
				} else if (age < 35) {
					ageGroup = "31~35대";
				} else if (age < 40) {
					ageGroup = "36~40대";
				} else {
					ageGroup = "41대 이상";
				}

				$('#ageGroup').val(ageGroup);
			} else {
				$('#ageGroup').val("정보 없음");
			}
		});
	</script>
</body>
</html>
