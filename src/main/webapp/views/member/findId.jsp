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
            width: 400px;
        }
        h3 {
            text-align: center;
            margin-bottom: 20px;
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
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            padding: 10px;
            background-color: #ff7f50; /* 주황색으로 변경 */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 5px; /* 버튼과 입력 칸 사이의 간격 */
            width: 100%; /* 버튼 너비 100%로 설정 */
        }
        button:hover {
            background-color: #ff6347; /* 버튼 hover 색상 */
        }
        .info {
            margin-bottom: 10px;
            font-size: 14px;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>아이디 찾기</h3>
        <form id="findForm" action="findIdCheck" method="post">
            <div class="form-group">
                <label for="nickName">이름</label>
                <input type="text" name="nickName" id="nickName" placeholder="이름" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" name="email" id="email" placeholder="이메일" required>
            </div>
            <button type="submit" id="id-find">아이디 찾기</button>
        </form>
    </div>

    <script>
       
    </script>
</body>
</html>
