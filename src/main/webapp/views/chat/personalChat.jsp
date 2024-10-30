<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/common.css">

 <style>
	 html {overflow:hidden;} 

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
		overflow-y: auto;
	}
	.msg-area::-webkit-scrollbar {
	    width: 10px;
	}
	.msg-area::-webkit-scrollbar-track {
	    background-color: #eaeaea;
	}
	.msg-area::-webkit-scrollbar-thumb { 
	    background-color: #d0d0d0;
	    border-radius: 10px;
	}
	.msg-area::-webkit-scrollbar-button {
	    display: none;
	}
	.chat .profile-box {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
		flex-shrink: 0;  
		width: 44px; height: 44px;
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
	    min-width: fit-content;
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
	.chat .tag-date {
		width: 120px;
	    margin: 30px auto;
	    padding: 1px 0;
	    background: #999;
	    color: #fff;
	    border-radius: 100px;
	    font-size: 12px;
	    text-align: center;
	}
	.chat .tag-date:first-of-type {
		margin-top:0;
	}
<<<<<<< HEAD
	.chat .empty-msg{
		margin-top: 150px;
		text-align: center;
	}
	.chat .empty-msg p{
		margin-top: 16px;
		font-size: 16px;
		color: #999;
	}
	
	
	
	/*check!! 임시  */
	#message-input{
	    position: absolute;
    	top: 0;
	}
	#send-message{
	    position: absolute;
  	  	top: 50px;
	}
	#chat-box{
	    position: absolute;
    	top: 100px;
	}
	
	
=======
>>>>>>> origin/master
</style>
</head>
<body>
	<div class="chat">
		<input type="hidden" name="chatIdx" value="${roomNum}"/>
        <div class="top-bar">
            <div class="title-box">
                <span class="title"></span><img src="/resources/img/common/ico_user.png" alt="인원수"/><span class="num"></span>
            </div>
            <span class="exit"></span>
        </div>
        <div class="msg-area">
        </div>

        <div class="btm-box">
            <textarea name="msg"></textarea>
            <div class="btn-area">
            	<button class="btn01-s" type="submit">전송</button>
           	</div>
        </div>

    </div>


<<<<<<< HEAD
	<input type="text" id="message-input">
    <button id="send-message" onclick="sendMessage1()">Send</button>
=======
>>>>>>> origin/master






</body>



<script src="/resources/js/common.js" type="text/javascript"></script>


<script>
	console.log("roomNum", "${roomNum}");
	//없으면 채팅방을 만들고채팅방 넘버를 전달해줘야함.


	var chatIdx = $('input[name="chatIdx"]').val();
	$.ajax({
		type: 'GET',
		url: '/chat/data/'+chatIdx,
		//contentType: 'application/json', // JSON 형식으로 보낼 경우 필요
	    //data: JSON.stringify(users),  // 배열을 JSON 문자열로 변환
		dataType: 'JSON',
		success: function(data){
			console.log(data);
			drawContent(data.msgList);
			drawTitle(data.userNames);
		},
		error: function(e){
			console.log(e);
		}
	});

	// 채팅방제목(참여 유저닉네임)
	function drawTitle(userNames){
		var nameCont = '';
		userNames.forEach(function(name,index){
			nameCont+= name;
			if(index != userNames.length-1){
				nameCont+= ', ';
			}
		});
		$('.chat .top-bar .title').text(nameCont);
		$('.chat .top-bar .num').text(userNames.length);
	}
	
	function drawContent(list){
		var msgCont = '';
		if(list.length>0){
			list.forEach(function(cont){

				var timestamp = cont.start_date;
				var date = timestamp.split('T')[0];
				var cvTime = convertHour(timestamp);
				
				// 24 -> 12시간으로 변환
				function convertHour(a) {
					var time = timestamp.split('T')[1].slice(0,5);
					var getHour = time.substring(0, 2); 
					var intHour = parseInt(getHour);  
					if (intHour < 12 ) { 
						var str = '오전 ';
					} else {
						var str = '오후 ';  
					}
					if (intHour == 12) {
						var cvHour = intHour;
					}
					else {
						var cvHour = intHour%12;
					}
					// 'hh:mm'형태로 만들기
					var res = str + ('0' + cvHour).slice(-2) + time.slice(-3);  
					// return
					return res;
				}
				
				
				if(cont.firstOfDay != null){
					msgCont +='<div class="tag-date">'+cont.firstOfDay+'</div>';
				}
				if(cont.sender == '${sessionScope.loginId}'){
					msgCont += '<div class="line me">';
				}else{
					msgCont += '<div class="line">';				
				}
				if(cont.sender != '${sessionScope.loginId}'){
					msgCont += '<div class="profile-box" style="background: url(/resources/img/icon/'+cont.icon_image+') center center / 100% 100% no-repeat;">';
	               if(cont.image != null){
		                   msgCont += '<div class="profile-img" style="background: url(/photo/'+cont.image+') center center / cover no-repeat;"></div>';
	               }else{  
		                   msgCont += '<div class="profile-img"  style="background: url(resources/img/common/profile.png) center center / cover no-repeat;"></div>';
	               }
		            msgCont += '</div>';
				}
				
		           msgCont += '<div class="name-text">';
		           if(cont.sender != '${sessionScope.loginId}'){
		           		msgCont += '<div class="name">'+cont.nickname+'</div>';
		           }
		           msgCont += '<div class="text-area">';
		           msgCont += '<div class="text">'+cont.content+'</div>';
		           msgCont += '<div class="time">'+cvTime+'</div>';
		           msgCont += '</div></div></div>'; 
				
			});
		}else{
			msgCont += '<img src="/resources/img/common/ico_chat.png" alt="[채팅]"><p>채팅을 시작해보세요!</p>';
		}
		
		
		$('.msg-area').append(msgCont);		

	}
<<<<<<< HEAD
	
	function sendMessage(){
		//var message = $('.chat .msg').text();
		var sendData = {};
		sendData.message = $('.chat textarea[name="msg"]').val();
		sendData.chatIdx = chatIdx;
		sendData.baseUser = $('.chat input[name="baseUser"]').val();
		sendData.otherUser = $('.chat input[name="otherUser"]').val();	
		
		$.ajax({
			type: 'POST',
			url: '/chat/send/',
			contentType: 'application/json', 
		    data: JSON.stringify(sendData),  
			dataType: 'JSON',
			success: function(data){
				console.log(data);

			},
			error: function(e){
				console.log(e);
			}
		});
		
	}
	
	
	// db변동 발생시 업데이트
	/*  function startSse() {
        if (!!window.EventSource) {
            const eventSource = new EventSource('/sse');

            eventSource.onmessage = function(event) {
                const newElement = document.createElement("div");
                newElement.innerHTML = "Received message: " + event.data;
                document.getElementById("chat-box").appendChild(newElement);
            };

            eventSource.onerror = function(event) {
                console.error("SSE error occurred");
                eventSource.close();  // 에러 발생 시 SSE 연결 닫기
            };
        } else {
            alert("Your browser does not support SSE.");
        }
    } */
    
 // 메시지 전송 함수
    function sendMessage1() {
    	const message = document.getElementById("message-input").value;

        fetch('/chat/' + chatIdx, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'message=' + encodeURIComponent(message)
        })
        .then(response => response.text())
        .then(data => console.log(data));
        // 데이터 여러개 넣을 수 있는지?? 메세지, 시간, 상대방프사 아이콘, 닉네임
    }

    // SSE 연결 함수
    function startSse() {
    	if (!!window.EventSource) {
            const eventSource = new EventSource('/chat/' + chatIdx + '/sse');

            eventSource.onmessage = function(event) {
                const newElement = document.createElement("div");
                newElement.innerHTML = "New message: " + event.data;
                document.getElementById("chat-box").appendChild(newElement);
            };

            eventSource.onerror = function(event) {
                console.error("SSE error occurred");
                eventSource.close();  // 에러 발생 시 SSE 연결 닫기
            };
        } else {
            alert("Your browser does not support SSE.");
        }
    }
    
=======
>>>>>>> origin/master
    
</script>
</html>