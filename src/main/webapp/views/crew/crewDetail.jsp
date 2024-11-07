<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<link rel="stylesheet" href="/resources/css/crew.css">
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="/resources/css/crew/crewDetail.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="/resources/js/layerPopup.js"></script>
<script src="/resources/js/chatting.js" type="text/javascript"></script>
<style>
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<input type="hidden" name="crew_idx" value="${crew_idx}"/>
	<input type="hidden" name="loginId" value="${loginId}"> 
	
	<div class="layoutbox"></div>
	
	<div class="innerr">
		<div class="one">
			<div id="imgbox">
				<img id="crew-img" src="/resources/img/crew/crewImg800.png" onerror="this.src=/resources/img/crew/crewImg800.png" width="100%" height="100%"/>
			</div>
	
			<button class="btn03-s1" style='visibility : hidden' onclick="crewUpdate()">수정하기</button>
			<button class="btn03-s1" style='visibility : hidden' onclick="layerPopup('크루를 삭제하시겠습니까?', '삭제', '취소', crewDelete ,applBtn2Act)">크루삭제</button>
	
			<div class="title2-1">크루소개</div>
	
			<div class="contentbox" id="crew-content">
				<!-- 크루 소개 내용이 여기에 표시됩니다. -->
			</div>
	
			<div class="title2-1">안내사항</div>
	
			<div class="contentbox">
				<p><img src="/resources/img/crew/img01.png" width="10px" class="imglayout" /> <span id="crew-address"></span></p>
				<p><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"/> <span id="crew-member"></span> 명</p>
				<p><img src="/resources/img/crew/img03.png" width="14px" class="imglayout"/> 매주 <span id="crew-days"></span></p>
				<p><img src="/resources/img/crew/img04.png" width="14px" class="imglayout"/> <span id="crew-minute"></span> 분 / <span id="crew-distance"></span> km</p>
			</div>
	
			<div class="title2-1">크루 공지사항</div>
			<div class="right-x">
				<img src="/resources/img/crew/img07.png" width="40px"/> 
				<span class="right-x1"><a class="crewAccess">바로가기</a></span>
			</div>
			<div class="contentbox">
				<img src="/resources/img/crew/img05.png" width="17px" class="imglayout"/> 최근 공지사항 <span id="notice_date">${notice_date}</span>
			</div>
	
			<div class="title2-1">크루 채팅방</div>
			<div class="right-x">
				<img src="/resources/img/crew/img07.png" width="40px" /> 

				<span class="right-x1"><a id="crewChatLocation">바로가기</a></span>

			</div>
			<div class="contentbox">
				<span><img src="/resources/img/crew/img06.png" width="17px" class="imglayout"/> 
				    <span id="crewChatDisplay">최근 대화가 없습니다.</span>
				</span>
			</div>
			<a href="/crewList"><button class="btn03-s22">목록</button></a>
		</div>

		<div class="two">
			<div class="fixbox">
				<div>
					<img src="/resources/img/crew/img08.png" width="14px" /> 
					<span class="title2-2" id="crew-location"></span>
				</div>
				
				<div class="title1-1" id="crew-name"></div>
				
				<div class="profilebox">
					<span class="profile-text" id="leaderprofile"></span> 
					<div class="profile-box2"></div><!-- 크루장 정보 -->
					<button class="btn03-s2" onclick="crewChat_Admin()"><span id="crewLeaderCheck"></span></button>
				</div>
			</div>
			
		    <div class="scrollable-content" id="crew-member">
				<span class="profile-text" id="crew-member-profile"></span> <!-- 크루원 정보 -->
		    </div>
		    
		    <div class="btn-box">
		    
		    	<div class="crew-box">
			    	<button class="btn01-l2" id="crew-btn-01" onclick="layerPopup('크루 상태를 변경하시겠습니까?', '확인', '취소', crewMemberUpdate, applBtn2Act)">러닝크루 신청하기</button>
			    	<!-- 크루 페이지 로딩 시 가져오기 -->
			    	<div class="btn-like btn02-s1" onclick="like()">
			    		<img src="resources/img/common/ico_heart_no_act.png" onerror="this.src='/resources/img/common/ico_heart_no_act.png'" id="likeImg" alt="좋아요비활성">
		           	</div>
		    	</div>
		    </div>

		</div>
		<!-- 모달 -->
		<div id="profilePopup" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div id="PopupBody"></div>
		    </div>
		</div>
	
	</div>
	
	<div class="layoutbox"></div>
	
	<jsp:include page="../footer.jsp"/>
</body>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/crew/crewDetail.js" type="text/javascript"></script>
<script>
    var crewChatMin = ${crewChatMin};

    if (crewChatMin < 60) {
        document.getElementById("crewChatDisplay").innerText = "마지막 대화 " + crewChatMin + " 분 전";
    } else if (crewChatMin < 1440) {
        document.getElementById("crewChatDisplay").innerText = "마지막 대화 " + Math.floor(crewChatMin / 60) + " 시간 전";
    } else if (crewChatMin < 4320) {
        document.getElementById("crewChatDisplay").innerText = "마지막 대화 " + Math.floor(crewChatMin / 1440) + " 일 전";
    } else {
        document.getElementById("crewChatDisplay").innerText = "최근 대화가 없습니다.";
    }
</script>
</html>