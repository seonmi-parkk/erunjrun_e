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
	padding: 0;
}

.div, .div * {
	box-sizing: border-box;
}

.div {
	color: #333333;
	text-align: left;
	font-family: "Preahvihear-Regular", sans-serif;
	font-size: 16px;
	font-weight: 400;
	position: relative;
}

.container {
	position: relative;
	width: 400px;
	margin: auto;
	padding: 20px;
	background: white; /* 흰색 배경 */
	border-radius: 8px; /* 모서리 둥글게 */
}

h3 {
	text-align: left;
	margin-bottom: 20px;
	color: dark; /* 주황색 */
	font-size: 40px;
}

.form-group {
	margin-bottom: 15px;
	padding: 10px;
	border-radius: 4px; /* 모서리 둥글게 */
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
	border: none; /* 테두리 제거 */
	border-radius: 4px; /* 모서리 둥글게 */
	background-color: white; /* 흰색 배경 */
}

input[readonly] {
	background-color: transparent; /* 읽기 전용일 경우 투명 배경 */
}

button {
	width: 100%;
	padding: 10px;
	background-color: #ff7f50; /* 주황색 */
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 10px;
}

button:hover {
	background-color: #ff6347; /* 버튼 hover 색상 */
}

.submit-group {
	margin-top: 10px;
	text-align: center;
}

.profile-image {
	max-width: 150px; /* 원하는 최대 너비 */
	max-height: 150px; /* 원하는 최대 높이 */
	border-radius: 4px; /* 모서리 둥글게 */
}
</style>
</head>
<body>
	<div class="div">
		<div class="container">
			<h3>회원 정보</h3>
			<form id="profile" action="profileUpdateView" method="get"
				enctype="multipart/form-data">
				<input type="hidden" name="id" value="${member.id}" />
				<c:choose>
					<c:when test="${not empty profile.image}">
						<img class="profile-image" src="/photo/${profile.image}"
							alt="회원 이미지" />
					</c:when>
					<c:otherwise>
						<img class="profile-image" src="/resources/img/common/profile.png"
							alt="기본 프로필 이미지" />
					</c:otherwise>
				</c:choose>
				<div class="form-group">
					<label for="nickname">닉네임</label> <input type="text"
						name="nickname" id="nickname" value="${member.nickname}" readonly />
				</div>
				<div class="form-group">
					<label for="point">보유 포인트</label> <input type="text" name="point"
						id="point" value="${member.point}" readonly />
				</div>
				<hr class="divider">

				<div class="form-group">
					<label for="id">아이디</label> <input type="text"
						name="id" id="id" value="${member.id}" readonly />
				</div>
				<div class="form-group">
					<label for="phone">전화번호</label> <input type="text" name="phone"
						id="phone" value="${member.phone}" readonly />
				</div>
				<div class="form-group">
					<label for="address">주소</label> <input type="text" name="address"
						id="address" value="${member.address}" readonly />
				</div>
				<div class="form-group">
					<label for="email">이메일</label> <input type="email" name="email"
						id="email" value="${member.email}" readonly />
				</div>
				<div class="submit-group">
					<button type="submit">수정하기</button>
				</div>
				<div class="submit-group">
					<a href="deleteView" class="button">탈퇴하기</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
