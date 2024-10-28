<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" xmlns:th="http://www.thymeleaf.org" xmlns:sec="http://www.thymeleaf.org/extras/spring-security">
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="resources/css/common.css">

 <style>
  
</style>
</head>
<body>
	<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채팅방</title>
    <!-- 필요에 따라 CSS와 JavaScript 추가 -->
</head>

<body>
    <div class="container">
        <div class="col-6">
            <label><b>채팅방</b></label>
        </div>
        <div>
            <div id="msgArea" class="col"></div>
            <div class="col-6">
                <div class="input-group mb-3">
                    <input type="text" id="msg" class="form-control" aria-label="Recipient's username"
                        aria-describedby="button-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <button id="disconn">채팅 나가기</button>

    <!-- JQuery CDN (필요할 경우 추가) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/path/to/your/custom-js-file.js"></script>
</body>

</body>



<script src="resources/js/common.js" type="text/javascript"></script>


<script>
$(document).ready(function() {

    // 예시: REST API를 통해 사용자 정보 가져오기 (Spring Security에서 제공하는 API로 설정 가능)
    let username = '${sessionScope.loginId}';


    $("#disconn").on("click", (e) => {
        disconnect();
    });

    $("#button-send").on("click", (e) => {
        send();
    });

    const websocket = new WebSocket("ws://localhost:8080/ws/chat");

    websocket.onmessage = onMessage;
    websocket.onopen = onOpen;
    websocket.onclose = onClose;

    function send() {
        let msg = document.getElementById("msg");

        console.log(username + ":" + msg.value);
        websocket.send(username + ":" + msg.value);
        msg.value = '';
    }

    // 채팅창에서 나갔을 때
    function onClose(evt) {
        let str = username + ": 님이 방을 나가셨습니다.";
        websocket.send(str);
    }

    // 채팅창에 들어왔을 때
    function onOpen(evt) {
        let str = username + ": 님이 입장하셨습니다.";
        websocket.send(str);
    }

    function onMessage(msg) {
        let data = msg.data;
        let sessionId = null;
        let message = null;
        let arr = data.split(":");

        let cur_session = username;

        sessionId = arr[0];
        message = arr[1];

        // 로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
        if (sessionId == cur_session) {
            let str = "<div class='col-6'>";
            str += "<div class='alert alert-secondary'>";
            str += "<b>" + sessionId + " : " + message + "</b>";
            str += "</div></div>";
            $("#msgArea").append(str);
        } else {
            let str = "<div class='col-6'>";
            str += "<div class='alert alert-warning'>";
            str += "<b>" + sessionId + " : " + message + "</b>";
            str += "</div></div>";
            $("#msgArea").append(str);
        }
    }
});
</script>
    

</html>