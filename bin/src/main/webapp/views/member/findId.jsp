<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
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
            width: 400px; /* 너비 조정 */
            font-weight: bold; /* 볼드 처리 */
            
            /* 그림자 및 테두리 제거 */
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
        .links {
            display: flex; /* 플렉스박스를 사용하여 정렬 */
            align-items: center; /* 수직 정렬 */
            justify-content: center; /* 중앙 정렬 */
            margin-top: 15px; /* 위쪽 여백 추가 */
        }
        .links a {
            margin: 0 5px; /* 양쪽에 여백 추가 */
        }
    </style>
</head>
<body>
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
    </script>
</body>
</html>
