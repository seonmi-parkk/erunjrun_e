<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>운동 프로필</title>
    <style>
        .profileDetail {
            position: relative;
            width: 760px;
            padding: 34px 50px 10px;
            height: calc(100vh - 120px);
            overflow-y: auto;
        }
        .profileDetail .user-info {
            display: flex;
            justify-content: space-between;
            padding-bottom: 12px;
            border-bottom: 1px solid #ddd;
        }
        .profileDetail .user-info > div {
            display: flex;
            align-items: flex-start;
        }
        .profileDetail .user-info .profile-box {
            display: inline-block;
            width: 110px;
            height: 110px;
            margin-right: 10px;
            background: url('/resources/img/icon/${profileDTO.icon_image}') center center / 100% 100% no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .profileDetail .user-info .profile-img {
            width: 75px;
            height: 75px;
            border-radius: 50%;
        }
        .profileDetail .user-info .user-name {
            font-size: 30px;
        }
        .profileDetail .user-info .name-addr {
            margin-top: 18px;
        }
        .profileDetail .line {
            margin-bottom: 22px;
        }
        .profileDetail .line .tag-m-gray {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="profileDetail">
        <div class="user-info">
            <div>
                <div class="profile-box">
                    <c:choose>
                        <c:when test="${not empty profileDTO.image}">
                            <div class="profile-img" style="background: url(/photo/${profileDTO.image}) center center / cover no-repeat;"></div>
                        </c:when>
                        <c:otherwise>
                            <div class="profile-img" style="background: url(resources/img/common/profile.png) center center / cover no-repeat;"></div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="name-addr">
                    <p class="user-name">${profileDTO.nickname}</p>
                    <span class="addr">${profileDTO.shortsido} ${profileDTO.dong}</span>
                </div>
            </div>
        </div>

        <div class="content">
            <div class="line">
                <div class="tag-m-gray">성별</div>
                <p>${profileDTO.gender}성</p>
            </div>
            <div class="line">
                <div class="tag-m-gray">연령대</div>
                <p>${profileDTO.birth}</p>
            </div>
            <div class="line">
                <div class="tag-m-gray">운동성향</div>
                <p>${profileDTO.exercise}</p>
            </div>
            <div class="line">
                <div class="tag-m-gray">원하는 운동 메이트 운동성향</div>
                <p>${profileDTO.mate}</p>
            </div>
            <div class="line">
                <div class="tag-m-gray">소개글</div>
                <p>${profileDTO.content}</p>
            </div>
        </div>
    </div>
</body>
</html>
