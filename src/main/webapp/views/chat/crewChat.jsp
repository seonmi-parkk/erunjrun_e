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
	.chat .empty-msg{
		margin-top: 150px;
		text-align: center;
	}
	.chat .empty-msg p{
		margin-top: 16px;
		font-size: 16px;
		color: #999;
	}
	.chat img.tag-leader {
		margin-left: 3px;
	}
	
	
	
</style>
</head>
<body>
	<div class="chat">
		<input type="hidden" name="crewIdx" value="${crewIdx}"/>
		<input type="hidden" name="chatIdx" value="${roomNum}"/>
		<input type="hidden" name="crewLeader" value=""/>
		<input type="hidden" name="baseUser" value=""/>
        <div class="top-bar">
            <div class="title-box">
                <span class="title"></span><img src="/resources/img/common/ico_user.png" alt="인원수"/><span class="num"></span>
            </div>
        </div>
        <div class="msg-area">
        </div>

        <div class="btm-box">
            <textarea id="msg" name="msg"></textarea>
            <div class="btn-area">
            	<button class="btn01-s" onclick="sendMessage()">전송</button>
           	</div>
        </div>
    </div>

	<!-- 
	<input type="text" id="message-input">
    <button id="message-btn" onclick="sendMessage1()">Send</button>
    <div id="chat-box" style="border:1px solid black; height:200px; width:300px; overflow:auto;"></div>
 	-->

	<!-- <div id="chat-box" style="border:1px solid black; height:200px; width:300px; overflow:auto;"></div> -->
</body>

<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>

<script>
	console.log("sessionScope.loginId", "${sessionScope.loginId}");
	console.log("roomNum", "${roomNum}");

	function scrollBtm(){
		$('.chat .msg-area').scrollTop($('.chat .msg-area')[0].scrollHeight);
	}

	var crewIdx = $('input[name="crewIdx"]').val();
	var chatIdx = $('input[name="chatIdx"]').val();
 	getChat(scrollBtm);
	function getChat(callback){
		$.ajax({
			type: 'GET',
			url: '/crewChat/data/'+crewIdx+'/'+chatIdx,
			dataType: 'JSON',
			success: function(data){
				console.log(data);
				drawTitle(data.crewInfo,data.crewLeader);
				drawContent(data.msgList, callback);
			},
			error: function(e){
				console.log(e);
			}
		});
	}


	// 채팅방제목(참여 유저닉네임)
	function drawTitle(crewInfo,crewLeader){
		var nameCont = '';
		
		$('.chat input[name="baseUser"]').val('${sessionScope.loginId}');			
		$('.chat input[name="crewLeader"]').val(crewLeader);	
		
		$('.chat .top-bar .title').text(crewInfo.crew_name);
		$('.chat .top-bar .num').text(crewInfo.current_member);
		
		var leaderId = $('.chat input[name="crewLeader"]').val();
		console.log("leaderId :!!!!!",leaderId);
	}
	
	
	function drawContent(list,callback){
		var msgCont = '';
		if(list.length>0){
			list.forEach(function(cont){

				var timestamp = cont.create_date;
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
		                   msgCont += '<div class="profile-img"  style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div>';
	               }
		            msgCont += '</div>';
				}

		           msgCont += '<div class="name-text">';
		           if(cont.sender != '${sessionScope.loginId}'){
		           		msgCont += '<div class="name">'+cont.nickname;
		           		if(cont.sender == $('.chat input[name="crewLeader"]').val() ){
		           			msgCont += '<img class="tag-leader" src="/resources/img/common/tag_leader.png" alt="크루장" />';
		           		}
		           		msgCont += '</div>';
		           }
		           msgCont += '<div class="text-area">';
		           msgCont += '<div class="text">'+cont.content+'</div>';
		           msgCont += '<div class="time">'+cvTime+'</div>';
		           msgCont += '</div></div></div>'; 
				
			});
		}else{
			msgCont += '<div class="empty-msg"><img src="/resources/img/common/ico_chat.png" alt="[채팅]"><p>채팅을 시작해보세요!</p></div>';
		}
		
		$('.msg-area').html(msgCont);		
		callback();
	}
	
	var msg = document.getElementById('msg');
	msg.addEventListener("keypress", function(event) {
        if (event.key === "Enter") {
            // 엔터 키가 눌리면 실행할 코드
            sendMessage();
        }
    });
	
	function sendMessage(){
		console.log("전송클릭");
		//var message = $('.chat .msg').text();
		var sendData = {};
		sendData.message = $('.chat textarea[name="msg"]').val();
		sendData.chatIdx = chatIdx;
		sendData.baseUser = $('.chat input[name="baseUser"]').val();
		$('.chat textarea[name="msg"]').val('');
		
		
		$.ajax({
			type: 'POST',
			url: '/crewChat/send/',
			contentType: 'application/json', 
		    data: JSON.stringify(sendData),  
			dataType: 'JSON',
			success: function(data){	
				console.log(data);
				getChat(scrollBtm);
				scrollBtm();
			},
			error: function(e){
				console.log(e);
			}
		}); 
		
	}
	
	
	
	// textarea 글자수 제한
	$('.chat textarea[name="msg"]').keyup(function(){
		  var content = $(this).val();
		  if (content.length > 100){
			  alert("최대 100자까지 입력 가능합니다.");
			  $(this).val(content.substring(0, 100));
		 }
	});
	
	
	// 실시간 데이터 불러오기
  	setInterval(function(){
		getChat();
	}, 3000);   
	
	
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
  
    
    /*
 // 메시지 전송 함수
    function sendMessage1() {
    	const message = document.getElementById("message-input").value;
    	console.log("Sending message:", message);  // 메시지 전송 전 확인
    	
        fetch('/chat/update/' + chatIdx, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'message=' + encodeURIComponent(message)
        })
        .then(response => response.text())
        .then(data => {
            console.log("Response from server:", data);  // 서버 응답 확인
        });
    }

    // SSE 연결 함수
    function startSse() {
    	if (!!window.EventSource) {
            const eventSource = new EventSource('/chat/' + chatIdx + '/sse');

            eventSource.onmessage = function(event) {
            	console.log("Received SSE message:", event.data);  // 수신된 메시지 확인
            	 // 서버로부터 받은 데이터를 JSON으로 파싱
                const data = JSON.parse(event.data);
                console.log("Parsed data:", data);  // 파싱된 데이터 확인

                // 사용자 ID, 메시지, 시간 추출
                const userId = data.userId;
                const message = data.message;
                const time = data.time;
                console.log("userId!!!"+userId);
                console.log("message!!!"+message);
                console.log("time!!!"+time);
                
                // 화면에 표시
                const newElement = document.createElement("div");
                newElement.innerHTML = 'User: '+userId+', Message: '+message+', Time:'+ time;
                document.getElementById("chat-box").appendChild(newElement);
            };

            eventSource.onerror = function(event) {
                console.error("SSE error occurred");
                eventSource.close();  // 에러 발생 시 SSE 연결 닫기
                setTimeout(startSse, 1000);
            };
        } else {
            alert("Your browser does not support SSE.");
        }
    }
    
    */
    
    
</script>
</html>