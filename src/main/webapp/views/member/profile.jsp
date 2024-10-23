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
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #f9f9f9; /* 연한 배경색 */
}

.container {
	background: white;
	padding: 20px;
	border-radius: 8px;
	width: 400px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

h3 {
	text-align: center;
	margin-bottom: 20px;
	color: #ff7f50; /* 주황색 */
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

.result {
	margin-top: 5px;
	font-weight: bold;
	display: inline-block; /* 수평 정렬 */
	margin-left: 10px; /* 버튼과 결과 사이의 간격 */
}
</style>
</head>
<body>
	<div class="container">
		<h3>회원 상세 보기</h3>
		<form id="profile" action="profileUpdate" method="get">
			<input type="hidden" name="id" value="${member.id}" />
			<div class="form-group">
				<label for="image">이미지</label> <img src="" alt="회원 이미지"
					style="max-width: 100%; border-radius: 4px;" />
			</div>
			<div class="form-group">
				<label for="nickname">닉네임</label> <input type="text" name="nickname"
					id="nickname" value="${member.nickname}" readonly />
			</div>
			<div class="form-group">
				<label for="point">보유 포인트</label> <input type="text" name="point"
					id="point" value="${member.point}" />
			</div>
			<div class="form-group">
				<label for="phone">전화번호</label> <input type="text" name="phone"
					id="phone" value="${member.phone}" />
			</div>
			<div class="form-group">
				<label for="address">주소</label> <input type="text" name="address"
					id="address" value="${member.address}" />
			</div>
			<div class="form-group">
				<label for="email">이메일</label> <input type="email" name="email"
					id="email" value="${member.email}" />
			</div>
			<div class="submit-group">
				<button type="submit">수정하기</button>
			</div>
			<div class="submit-group">
				<a href="delete" class="button">탈퇴하기</a>
			</div>
		</form>
	</div>

	<script>
		
	</script>
</body>
</html>
