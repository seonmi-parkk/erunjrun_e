<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crew Manager</title>
<link rel="stylesheet" href="/resources/css/common.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="/resources/js/layerPopup.js"></script>
<script src="/resources/js/common.js"></script>
<style>

	.innerr {
	    max-width: 1300px;
	    margin: 80px auto 0;
	    display: flex;                  
	    justify-content: space-between; 
	    align-items: flex-start;        
	    gap: 20px;      
	}
	
	.layoutbox {
	    height: 90px;                  /* 이 높이와 동일한 값을 .two의 top에 설정 */
	    background-color: white;        /* 헤더 영역이 배경과 겹치지 않도록 배경색 추가 */
	}

	.crew-info{
		background: #fff;
		border-style: solid;
		border-color: #bdbdbd;
		border-width: 0px 0px 1px 0px;
		height: 300x;
		position: relative;
		display: flex;
	}
	.crew-application-list{
		background: #fff;
		border-style: solid;
		border-color: #bdbdbd;
		border-width: 0px 0px 1px 0px;
		height: 350px;
		position: relative;
	}
	
	.crew-chat-list{
		background: #fff;
		border-style: solid;
		border-color: #bdbdbd;
		border-width: 0px 0px 1px 0px;
		height: 350px;
		position: relative;
	}
	
	.one {
	    width: 70%;                     
	    padding: 20px;                  
	    box-sizing: border-box;          
	    /* background-color: #D5D5D5; */
	    position: relative;              /* 기본 요소 배치를 유지 */
	    z-index: 1;                      /* 다른 요소들 위에 놓기 */
	}
	
    .two {
        width: 30%;
        padding: 20px;
        box-sizing: border-box;
        background-color: #FBFBFB;
        position: relative;
        max-height: 1200px;
        overflow-y: hidden;
        position: sticky;
        top: 100px;
        z-index: 80;
        display: flex;
        flex-direction: column;
        justify-content: space-between; /* 자식 요소들이 위아래로 배치되도록 설정 */
    }
    
    .fixbox {
	    position: sticky;                /* 이 부분은 고정 */
	    top: 0;                          /* 상단에 고정 */
/* 	    background-color: #FFD9EC;        *//* 스크롤 시 배경이 덮이지 않도록 설정 */
    	z-index: 10;
	}
	
    .title2-2{
    	color: var(--main-color);
        font-family: "Pretendard Variable", sans-serif;
        font-size: 20px;
        font-weight: 500;
        display: inline-block;
   		width: 200px;
   		padding: 0px 11px 0px 6px;
   		position: relative; /* 상대적인 위치 설정 */
   		bottom: 3px;
    }

    .title1-1 {
        color: var(--font-color);
        font-family: "GmarketSans", sans-serif;
        font-size: 25px;
        font-weight: 700;
        padding: 10px 0px 10px;
    }
    
    
    
    .title1-12 {
        color: var(--font-color);
        font-family: "GmarketSans", sans-serif;
        font-size: 25px;
        font-weight: 700;
        padding: 25px 25px 5px;
    }
    
    .title1-12 a {
        color: var(--font-color);
        font-family: "GmarketSans", sans-serif;
        font-size: 25px;
        font-weight: 700;
    }
   
	.scrollable-content {
	    max-height: 1200px;               /* 스크롤할 영역의 최대 높이 설정 */
	    overflow-y: auto;                /* 이 부분만 스크롤 가능하게 설정 */
	    margin-top: 20px;                /* 위쪽 고정 영역과의 간격 */
	    
	    margin: 0;
        padding: 0;
        border: 0;
        font-size: 16px;
        font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
        vertical-align: baseline;
        box-sizing: border-box;
        color: var(--font-color);
        background: #fff;
        height: 700px;
	}
	
	.btn-layout{
		margin-bottom: 10px;
	}
	
	.btn02-s1 {
    	 display: inline-block;
         height: 32px;
         padding: 8px 11px;
         margin: 0 4px;
         border-radius: 10px;
         border: 1px solid #AAAAAA;
         color: #AAAAAA;
         background: #fff;
         cursor: pointer;
	}
	
	.btn02-s13 {
    	 display: inline-block;
         height: 32px;
         padding: 8px 11px;
         margin: 0 4px;
         border-radius: 10px;
         border: 1px solid #AAAAAA;
         color: #AAAAAA;
         background: #fff;
         cursor: pointer;
         font-size: 14px;
         margin-right: 140px;
	}
	
	.btn04-s{
    	display: inline-block;
        height: 32px;
        padding: 6px 11px;
        margin: 0 4px;
        border-radius: 10px;
        border: 1px solid #6994FF;
        color: #6994FF;
        background: #fff;
        cursor: pointer;
        font-size: 14px;
    }
    
    .title-layout{
    	display: flex;
        align-items: baseline;
        justify-content: space-between;
    }
    
	.crewImg {
	    position: relative; /* 하트 아이콘이 이미지 위에 배치될 수 있도록 상대 위치 설정 */
	    width: 180px; /* 이미지의 너비를 140px로 설정 */
	    height: 180px; /* 이미지의 높이를 140px로 설정 */
	    border-radius: 12px; /* 이미지 모서리를 둥글게 설정 */
	    overflow: hidden; /* 이미지가 영역을 넘칠 경우 숨김 */
	    margin: 35px 0px 0px 25px
	}
    
	.crew-img {
	    width: 100%; /* 이미지 너비를 부모 요소에 맞춤 */
	    height: 100%; /* 이미지 높이를 부모 요소에 맞춤 */
	    object-fit: cover; /* 이미지 비율을 유지하면서 넘치는 부분을 잘라냄 */
	}
	
	.crew-text-box{
		margin: 10px 0px 0px 0px;
	}
	
    .contentbox{
    	width: 100%;
   		padding-left: 25px;
   		line-height: 30px;
   		
    }
    
    .content-box01{
        margin-left: 25px;
    	margin-top: 12px;
  		margin-bottom: 17px;
    }
    
    .leaderjb{
		display: flex;  /*수직 정렬 flex, center*/
    	align-items: center;  
	}
	
	.testeee{
		margin-left: 10px;
		display: flex;  /*수직 정렬 flex, center*/
    	align-items: center;  
    	padding: 10px 0px 10px 0px;
	}
	
    #btn04-s{
    	display: inline-block;
        height: 32px;
        padding: 6px 11px;
        margin: 0 4px;
        border-radius: 10px;
        border: 1px solid #6994FF;
        color: #6994FF;
        background: #fff;
        cursor: pointer;
        font-size: 14px;
    }
    
    .profileImg{
    	margin-right: 10px;
   		margin-left: 10px;
   		margin-bottom: -10px;
    }
    
    input[type="checkbox"]{
        margin-top: 6px;
    }
    
    a{
    	text-decoration-line: none;
    }
    
    .profileImg_01{
    	margin-right: 15px;
    }
    
    .imglayout{
    	margin: 11px 14px -3px 9px;
    }
    
    .genderImg{
        margin: 0px 3px -3px 3px;
    }
    
    .profileImg03{
    	margin: 0px 13px 0px 2px;
    }
    
    .testeee .btn-sty06{
    	margin-left: auto;
    }

    /*운동프로필 레이어팝업*/
	#profilePopup {
	    width: fit-content;
	    top: 185px;
	    left: 50%;
	    transform: translateX(-50%);
		z-index: 996;
		display: none;
	}
	#profilePopup .close {
	    font-size: 40px;
	    font-weight: 300;
	    position: absolute;
	    z-index: 996;
	    top: 30px;
	    right: 30px;
	    display: inline-block;
	    width: 30px;
	    height: 30px;
	    line-height: 27px;
	    text-align: center;
	}
	#profilePopup .modal-content{
	    padding: 20px 20px;
	    background: #f8f8f8;
	    border: none;
    	border-radius: 0;
    }
    #PopupBody {
    	background: #fff;
    	border-radius: 10px;
    }
	 
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<input type="hidden" name="crew_idx" value="${crew_idx}"/>
	
	
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
					<button class="btn02-s1">모두보기</button>
				</div>
				<div class="content-box01">어쩌구 저쩌구</div>
				<div class="content-box01">어쩌구 저쩌구</div>
				<div class="content-box01">어쩌구 저쩌구</div>
				<div class="content-box01">어쩌구 저쩌구</div>
				<div class="content-box01">어쩌구 저쩌구</div>
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
<script>

	var loginId = '${sessionScope.loginId}';
	var crewLeader = '';
	var crew_idx = $('input[name="crew_idx"]').val();
	var crewone = [];

	$(document).ready(function () {
	    
	    console.log('crew_idx =>', crew_idx);
	    crewDetail(); 
	    crewMemberList();
	    
	});
	
	function crewMemberList() {
	    console.log('크루 회원 리스트 요청');
	    $.ajax({
	        type: 'POST',
	        url: '/crew/memberList',
	        data: { 'crew_idx': crew_idx },
	        dataType: 'JSON',
	        success: function (response) {
	            console.log('회원 데이터 받아옴 => ', response);
	            console.log('신청 회원 리스트 =>', response.application);

	            if (response.success) {
	                var result = response.result;
	                var application = response.application;
	                
	                crewApplicationMember(application);

	                // 프로필 이미지 기본값 설정 (추가 조건이 있으면 적용 가능)
	                var profileImg = '<img src="/resources/img/common/profile.png" class="profileImg" width="32px"/>';
	                var genderImg = '';
	                var content = '';

	                result.forEach(function(item, idx) {
	                    // 성별에 따른 이미지 설정
	                    genderImg = item.gender === '남' 
	                        ? '<img src="/resources/img/common/ico_male.png" width="9px" class="genderImg"/>'
	                        : '<img src="/resources/img/common/ico_female.png" width="9px" class="genderImg"/>';

	                    // 크루장 체크
	                    if (item.is_leader === 'Y') {
	                        crewLeader = item.id;
	                        console.log('반복문 안에서 리더 id 체크 =>', crewLeader);
	                        $('#leaderprofile').html('<div class="leaderjb">' + profileImg 
	                        		+ '<a class="user" style="cursor: pointer;"  data-id="' + item.id + '">' 
	                        		+ item.nickname + ' / ' 
	                            + genderImg + ' / ' + '크루장' + '</div></a>');
	                        $('.profileImg').attr('class', 'profileImg_01');
	                    } else {
	                        crewone.push(item.id); // 배열에 크루원 id 추가
	                        content += '<div class="testeee"><input class="basictex" type="checkbox" name="crew_member" data-id="'+item.id+'"/>' +
	                        '<a class="user" style="cursor: pointer;"  data-id="' + item.id + '">' 
	                            + profileImg + ' ' + item.nickname + ' / ' + genderImg + ' / '  + item.create_date + '</div></a>';
	                    }
	                });

	                $('#crew-member-profile').html(content);
	            }
	        },
	        error: function (e) {
	            console.log('에러 발생 => ', e);
	        }
	    });
	}
	
	function crewDetail() {
        console.log('크루 데이터 요청');
        
        $.ajax({
            type: 'POST',
            url: '/crew/detail',
            data: { 'crew_idx': crew_idx },
            dataType: 'JSON',
            success: function (response) {
                console.log('데이터 받아옴 => ', response);
                if (response.success) {
                    // 받아온 데이터를 HTML에 반영
                    var result = response.result;
                    
                    // 이미지 업데이트
                    if (result.img_new) {
                        $('#crew-img').attr('src', '/photo/' + result.img_new);
                    }
                    var day = result.days; // 예: "mon"

	                // replace를 사용해서 변환
	                day = day.replace('mon', '월')
	                         .replace('tue', '화')
	                         .replace('wen', '수')
	                         .replace('thu', '목')
	                         .replace('fri', '금')
	                         .replace('sat', '토')
	                         .replace('sun', '일');

                    // 크루명, 소개, 안내사항 등 업데이트
                    $('#crew-name').html('<a href="/crewDetail/'+crew_idx+'">'+result.crew_name+'</a>');
                    $('#crew-content').html(result.content);
                    $('#crew-address').text(result.address);
                    $('#crew-member').text(result.member);
                    $('#crew-days').text(day);
                    $('#crew-minute').text(result.minute);
                    $('#crew-distance').text(result.distance);
                    
                }
            },
            error: function (e) {
                console.log('에러 발생 => ', e);
            }
        });
    }
    
	function crewApplicationMember(application) {
		var profileImg = '<img src="/resources/img/common/profile.png" width="32px" class="profileImg03"/>';
        var genderImg = '';
        var content = '';
        
        console.log('신청자 리스트 함수 실행');
	    
        application.slice(0, 5).forEach(function(item, idx) {
	        // 성별에 따른 이미지 설정
	        var genderImg = item.gender === '남' 
	            ? '<img src="/resources/img/common/ico_male.png" width="9px" class="genderImg"/>'
	            : '<img src="/resources/img/common/ico_female.png" width="9px" class="genderImg"/>';

	        // 프로필 이미지와 닉네임, 성별 및 날짜 정보 추가
	        content += '<div class="testeee">' + profileImg + '<a class="user" style="cursor: pointer;"  data-id="' + item.id + '">' + item.nickname + ' / ' + genderImg + ' / ' + item.create_date + '</a>'
	            + '<div class="btn-sty06"> <button class="btn02-s" onclick="layerPopup(\'' + item.nickname + '님을 승인 하시겠습니까?\', \'승인\', \'취소\', function() { memberResult(\'' + item.id + '\', \'' + item.nickname + '\', \'Y\'); }, applBtn2Act)">승인</button>'
	            + '<button class="btn02-s" id="btn04-s" onclick="layerPopup(\'' + item.nickname + '님을 거절 하시겠습니까?\', \'거절\', \'취소\', function() { memberResult(\'' + item.id + '\', \'' + item.nickname + '\', \'N\'); }, applBtn2Act)">거절</button></div></div>';
	    });

	    $('#crewApplicationMemberList').html(content);
	}
	
	function memberResult(id, nickname, value) {
	    console.log('ID:', id);
	    console.log('Nickname:', nickname);
	    console.log('value:', value);
	    
		var crew_idx = 52; // 나중에 변경 필요
		var code_name = '';
		
		if(value === 'Y'){
			code_name = 'C101';
		}else{
			code_name = 'C102';
		}

		console.log('code_name : ', code_name);			
		console.log('실행됨>');
		
			$.ajax({
			type: 'POST',
			url: '/crew/applicationWrite',
			data: {'loginId' : id,
				'crew_idx' : crew_idx,
				'code_name' : code_name},
			dataType: 'JSON',
			success: function(response){
				
				console.log('성공');
				
				if(response.success){
					removeAlert();
					layerPopup(response.msg + '완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
					crewMemberList();
				}else{
					removeAlert();
					layerPopup(response.msg + '미완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
				}
				
			},error: function(e){
				soncole.log('에러남 => ', e);
			}
		}); 
		 
	    
	}
	
	// 선택된 체크박스의 ID 배열을 가져오는 함수
	function getSelectedIds() {
	    var selectedIds = [];
	    $('input[name="crew_member"]:checked').each(function() {
	        selectedIds.push($(this).data('id')); // 체크된 체크박스의 data-id 값을 배열에 추가
	    });
	    return selectedIds;
	}

	function crewAdminUpdate() {
	    var selectedIds = getSelectedIds(); // 선택된 체크박스의 ID 배열 가져오기
	    
	    if (selectedIds.length === 0) {
	        // 선택된 체크박스가 없을 때 알림
	        alert("권한을 양도할 회원을 선택해 주세요.");
	    } else if (selectedIds.length > 1) {
	        // 1개 이상의 ID가 선택된 경우 알림
	        layerPopup('권한은 한명에게만 양도할 수 있습니다.', '확인', false, applBtn2Act, applBtn2Act);
	    } else {
	        // 선택된 ID가 1개인 경우에만 권한 양도 팝업 띄우기
	        layerPopup('권한을 양도하시겠습니까?', '확인', '취소', function() {
	            sendCrewAdminUpdate(selectedIds[0]); // 선택된 ID를 서버에 전송
	        }, applBtn2Act);
	    }
	}

	
	
	function sendCrewAdminUpdate(memberId){
		var selectedIds = getSelectedIds();
	    
	    var leader = crewLeader;
	    console.log('선택된 ID:', selectedIds[0]); // 콘솔에 선택된 ID 출력
	    console.log('리더 아이디 => ', leader);
	    
	    var crew_idx = $('input[name="crew_idx"]').val();
		
  		$.ajax({
			type: 'POST',
			url : '/crew/AdminUpdate',
			data: { 'id' : memberId,
					'leader' : leader,
					'crew_idx' : crew_idx}, // JSON 형태로 전송
			dataType: 'JSON',
			success: function(response){
				if(response.success){
					removeAlert();
					layerPopup('권한 양도 요청이 완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
				}else{
					removeAlert();
					layerPopup('권한 양도 요청이 미완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
				}
			}, error: function(e){
				console.log('권한 전송 중 에러 => ', e);
			}
		});  
		
	}
	
	function crewExpel(){
		var crew_idx = $('input[name="crew_idx"]').val();
		var selectedIds = getSelectedIds();
		
		$.ajax({
			type: 'POST',
			url: '/crew/crewExpel',
			traditional: true,
			data: { 'ids' : selectedIds,
				'crew_idx' : crew_idx},
			dataType: 'JSON',
			success: function(response){
				if(response.success){
					removeAlert();
					layerPopup('크루원 퇴출이 완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
					crewMemberList();
				}else{
					removeAlert();
					layerPopup('크루원 퇴출이 미완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
				}
			}, error: function(e){
				console.log('권한 전송 중 에러 => ', e);
			}
		});
	}
	
	
	// 팝업 취소
	function applBtn2Act() {
	    removeAlert(); 
	}
	
	// 클릭시 운동프로필 레이어 팝업
	$(document).on('click','.user',function(){
	    var toUserId = $(this).data('id');
	   // console.log('toUserId',toUserId);
	    openProfile(toUserId);
	});
	
	
	// 운동프로필 레이어 팝업 열기
	function openProfile(toUserId){
		var modal = document.getElementById("profilePopup");
	    var PopupBody = document.getElementById("PopupBody");
		
	    // AJAX 요청
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "/mate/"+toUserId, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            PopupBody.innerHTML = xhr.responseText; // 응답을 모달에 넣기
	            modal.style.display = "block"; // 모달 열기
	            
	         	// JS 파일을 동적으로 로드
	            var script = document.createElement('script');
	            script.src = '/resources/js/profileDetail.js'; 
	            document.body.appendChild(script);
	        }
	    };
	    xhr.send();
	}
	
	// 팝업 닫기
	document.getElementsByClassName("close")[0].onclick = function() {
	    document.getElementById("profilePopup").style.display = "none";
	};	
	
</script>

</html>