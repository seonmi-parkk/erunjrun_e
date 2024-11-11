<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crew Manager</title>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/crew/crewManagerList.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="/resources/js/layerPopup.js"></script>
<script src="/resources/js/common.js"></script>
<style>
	.profileImg03 {
		border-radius: 50%;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<input type="hidden" name="crew_idx" value="${crew_idx}"/>
	<input type="hidden" name="loginId" value="${loginId}"/> 
	<input type="hidden" name="leaderId" value="${leaderId}"/>
	<div class="layoutbox"></div>
	<div class="innerr">
		<div class="one">
			<div class="crew-info">
				<div class="crewImg">
					<img class="crew-img" id="crew-img" alt="크루 이미지" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'" width="100%" height="100%">
				</div>
				<div class="crew-text-box">
					<div class="title1-12" id="crew-name"></div>
					<div class="contentbox">
						<div id="leaderprofile">크루장 정보</div>
						<p><img src="/resources/img/crew/img01.png" width="10px" class="imglayout" /> <span class="crewText04" id="crew-address"></span></p>
						<p><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"/> <span id="crew-member"></span> 명</p>
						<p><img src="/resources/img/crew/img03.png" width="14px" class="imglayout"/> 매주 <span id="crew-days"></span></p>
						<p><img src="/resources/img/crew/img04.png" width="14px" class="imglayout"/> <span id="crew-minute"></span> 분 / <span id="crew-distance"></span> km</p>
					</div>
				</div>
			</div>
			<div class="crew-application-list">
			
				<div class="title-layout">
					<div class="title1-12">가입 신청 대기자</div>
					<a href="/crewMemberList/${crew_idx}"><button class="btn02-s1">모두보기</button></a>
				</div>
				<div class="content-box01" id="crewApplicationMemberList"></div>
				
			
			</div>
			<div class="crew-chat-list">
				<div class="title-layout">
					<div class="title1-12">크루장 문의하기 채팅</div>
					<button class="btn02-s1" onclick="location.href='/crewChatListView/${crew_idx}'">모두보기</button>
				</div>
				
			</div>
		</div>
		<div class="two">
			<div class="fixbox">
				<div class="title1-1" id="crew-name">크루원 관리</div>
				<div class="btn-layout">
					<a href="/crewAuthorityList/${crew_idx}"><button class="btn02-s13">권한기록</button></a>
					<button class="btn04-s" onclick="crewAdminUpdate()">권한</button>
					<button class="btn02-s" onclick="layerPopup('크루원을 퇴출하시겠습니까?', '확인', '취소', crewExpel, applBtn2Act)">퇴출</button>
				</div>
			</div>
			
		    <div class="scrollable-content" id="crew-member">
				<span class="profile-text" id="crew-member-profile"></span> <!-- 크루원 정보 -->
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
<script src="/resources/js/chatting.js" type="text/javascript"></script>
<script src="/resources/js/crew/crewManagerList.js" type="text/javascript"></script>
</html>