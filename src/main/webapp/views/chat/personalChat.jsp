<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="resources/css/common.css">

 <style>
    .chat {
        width: 400px; height: 700px;
    }
    .chat .top-bar{
        position: relative;
        height: 56px;
        text-align: center;
    }
    .chat .top-bar .exit {
        display: inline-block;
        width: 22px; height: 22px;
        position: absolute;
        top: 17px; right: 14px;
        cursor: pointer;
        background-color: gray;
    }

</style>
</head>
<body>
	<div class="chat">
        <div class="top-bar">
            <div class="title">
                <span>김현아, 김지성</span><img src="" alt="인원수"/><span class="num">2</span>
            </div>
            <span class="exit"></span>
        </div>
        <div class="msg-area">
            <div class="line">
                <div class="profile-box" style="background: url('/resources/img/icon/${profileDto.icon_image}') center center / 100% 100% no-repeat;">
                    <!-- <c:choose>
                        <c:when test="${not empty profileDto.image}">   -->
                            <div class="profile-img" style="background: url(/photo/${profileDto.image}) center center / cover no-repeat;"></div>
                        <!-- </c:when>
                        <c:otherwise> -->
                            <div class="profile-img"  style="background: url(resources/img/common/profile.png) center center / cover no-repeat;"></div>
                        <!-- </c:otherwise> -->
                    </c:choose>
                </div>
                <div class="name-text">
                    <div class="name">김현아</div>
                    <div class="text-area">
                        <div class="text">안녕하세요!</div>
                        <div class="time">오후 5:18</div>
                    </div>
                </div>
            </div>

            <div class="line me">
                <div class="name-text">
                    <div class="text-area">
                        <div class="text">안녕하세요! 반갑습니다. </div>
                        <div class="time">오후 5:18</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="btm-box">
            <input type="text" name="" id="">
            <button type="submit">전송</button>
        </div>

    </div>

</body>



<script src="resources/js/common.js" type="text/javascript"></script>


<script>

    
</script>
</html>