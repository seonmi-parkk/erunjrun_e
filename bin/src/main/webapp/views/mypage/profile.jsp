<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        background-color: #f9f9f9; /* 연한 배경색 */
    }

    .div,
    .div * {
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
        padding: 34px 20px 10px;
        background: white;
        border-radius: 8px;
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

    input[type="text"], input[type="password"], input[type="email"] {
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

    .submit-group {
        margin-top: 10px;
        text-align: center;
    }
</style>
</head>
<body>
    <div class="div">
        <div class="container">
            <h3>회원 상세 보기</h3>
            <form id="profile" action="profileUpdateView" method="get" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${member.id}" />
                <div class="form-group">
                    <label for="image">이미지</label> 
                    <img src="/photo/${profile.image}" alt="회원 이미지" style="max-width: 50%; border-radius: 4px;" /> 
                </div>
                <div class="form-group">
                    <label for="nickname">닉네임</label> 
                    <input type="text" name="nickname" id="nickname" value="${member.nickname}" readonly/>
                </div>
                <div class="form-group">
                    <label for="point">보유 포인트</label> 
                    <input type="text" name="point" id="point" value="${member.point}" readonly/>
                </div>
                <div class="form-group">
                    <label for="phone">전화번호</label> 
                    <input type="text" name="phone" id="phone" value="${member.phone}" readonly/>
                </div>
                <div class="form-group">
                    <label for="address">주소</label> 
                    <input type="text" name="address" id="address" value="${member.address}" readonly/>
                </div>
                <div class="form-group">
                    <label for="email">이메일</label> 
                    <input type="email" name="email" id="email" value="${member.email}" readonly/>
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
