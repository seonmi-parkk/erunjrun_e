<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>신청한 운동메이트 리스트</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"
	type="text/javascript"></script>
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
	/* 카드 높이에 맞춰 컨테이너의 최소 높이를 설정 */
	min-height: 200px; /* 원하는 최소 높이로 조정 */
	overflow-y: auto;
}

.card {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: white;
	transition: background-color 0.3s;
	cursor: pointer;
	height: 200px; /* 원하는 높이로 조정 */
	width: 170px; /* 원하는 너비로 조정 */
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
	color: dark; /* 주황색 */
	font-size: 40px;
}

.image {
	text-align: center; /* 이미지 중앙 정렬 */
}

.title2 {
	font-weight: bold; /* 제목 강조 */
	font-size: 20px;
	margin-left: -6px;
	text-align: left;
}

.title3 {
	cursor: pointer; /* 클릭 가능 표시 */
	color: black; /* 링크 색상 */
	margin: 10px 24; /* 여백 추가 */
	margin-top: 10px;
	position: relative; /* 상대 위치 설정 */
	top: 30px;
}

.username {
	font-weight: bold; /* 사용자 이름을 강조 */
	font-size: 20px; /* 글자 크기 조정 */
	color: #333; /* 글자 색상 */
	margin-left: 25px; /* 기존과 동일한 여백 */
	margin-top: 10px;
}

.title1 {
	font-size: 24px; /* 제목 크기 */
	margin-bottom: 20px; /* 아래 여백 */
}

.profile-img1 {
	max-width: 100px; /* 원하는 최대 너비 */
	max-height: 100px; /* 원하는 최대 높이 */
	border-radius: 4px; /* 모서리 둥글게 */
	margin-left: -60px;
}

.divider {
	width: 2px; /* 선의 두께 */
	background-color: #ccc; /* 선의 색상 */
	margin: 10px 0; /* 위아래 여백 */
}

.mate-options {
	display: flex; /* Flexbox 사용 */
	justify-content: flex-start; /* 왼쪽 정렬 */
	margin-bottom: 50px; /* 카드와의 간격 조정 */
}

.mate-options .title3 {
	margin-right: 5px; /* 항목 간 여백 */
	cursor: pointer; /* 클릭 가능 표시 */
	color: black; /* 링크 색상 */
	text-decoration: underline; /* 밑줄 */
	margin-left: 0; /* 왼쪽 여백을 0으로 설정하여 왼쪽으로 이동 */
}

.mate-options .title3:hover {
	color: #0056b3; /* 호버 시 색상 변경 */
}

.pagination-container {
	text-align: center; /* 페이지네이션 중앙 정렬 */
	margin-top: 20px; /* 위쪽 여백 */
}

.title3.active {
	color: black; /* 활성화된 메뉴 항목의 색상 */
	font-weight: bold; /* 강조 효과 */
	background-color: #f0f0f0; /* 배경 색상 (선택 사항) */
}

#profilePopup {
            width: fit-content;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 996;
        }
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="main-container">
		<aside>
			<div class="image">
				<img class="profile-img1" src="resources/img/common/profile.png"
					alt="프로필 이미지" />
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
			<h3>내 운동 메이트 리스트</h3>
			<div class="mate-options">
				<p class="title3"
					onclick="location.href='myMateListView'">(내 운동 메이트)</p>
				<p class="title3" onclick="location.href='requestedMateListView'">(신청받은
					메이트)</p>
				<p class="title3 ${pageName == 'myMateListView' ? 'active' : ''}" onclick="location.href='requestingMateListView'">(신청한
					메이트)</p>
			</div>
			<div class="friend-list">
				<!-- 친구 리스트는 AJAX로 동적으로 추가됩니다 -->
			</div>
			<div class="no-friends-message"
				style="display: none; text-align: center; margin-top: -100px;">
				신청한 메이트가 없습니다.</div>
			<div class="pagination-container">
				<nav aria-label="Page navigation">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
		</div>
	</div>
	<!-- 모달 구조 -->
	<div id="profilePopup" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<div id="PopupBody">
				<!-- 프로필 내용이 여기에 동적으로 추가됩니다 -->
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
<script>
$(document).ready(function() {
    loadFriendList(1); // 첫 페이지 로드

    // 친구 리스트를 불러오는 AJAX 호출
    function loadFriendList(page) {
        $.ajax({
            type: 'GET',
            url: 'appliedMates.ajax', // AJAX 요청 URL
            data: { page: page, cnt: 8 },
            dataType: 'JSON',
            success: function(data) {
                console.log("AJAX 요청 성공:", data);
                if (data.error) {
                    alert(data.error);
                } else {
                    $('.friend-list').empty(); // 기존 리스트 초기화
                    $('.no-friends-message').hide(); // 초기에는 메시지 숨김
                    if (data.list.length === 0) {
                        $('.no-friends-message').show(); // 데이터가 없을 경우 메시지 표시
                    } else {
                        $.each(data.list, function(index, friend) {
                            var imageSrc = (friend.image && friend.image.trim()) ? '/photo/' + friend.image : 'resources/img/common/profile.png';
                            var friendCard = '<div class="card" data-id="' + friend.id + '">' +
                                '<img class="friend-image" src="' + imageSrc + '" alt="친구 이미지" />' +
                                '<p class="friend-name user">' +
                                (friend.id ? friend.id : '이름 없음') +
                                '</p>' +
                                '<div class="action-buttons">' +
                                '<button class="cancel-btn">신청 취소</button>' +
                                '</div>' +
                                '</div>';
                                
                            $('.friend-list').append(friendCard);
                        });
                        $('.no-friends-message').hide(); // 데이터가 있을 경우 메시지 숨김
                        setupPagination(data.totalCount, page);
                        $('.pagination-container').show(); // 데이터가 있을 때 페이지네이션 표시           

                    }
                    
                        // 신청 취소 버튼 클릭 이벤트
                        $('.cancel-btn').off('click').on('click', function() {
                            var unlikeId = $(this).closest('.card').data('id');
                            $.ajax({
                                type: 'POST',
                                url: 'cancelMateApplication.ajax', // 신청 취소 요청 URL
                                data: {
                                    unlikeId: unlikeId
                                },
                                success: function(response) {
                                    if (response.success) {
                                        alert('신청이 취소되었습니다.');
                                        $('.card[data-id="' + unlikeId + '"]').remove(); // 카드 제거
                                    } else {
                                        alert('취소 중 오류가 발생했습니다.');
                                    }
                                },
                                error: function(e) {
                                    console.error('오류 발생:', e);
                                }
                            });
                        });
                    }
            },
            error: function(e) {
                console.error('친구 리스트를 불러오는 중 오류 발생:', e);
            }
        });
    }

    // 페이지네이션 설정
    function setupPagination(totalCount, currentPage) {
        var totalPages = Math.ceil(totalCount / 8); // 페이지 수 계산

        // totalPages가 0이라도 1페이지 버튼을 표시
        if (totalPages === 0) {
            totalPages = 1; // 기본적으로 1페이지 설정
        }

        $('#pagination').twbsPagination({
            totalPages: totalPages,
            startPage: currentPage,
            visiblePages: 5,
            onPageClick: function(evt, page) {
                loadFriendList(page); // 선택한 페이지의 친구 리스트 로드
            }
        });
    }

 // 친구 이름 클릭 시, 상대방의 프로필을 여는 함수
    $(document).on('click', '.user', function() {
        var toUserId = $(this).closest('.card').data('id'); // data-id로 상대방의 ID 가져오기
        console.log('toUserId:', toUserId);
        openProfile(toUserId); // 클릭한 친구의 프로필 열기
    });

    // 운동프로필 레이어 팝업 열기
    function openProfile(toUserId) {
        var modal = document.getElementById("profilePopup");
        var PopupBody = document.getElementById("PopupBody");

        // AJAX 요청
        $.ajax({
            url: "/mate/" + toUserId, // 상대방 ID에 해당하는 프로필 정보 요청
            method: "GET",
            success: function(response) {
                PopupBody.innerHTML = response; // 응답을 모달에 넣기
                modal.style.display = "block"; // 모달 열기

                // JS 파일을 동적으로 로드 (필요시 추가적인 스크립트 로딩)
                var script = document.createElement('script');
                script.src = '/resources/js/profileDetail.js'; // 프로필 디테일 JS 파일 로드
                document.body.appendChild(script);
            },
            error: function(error) {
                console.error("프로필 정보를 불러오는 중 오류 발생:", error);
                alert("프로필을 불러오는 데 문제가 발생했습니다.");
            }
        });
    }

    // 팝업 닫기
    $(document).on('click', '.close', function() {
        document.getElementById("profilePopup").style.display = "none";
    });


});
	
</script>
</html>
