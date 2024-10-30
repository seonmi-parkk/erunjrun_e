<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0; /* 기본 여백 제거 */
    padding: 0; /* 기본 패딩 제거 */
    background-color: #ffffff;
    display: flex; /* 플렉스박스 사용 */
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    height: 100vh; /* 화면 전체 높이 */
}

.container {
    background: white;
    padding: 20px;
    border-radius: 8px;
    width: 400px; /* 너비 조정 */
    /* box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 제거 */
    border: none; /* 테두리 제거 */
}

h3 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 24px; /* 폰트 크기 키우기 */
    font-weight: bold; /* 볼드 처리 */
}

.form-group {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

input[type="text"], input[type="email"] {
    width: 100%; /* 입력 필드 너비 100% */
    padding: 10px;
    border: 1px solid #ccc; /* 테두리 유지 */
    border-radius: 4px;
    box-sizing: border-box;
}

button {
    padding: 10px;
    background-color: #ff7f50; /* 주황색 */
    color: white;
    border: none; /* 테두리 제거 */
    border-radius: 4px;
    cursor: pointer;
    width: 100%; /* 버튼 너비 100% */
    margin-top: 10px; /* 버튼 위쪽 간격 */
}

button:hover {
    background-color: #ff6347; /* 버튼 hover 색상 */
}

.info {
    margin: 15px 0; /* 위아래 여백 추가 */
    font-size: 14px;
    color: #555;
    text-align: center; /* 중앙 정렬 */
    background-color: #f0f0f0; /* 회색 배경 */
    padding: 10px; /* 안쪽 여백 추가 */
    border-radius: 4px; /* 모서리 둥글게 */
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="container">
		<h3>아이디 찾기</h3>
		<div class="info">회원가입 시 입력한 아이디와 이메일을 입력해주세요.</div>
		<form id="findIdForm" action="findId" method="post">
			<div class="form-group">
				<label for="name">이름</label> 
				<input type="text" name="name" id="name" required>
			</div>
			<div class="form-group">
				<label for="email">이메일</label> 
				<input type="email" name="email" id="email" required>
			</div>
			<button type="submit" id="id-find">아이디 찾기</button>
		</form>
	</div>

	<script>
		// 추가 스크립트 필요 시 여기에 작성
	</script>
</body>
</html>
