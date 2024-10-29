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
        padding: 0 14px;
        text-align: center;
     	display : flex; display: -moz-box; display: -ms-flexbox;
     	-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;  
    }
    .chat .top-bar .exit {
        display: inline-block;
        width: 22px; height: 22px;
        position: absolute;
        top: 17px; right: 14px;
        cursor: pointer;
        background: url('/resources/img/common/ico_exit.png');
    }
    .chat .title-box img {
   	    margin: 0 4px 0 8px;
    }
    .chat .title-box .title {
    	font-weight: 500;
    	color: #555;
    }
    .chat .title-box .num {
		display: inline-block;
	    transform: translateY(-1px);
	    font-size: 13px;
	    color: #666;
    }
	.chat .msg-area {
		height: 500px; 
		padding: 26px 14px 26px 7px;
		background: #f8f8f8;
		border-radius: 20px 20px 0 0;
	}
	.chat .profile-box {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
		flex-shrink: 0;  
		width: 40px; height: 40px;
		margin-right: 2px;
	}
	.chat .profile-box .profile-img {
		width: 33px; height: 33px;
		border-radius: 50%;
	}
	.chat .msg-area .line{
		display : flex; display: -moz-box; display: -ms-flexbox;
		margin-bottom: 8px;
	}
	.chat .msg-area .line.me{
		 flex-direction: row-reverse;
	}
	.chat .line .name{
		color: #666;
		font-size: 14px;
		margin: 4px 0 2px;
	}
	.chat .line .text {
		padding: 8px 14px;
		border-radius: 0px 30px 30px 24px;
		background-color: #fff;
		box-shadow: var(--shadow1-box-shadow, 0px 4px 13px 0px rgba(0, 0, 0, 0.12));
		font-size: 14px;
	}
	.chat .line.me .text {
		border-radius: 30px 0 20px 30px;
		background-color: var(--main-color);
		color: #fff;
	}
	.chat .line .text-area {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-align: end; -ms-flex-align: end; align-items: flex-end;
		margin-bottom: 8px;
	}
	.chat .line.me .text-area {
		 flex-direction: row-reverse;
	}
	.chat .line .time {
		margin-left: 4px;
		font-size: 10px;
		color: #666;
	}
	.chat .line.me .time {
		margin-left : 0;
		margin-right: 4px;
	}
	.chat .btm-box {
		position: relative;
		padding: 20px 14px;
	    border-radius: 20px 20px 0 0;
	    background: #fff;
	}
	.chat .btm-box::before {
		content: "";
		position: absolute;
		z-index: -1;
		top: 0; left: 0;
		width: 100%;
		height: 100%;
		background: #f8f8f8;
	}
	.chat .btm-box textarea {
		width: 100%;
		height: 75px;
		padding: 6px 8px; 
		border: none;
		border-radius: 10px;
		background: #f8f8f8;
		resize: none;
	}
	.chat .btm-box .btn-area {
		padding: 6px 0 8px;
		text-align: right;
	}

</style>
</head>
<body>
	<div class="chat">
		<input type="hidden" name="chatIdx" value="1"/>
        <div class="top-bar">
            <div class="title-box">
                <span class="title">김현아, 김지성</span><img src="/resources/img/common/ico_user.png" alt="인원수"/><span class="num">2</span>
            </div>
            <span class="exit"></span>
        </div>
        <div class="msg-area">
            <div class="line">
            	<!-- check!! 아이콘 & 프로필 이미지 바꾸기 -->
            	<div class="profile-box" style="background: url('/resources/img/icon/') center center / 100% 100% no-repeat;">
            		<div class="profile-img" style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div>
            		<%-- <div class="profile-img" style="background: url(/photo/${profileDto.image}) center center / cover no-repeat;"></div> --%>
                </div>
            
               <%--  <div class="profile-box" style="background: url('/resources/img/icon/${profileDto.icon_image}') center center / 100% 100% no-repeat;">
                    <!-- <c:choose>
                        <c:when test="${not empty profileDto.image}">   -->
                            <div class="profile-img" style="background: url(/photo/${profileDto.image}) center center / cover no-repeat;"></div>
                        <!-- </c:when>
                        <c:otherwise> -->
                            <div class="profile-img"  style="background: url(resources/img/common/profile.png) center center / cover no-repeat;"></div>
                        <!-- </c:otherwise> -->
                    </c:choose>
                </div> --%>
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
            <textarea name="msg"></textarea>
            <div class="btn-area">
            	<button class="btn01-s" type="submit">전송</button>
           	</div>
        </div>

    </div>








</body>



<script src="/resources/js/common.js" type="text/javascript"></script>


<script>
	var chatIdx = $('input[name="chatIdx"]').val();
	$.ajax({
		type: 'GET',
		url: '/personalChatList/'+chatIdx,
		//contentType: 'application/json', // JSON 형식으로 보낼 경우 필요
	    //data: JSON.stringify(users),  // 배열을 JSON 문자열로 변환
		dataType: 'JSON',
		success: function(list){
			console.log(list);
			drawContent(list);
		},
		error: function(e){
			console.log(e);
		}
	});

	
	function drawContent(list){
		var msgCont = '';
		list.forEach(function(cont){
			console.log("line.content",cont.content);
			/* if(cont.sender = ${sessionCope.loginId}){
				msgCont += '<div class="line">';
            
				msgCont += '<div class="profile-box" style="background: url('/resources/img/icon/${profileDto.icon_image}') center center / 100% 100% no-repeat;">';
                    <c:choose>
                        <c:when test="${not empty profileDto.image}"> 
                        msgCont += '<div class="profile-img" style="background: url(/photo/${profileDto.image}) center center / cover no-repeat;"></div>';
                        </c:when>
                        <c:otherwise>
                        msgCont += '<div class="profile-img"  style="background: url(resources/img/common/profile.png) center center / cover no-repeat;"></div>';
                        </c:otherwise> 
                    </c:choose>
                    
                    
               
                    
                    
                    
                    
                    msgCont += '</div>';
                <div class="name-text">
                    <div class="name">김현아</div>
                    <div class="text-area">
                        <div class="text">안녕하세요!</div>
                        <div class="time">오후 5:18</div>
                    </div>
                </div>
            </div> 
			}*/
		});
		
		
					

	}
    
</script>
</html>