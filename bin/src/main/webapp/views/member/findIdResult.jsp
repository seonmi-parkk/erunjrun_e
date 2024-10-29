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
            text-align: center; /* 중앙 정렬 */
        }
        h3 {
            margin-bottom: 20px;
        }
        .info {
            margin-bottom: 10px;
            font-size: 14px;
            color: #555;
        }
        .result-box {
            margin-bottom: 20px; /* 결과 박스와 버튼 사이의 간격 */
        }
        .link-buttons {
            display: flex;
            justify-content: center; /* 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
            margin-top: 10px;
        }
        button {
            padding: 10px;
            background-color: #ff7f50; /* 주황색으로 변경 */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 0 5px; /* 버튼 사이의 간격 */
        }
        button:hover {
            background-color: #ff6347; /* 버튼 hover 색상 */
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>아이디 찾기 결과</h3>
        <div class="result-box">
            <c:choose>
                <c:when test="${not empty findId}">
                    <p>찾은 아이디: ${findId.id}</p>
                </c:when>
                <c:otherwise>
                    <p class="info">조회 결과가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="link-buttons">
            <button onclick="location.href='loginView'">로그인</button>
            <button onclick="location.href='findPwView'">비밀번호 찾기</button>
        </div>
    </div>
</body>
</html>
