<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>대화방 리스트</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"
	type="text/javascript"></script>
<script type="text/javascript" src="/resources/js/chatting.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f0f0f0;
}

aside {
	width: 250px;
	padding: 20px;
	background: #fff;
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
}

.main-container {
	display: flex;
	width: 80%;
	max-width: 1100px;
	margin: 120px auto;
}

.container {
	flex: 1;
	padding: 20px;
	background: white;
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
}

.friend-list {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
	gap: 15px;
	margin-top: 20px;
	min-height: 200px;
	overflow-y: auto;
}

.card {
	display: flex;
	align-items: center;
	padding: 10px;
	border: none; /* 기존의 border 속성을 제거 */
	background-color: white;
	transition: background-color 0.3s;
	cursor: pointer;
	height: 85px;
	width: 580px;
	margin-bottom: 10px; /* 카드 간의 간격 */
}

.card::after {
	content: ''; /* 가상의 요소 생성 */
	display: block;
	height: 1px; /* 선의 두께 */
	background-color: #ddd; /* 선 색상 */
	position: absolute;
	bottom: 0; /* 카드 하단에 위치 */
	left: 0;
	right: 0; /* 양쪽 끝으로 확장 */
}

.chat-list {
	padding: 0; /* 리스트의 기본 패딩 없애기 */
	margin: 0; /* 리스트의 기본 마진 없애기 */
}

.no-friends-message {
	display: none; /* 메시지 기본값을 숨김 */
	text-align: center;
	margin-top: 20px; /* 적절한 여백 */
}

.card:hover {
	background-color: #f1f1f1;
}

.friend-image {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	margin-bottom: 30px;
}

.friend-name {
	font-size: 16px;
	color: #555;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 600px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

h3 {
	text-align: left;
	margin-bottom: 20px;
	color: dark;
	font-size: 40px;
}

.image {
	text-align: center;
}

.title2 {
	font-weight: bold;
	font-size: 20px;
	margin-left: -6px;
	text-align: left;
}

.title3 {
	cursor: pointer;
	color: black;
	margin: 10px 24;
	margin-top: 10px;
	position: relative;
	top: 30px;
}

.username {
	font-weight: bold;
	font-size: 20px;
	color: #333;
	margin-left: 25px;
	margin-top: 10px;
}

.title1 {
	font-size: 24px;
	margin-bottom: 20px;
}

.profile-img1 {
	max-width: 100px; /* 원하는 최대 너비 */
	max-height: 100px; /* 원하는 최대 높이 */
	border-radius: 4px; /* 모서리 둥글게 */
	margin-left: -60px;
}

.icon-image1 {
	margin-top: -123px;
	margin-left: 2px;
}

.divider {
	width: 2px;
	background-color: #ccc;
	margin: 10px 0;
}

.chat-options {
	display: flex;
	justify-content: flex-start;
	margin-bottom: 50px;
}

.chat-options .title3 {
	margin-right: 5px;
	cursor: pointer;
	color: black;
	text-decoration: underline;
	margin-left: 0;
}

.chat-options .title3:hover {
	color: #0056b3;
}

.pagination-container {
	text-align: center;
	margin-top: 20px;
}

.title3.active {
	color: black;
	font-weight: bold;
	background-color: #f0f0f0;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="main-container">
		<aside>
			<div class="image">
				<!-- 프로필 이미지 -->
				<c:choose>
					<c:when test="${not empty profile.image}">
						<img class="profile-img1" src="/photo/${profile.image}" alt="" />
					</c:when>
					<c:otherwise>
						<img class="profile-img1" src="resources/img/common/profile.png" alt="" />
					</c:otherwise>
				</c:choose>
			</div>
			<div class="icon">
				<!-- 아이콘 이미지 -->
				<c:choose>
					<c:when test="${not empty member.icon_image}">
						<img class="icon-image1" src="/resources/img/icon/${member.icon_image}" alt="" />
					</c:when>
					<c:otherwise>
						<img class="icon-image1" src="resources/img/icon/default-icon.png" alt="" />
					</c:otherwise>
				</c:choose>
			</div>
			<p class="username" id="name">${member.id}</p>
			<p class="title3 ${pageName == 'profileDetail' ? 'active' : ''}"
				onclick="location.href='profileDetail'">회원정보</p>
			<p
				class="title3 ${pageName == 'createExerciseProfile' || pageName == 'ExerciseProfile' ? 'active' : ''}"
				onclick="location.href='createExerciseProfile'">운동프로필</p>
			<p
				class="title3 ${pageName == 'pointHistoryListView' ? 'active' : ''}"
				onclick="location.href='pointHistoryListView'">포인트 내역</p>
			<p class="title3 ${pageName == 'memberCrewListView' ? 'active' : ''}"
				onclick="location.href='memberCrewListView'">크루 리스트</p>
			<p class="title3 ${pageName == 'myMateListView' ? 'active' : ''}"
				onclick="location.href='myMateListView'">내 운동 메이트</p>
			<p
				class="title3 ${pageName == 'likedMemberListView' ? 'active' : ''}"
				onclick="location.href='likedMemberListView'">내 관심/차단 회원</p>
			<p class="title3 ${pageName == 'messageListView' ? 'active' : ''}"
				onclick="location.href='messageListView'">쪽지</p>
			<p class="title3 ${pageName == 'myIconListView' ? 'active' : ''}"
				onclick="location.href='myIconListView'">아이콘</p>
			<p class="title3 ${pageName == 'myBoardListView' ? 'active' : ''}"
				onclick="location.href='myBoardListView'">내 게시글/댓글</p>
			<p class="title3 ${pageName == 'likedBoardListView' ? 'active' : ''}"
				onclick="location.href='likedBoardListView'">좋아요 게시글</p>
		</aside>
		<div class="divider"></div>
		<div class="container">
			<h3>대화방</h3>
			<div class="chat-options">
				<p class="title3" onclick="location.href='messageListView'">(1:1
					대화방)</p>
				<p class="title3 ${pageName == 'messageListView' ? 'active' : ''}"
					onclick="location.href='crewMasterMessageListView'">(그룹장과의 대화방)</p>
			</div>
			<div class="chat-list">
				<!-- 리스트가 여기에 동적으로 추가됩니다. -->
			</div>
			<div class="no-chat-message"
				style="display: none; text-align: center; margin-top: 150px;">
				참여중인 대화방이 없습니다.</div>
			<div class="pagination-container">
				<nav aria-label="Page navigation">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
</body>

<script>
	$(document)
			.ready(
					function() {
						loadChatList(1); // 첫 페이지 로드

						// 대화 리스트를 불러오는 AJAX 호출
						function loadChatList(page) {
    $.ajax({
        type: 'GET',
        url: 'crewMasterMessageList.ajax', // 실제 요청할 URL로 변경하세요
        data: {
            page: page,
            cnt: 8
        },
        dataType: 'JSON',
        success: function(data) {
            console.log("AJAX 요청 성공:", data);
            if (data.error) {
                alert(data.error);
            } else {
                $('.chat-list').empty(); // 기존 리스트 초기화
                $('.no-chat-message').hide(); // 초기에는 메시지 숨김
                if (data.list.length === 0) {
                    $('.no-chat-message').show(); // 데이터가 없을 경우 메시지 표시
                } else {
                    $.each(data.list, function(index, chat) {
                        var formattedDate = new Date(chat.message_date).toLocaleString(); // 날짜 포맷팅
                        if (isNaN(new Date(chat.message_date))) {
                            console.error("Invalid date format for chat.message_date:", chat.message_date);
                            formattedDate = "날짜 형식 오류";
                        }
                        var chatCard = '<div class="card" data-id="' + chat.chat_idx + '" onclick="openLeaderChat(' + chat.chat_idx + ')">'
                        + '<img src="resources/img/common/profile.png" alt="상대방 이미지" class="profile-img" style="width: 50px; height: 50px; border-radius: 50%; margin-right: 480px;"/>'
                        + '<p style="margin: -30px; margin-right: 100px;">' + (chat.other_id || '상대방 이름 없음') + '님과의 대화</p>'
                        + '<p style="margin: 7px; color: #777; margin-right: -330px;">발송일: ' + formattedDate + '</p>'
                        + '</div>';
                        $('.chat-list').append(chatCard);
                    });
                    $('.no-chat-message').hide(); // 데이터가 있을 경우 메시지 숨김
                    // 페이지네이션 설정
                    setupPagination(data.totalCount, page);
                }
            }
        },
        error: function(e) {
            console.error('대화 리스트를 불러오는 중 오류 발생:', e);
        }
    });
}

function setupPagination(totalPages, currentPage) {
    totalPages = parseInt(totalPages, 10) || 0; // NaN일 경우 0으로 처리
    var itemsPerPage = 4; // 페이지당 항목 수를 4로 설정

    // totalPages가 0일 경우 최소 1페이지로 설정
    if (totalPages < 1) {
        totalPages = 1;
    }

    $('#pagination').twbsPagination({
        totalPages: totalPages,
        startPage: currentPage,
        visiblePages: 5,
        onPageClick: function(evt, page) {
            loadChatList(page); // 선택한 페이지의 크루 리스트 로드
        }
    });
}

function openLeaderChat(roomNum){
	 // 새 창의 URL
   var url = '/crewLdchat/open/'+roomNum;
   chatWindowSet(url);
}

function openCrewLeaderChat(){
	$.ajax({
		type:'GET',
		url:'/crewLdchat/'+crew_idx,
		data:{},
		dataType:'JSON',
		success:function(data){
			console.log(data.roomNum);
			openLeaderChat(data.roomNum);
		},
		error:function(e){
			console.log(e);
		}
	});
}


//채팅방 나가기
$('.exit').on('click',function(){
   layerPopup('채팅방을 나가시겠습니까?','나가기','취소',exitBtn1Act,exitBtn2Act);
});

function exitBtn1Act(){
   $.ajax({
      type: 'POST',
      url: '/crewLdchat/exit/'+chatIdx,
      dataType: 'JSON',
      success: function(data){
         console.log(data.success);
         if(data.success){
            window.close();
         }
      },
      error: function(e){
         console.log(e);
      }
   });
   removeAlert();
}

function exitBtn2Act(){
   removeAlert();
} 

					});
</script>
</html>
