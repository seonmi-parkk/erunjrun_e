<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 팝업 스타일 추가 -->

<script src="/resources/js/chatting.js"></script>

<style>
	#alarmPopup {
	    position: fixed;
	    top: 80px;
    	left: calc(50% - -261px);
	    width: 400px;
	    border: 1px solid #ddd;
	    padding: 20px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    z-index: 1000;
	    display: none;
	    border-radius: 10px;
	    background: #fff;
	}
	
	#alarmPopup .popup-content {
	    position: relative;
	}
	
	#alarmPopup .close {
	    position: absolute;
	    top: 0px;
	    right: 0px;
	    font-size: 20px;
	    cursor: pointer;
	}
	
	#alarmHeader {
	    background: #fff;
	    height: 35px;
	}
	
	#alarmSubject {
	    font-weight: 700;
	    font-size: 18px;
	}
	
	#alarmInfo {
	    font-size: 14px;
	    color: gray;
	    margin-left: 38%;
	}
	
	#alarmListContent {
	    max-height: 300px; /* 고정된 높이 설정 */
	    overflow-y: auto; /* 스크롤바 표시 */
	    background: #fff;
	    border-radius: 10px;
	    padding: 10px;
	    margin: 3px;
	    width: 100%;
	    overflow-x: hidden; /* 가로 스크롤 숨기기 */
	    padding-left: 0px;
	}
	
	#alarmBox {
	    background: #fff;
	    width: 100%;
	    padding: 10px;
	    border-bottom: 1px solid #ddd;
	    margin: 3px;
	    border-radius: 5px;
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	    margin-top: 10px;
	    position: relative; /* 자식 요소가 절대 위치로 고정될 수 있도록 설정 */
	}
	
	#al_subject{
		font-weight: 600;
	    font-size: 15px;
        width: 70px;
	}
	
	#al_content{
		font-size: 14px;
		display: inline-block;
		max-width: 53%;
		white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 설정 */
	    overflow: hidden; /* 넘치는 부분을 숨김 */
	    text-overflow: ellipsis; /* 잘린 부분에 "..."을 표시 */
	    width: 150px;
	}
	
	#al_date{
		font-size: 13px;
   		color: darkgray;
   		float: right;
   		margin-right: 10px;
	}
	
	.alarmclose{
		position: absolute;
	    top: -6px; /* 부모 요소의 위쪽에서 10px 아래에 위치 */
	    right: 10px; /* 부모 요소의 오른쪽에서 10px 왼쪽에 위치 */
	    font-size: 20px;
	    cursor: pointer;
	    color: #888; /* 닫기 아이콘 색상 */
	}
	
	.alarm-item {
	    position: relative;
	    display: flex;
	    align-items: center; /* 세로 중앙 정렬 */
	}
	
	#alarmPopup * {
	    pointer-events: auto;
	}
</style>
<header>
	<div class="header-inner">
		<a href="/">
			<img src="/resources/img/common/logo.png" alt="이런저런"/>
		</a>
		
		<c:choose>
			<c:when test="${empty sessionScope.authority}">
				<ul class="menu">
					<li>
						<a href="/crewList">러닝크루</a>
						<ul class="depth2">
							<li>
								<a href="/crewList">러닝크루</a>			
							</li>
							<li>
								<a href="/crewWrite">러닝크루 개설</a>			
							</li>
						</ul>
					</li>
					<li>
						<a href="/mateList">러닝메이트</a>
					</li>
					<li>
						<a href="/runBoard">게시판</a>
						<ul class="depth2">
							<li>
								<a href="/runBoard">러닝코스 게시판</a>			
							</li>
							<li>
								<a href="/freeBoard">자유주제 게시판</a>			
							</li>
						</ul>
					</li>
					<li>
						<a href="/icon">아이콘몰</a>
					</li>
					<li>
						<a href="/askBoard">문의하기</a>
					</li>
				</ul>
				
				<div class="login-box">
					<c:choose>
						<c:when test="${not empty sessionScope.loginId}">
						
							<div class="profile-area" onclick="location.href='/profileDetail'">
				        		<c:choose>
									<c:when test="${not empty sessionScope.profileImg}">  
										<div class="profile-img" style="background: url(/photo/${sessionScope.profileImg}) center center / cover no-repeat;"></div>
									</c:when>
									<c:otherwise>
										<div class="profile-img" style="background: url(resources/img/common/profile.png) center center / cover no-repeat;"></div>
									</c:otherwise>
								</c:choose>
								<c:if test="${not empty sessionScope.iconImage}">
									<div class="profile-box" style="background: url(/photo/${sessionScope.iconImage}) center center / 100% 100% no-repeat;"></div>
								</c:if>
							</div>
						
							<div class="notice">
								<div class="num-box">
									<span id="alarmNum"></span>
								</div>
								<img id="alarmIcon" class="" src="/resources/img/common/ico_notice.png" alt="알림"/>
							</div>
							<a class="logout" href="/">로그아웃</a>
						</c:when>
						<c:otherwise>
							<a class="login" href="/loginView">로그인</a>
							<a href="/joinView">회원가입</a>
						</c:otherwise>
					</c:choose>
				</div>
			</c:when>
		<c:otherwise>
			<div class="admin-menu"> <!-- 관리자일 경우에만 display: block -->
				<img class="" src="/resources/img/common/admin_profile.png" alt="관리자 프로필 이미지"/>
				<div class="admin-mod on">
					<div class="toggle-slider"></div>
					<span>관리자</span>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	
	
	</div>
</header>
	<!-- 알림 리스트 팝업 -->
	<div id="alarmPopup" class="popup" style="display: none;">
	    <div class="popup-content">
	        <span class="close" >&times;</span> <!-- onclick="closeAlarmPopup(event)" -->
	        <div id="alarmHeader">
	        	<span id="alarmSubject">알림</span>
	        	<span id="alarmInfo">※ 최대 20개 까지 노출됩니다.</span>
	        </div>
	        <div id="alarmListContent">
	        </div>
	    </div>
	</div>
	
<script>
	// 관리자 모드 체크
	 window.onload = function() {
         const savedMode = localStorage.getItem('mode');
         if (savedMode) {
             setMode(savedMode);
         }
     };
     
     // 모드 변경 시 localStorage에 저장하고 페이지 이동
/*      function toggleMode() {
         const currentMode = localStorage.getItem('mode') === 'admin' ? 'user' : 'admin';
         setMode(currentMode);
         localStorage.setItem('mode', currentMode);

         // 각 모드에 따라 페이지 이동
         if (currentMode === 'admin') {
             location.href = '/admin';  // 관리자 페이지로 이동
         } else {
             location.href = '/user';   // 일반 사용자 페이지로 이동
         }
     } */

     // 모드 설정 함수 (버튼이나 UI 상태 변경을 위한 예시)
     function setMode(mode) {
         const modeText = document.querySelector('header .admin-mod span');
         if (mode === 'admin') {
             modeText.textContent = '관리자';
         } else {
             modeText.textContent = '일반';
         }
     } 

     // 관리자모드 헤더 토글
     $('.toggle-slider').on('click',function(){
    	 const currentMode = localStorage.getItem('mode') === 'admin' ? 'user' : 'admin';
         setMode(currentMode);
         localStorage.setItem('mode', currentMode);

         // 각 모드에 따라 페이지 이동 및 css 조정
         $(this).parent().toggleClass('on');
         if (currentMode === 'admin') {
             $(this).siblings('span').text('관리자');
      		location.href='/adminMember';
         } else {
             $(this).siblings('span').text('일반');
            location.href = '/'; 
         }
    	 
/*      	$(this).parent().toggleClass('on');
     	if($('.admin-mod').hasClass('on')){
     		$(this).siblings('span').text('관리자');
     		console.log('관리자모드');
     		location.href='/adminMember';
     	}else{
     		$(this).siblings('span').text('일반');
     		console.log('일반모드');
     		location.href='/adminMember';
     	} */
     });

	  // 헤더 마우스오버 애니메이션
	  $('.menu > li ').on({
	  	'mouseover' : function(){
	  		$(this).find('.depth2').stop().slideDown(200);
	  	},
	  	'mouseleave' : function(){
	  		$(this).find('.depth2').stop().slideUp(200);
	  	},
	  });

     
     

	// 아이콘 체크 
	if('${sessionScope.iconImg}' != ''){
		$('header .profile-box').css('background','url(/${sessionScope.iconImg}) center center/100% no-repeat ');
	}
	
	console.log('${sessionScope.adminYn}');
	console.log('${sessionScope.loginId}');
	console.log('${sessionScope.profileImg}');
	console.log('${sessionScope.iconImg}');
	
	
		
	var loginId = '${sessionScope.loginId}';
	var alarmNum = 0;
	
	if(loginId){
		alarmCount();
		setInterval(alarmCount, 10000);
	}
	
	
	
	// 총 알림 수
	function alarmCount(){
		$.ajax({
			type: 'GET', 
			url: '/alarmCount',
			data: {'loginId' : loginId},
			dataType: 'JSON',
			success: function(response){
				console.log('알림 수 => ', response);
				$('#alarmNum').html(response);
				alarmNum = response;
			},error: function(e){
				//console.log('알림 수 에러 => ', e);
			}
		});
	}
	
	// 알림 리스트 불러오기 (20개)
	$('#alarmIcon').on('click', function(){
		console.log('알림 리스트 실행');
		alarmListPrint();
	});
	
	
	
	function alarmListPrint(){
		
		if(alarmNum > 0){
			$.ajax({
				type: 'POST',
				url: '/alarmList',
				data: {'loginId' : loginId},
				dataType: 'JSON',
				success: function(response){
					console.log(response.result);
					
					var alarmList = '';
	                response.result.forEach(function(alarm) {
	                	var change = '';
	                	if(alarm.code_name === 'AB100' || alarm.code_name === 'AM100' || alarm.code_name === 'AC102'){
	                		change = 'onclick="location.href=\''+alarm.url+'\'"';
	                	}else if(alarm.code_name === 'AN100' || alarm.code_name === 'AN101' || alarm.code_name === 'AN102'){
	                		// 채팅방 열리게
	                	/* 	var url = 'onclick="location.href=\''+alarm.url+'\'"'; */
	                		change = 'onclick="chatWindowSet(\'' + alarm.url + '\')"';
	                		/* alarmUpdate(alarm.alarm_idx); */
	                	}else if(alarm.code_name === 'AC100'){
	                		var url = alarm.url;
	                		var idx = url.split('/').pop();
	                		// 팝업
	                		change = 'onclick="layerPopup(\'' + alarm.content + ' 크루장 권한을 승인하시겠습니까?\', \'승인\', \'거절\', function(){crewAdminUpdate(\'Y\', ' + idx + ',' +alarm.alarm_idx+')}, function(){crewAdminUpdate(\'N\', ' + idx + ')})"';
	                	}else{
	                		// 퇴출 팝업 (크루에서 퇴출되었습니다.)
	                		change = 'onclick="layerPopup(\'' + alarm.content + ' 크루에서 퇴출되었습니다.\', \'확인\', false, function(){alarmUpdate(' + alarm.alarm_idx + ')}, function(){alarmUpdate(' + alarm.alarm_idx + ')})"';
	                	}
						
	                	
	                	alarmList += '<div class="alarm-item" id="alarmBox" data-alarm-idx="' + alarm.alarm_idx + '">';
	                    alarmList += '<div class="alarm-item"' +change+'>';
	                    alarmList += '<span id="al_subject">'+ alarm.subject + '</span>'; // 알림 제목
	                    alarmList += '<span id="al_content">' + alarm.content + '</span>'; // 알림 내용
	                    alarmList += '<span id="al_date">' + alarm.create_date + '</span>'; // 알림 일시
	                    alarmList += '</div>';
	                    alarmList += '<button style="background : #fff" class="alarmclose" data-alarm-idx="' + alarm.alarm_idx + '">&times;</button>';
						alarmList += '</div>';	                	
	                	
	                });
	                
	                $('#alarmBox').on('click', function(){
	                	alarmUpdate(alarm.alarm_idx);
	                });
	                
	                // 알림 리스트 내용 업데이트
	                $('#alarmListContent').html(alarmList);
	                
	                // 팝업 표시
	                $('#alarmPopup').show();
				},error: function(e){
					//console.log('알림 리스트 에러 => ', e);
				}
			});
		}else {
	        // 알림이 없는 경우 팝업에 알림이 없다는 메시지 표시
	        $('#alarmListContent').html('<p>새로운 알림이 없습니다.</p>');
	        $('#alarmPopup').show();
	    }
	}
	


	// x 클릭 시 팝업 닫힘	
	$('.close').on('click', function(){
	    $('#alarmPopup').hide();
	});
	
	
	
	// 상위 부모 요소인 #alarmBox 클릭 이벤트
	$(document).on('click', '#alarmBox', function(event) {
		var alarm_idx = $(this).data('alarm-idx');
	    
	    // 알림 박스 자체를 클릭한 경우 alarmUpdate 함수 실행
 	    if (alarm_idx) {
 	    	console.log('상위부모 알림 업데이트 실행');
	        alarmUpdate(alarm_idx);
	    } 

	    console.log('상위 부모의 클릭 이벤트 실행');
	});

	// .alarmclose 요소 클릭 이벤트
	$(document).on('click', '.alarmclose', function(event) {
		console.log('x 표시 클릭됨')
	    event.stopPropagation(); // 클릭 전파 방지
	    var alarm_idx = $(this).data('alarm-idx');
	    
	    // 특정 알림 업데이트 함수 호출
	    alarmUpdate(alarm_idx);

	    // 알림 리스트를 업데이트하기 위해 alarmIcon 클릭 이벤트 트리거
	    //$('#alarmIcon').click();
	});
	
	function alarmUpdate(alarm_idx){
		console.log('알림 x표시 ㅇㅇㅇㅇㅇㅇㅇㅇㅇ=> ', alarm_idx);
		
		$.ajax({
			type: 'GET',
			url: 'alarmUseUpdate',
			data: {'alarm_idx' : alarm_idx},
			dataType: 'JSON',
			success: function(response){
				if (response) {
					alarmListPrint();
	               // $('#alarmIcon').click(); // 알림 리스트를 다시 불러오기 위해 클릭 이벤트 트리거
	            }
			},error: function(e){
				console.log('알림 update 중 에러 => ', e);
			}
		}); 
	}
	
	// 크루장 권한 업데이트 함수
	function crewAdminUpdate(result, idx, alarm_idx) {
	    console.log('찍히니');
	    alarmUpdate(alarm_idx);
	    console.log('result => ', result);
	    console.log('idx => ', idx);
	    console.log('alarm_idx => ', alarm_idx);
	    var loginId = '${sessionScope.loginId}';

	    $.ajax({
	        type: 'GET',
	        url: '/crew/adminMemberUpdate',
	        data: {
	            'result': result,
	            'crew_idx': idx,
	            'id': loginId
	        },
	        dataType: 'JSON',
	        success: function(response) {
	            if (response) {
	                removeAlert();
	                layerPopup('완료되었습니다.', '확인', false, applBtn2Act, applBtn2Act);

	                console.log('권한 업데이트 성공');
	                alarmUpdate(alarm_idx);

	                // 알림 리스트 다시 불러오기
	                $('.close').click();
	            }
	        },
	        error: function(e) {
	            console.log('권한 업데이트 중 에러 => ', e);
	        }
	    });
	}
	
	// 모달 외부 클릭 시 팝업 닫힘
	$(document).on('click', function(event) {
	    if (!$(event.target).closest('#alarmPopup').length && $('#alarmPopup').is(':visible')) {
	        $('#alarmPopup').hide();
	    }
	});

	
	// 팝업 취소
	function applBtn2Act() {
	    removeAlert(); 
	    alarmUpdate(alarm_idx);
	}
</script>