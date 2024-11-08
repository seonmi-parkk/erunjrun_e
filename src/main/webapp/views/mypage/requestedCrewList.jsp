<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>크루 리스트</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>

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
    align-items: flex-start; /* 아이템을 위쪽으로 정렬 */
	padding: 10px;	
	background-color: white;
	transition: background-color 0.3s;
	cursor: pointer;
	height: 120px;
	width: 590px;
    margin-bottom: 10px; /* 카드 간의 간격 */
}

.crew-image {
    width: 115px; /* 이미지 너비 조정 */
    height: 115px; /* 이미지 높이 조정 */
    margin-right: 20px; /* 이미지와 텍스트 간의 간격 */
    margin-top: 0px;
   	margin-bottom: 10px;
    
}

.crew-details {
    margin-left: 150px; /* 왼쪽 여백 추가 (기본으로 시작하도록) */
    margin-top: -116px;
    
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

.crew-list {
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

.crew-options {
	display: flex;
	justify-content: flex-start;
	margin-bottom: 50px;
}

.crew-options .title3 {
	margin-right: 5px;
	cursor: pointer;
	color: black;
	text-decoration: underline;
	margin-left: 0;
}

.crew-options .title3:hover {
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

.crew-details p {
    font-size: 15px;
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
			<p class="title3 ${pageName == 'profileDetail' ? 'active' : ''}" onclick="location.href='profileDetail'">회원정보</p>
			<p class="title3 ${pageName == 'createExerciseProfile' || pageName == 'ExerciseProfile' ? 'active' : ''}" onclick="location.href='createExerciseProfile'">운동프로필</p>
			<p class="title3 ${pageName == 'pointHistoryListView' ? 'active' : ''}" onclick="location.href='pointHistoryListView'">포인트 내역</p>
			<p class="title3 ${pageName == 'memberCrewListView' ? 'active' : ''}" onclick="location.href='memberCrewListView'">크루 리스트</p>
			<p class="title3 ${pageName == 'myMateListView' ? 'active' : ''}" onclick="location.href='myMateListView'">내 운동 메이트</p>
			<p class="title3 ${pageName == 'likedMemberListView' ? 'active' : ''}" onclick="location.href='likedMemberListView'">내 관심/차단 회원</p>
			<p class="title3 ${pageName == 'messageListView' ? 'active' : ''}" onclick="location.href='messageListView'">쪽지</p>
			<p class="title3 ${pageName == 'myIconListView' ? 'active' : ''}" onclick="location.href='myIconListView'">아이콘</p>
			<p class="title3 ${pageName == 'myBoardListView' ? 'active' : ''}" onclick="location.href='myBoardListView'">내 게시글/댓글</p>
			<p class="title3 ${pageName == 'likedBoardListView' ? 'active' : ''}" onclick="location.href='likedBoardListView'">좋아요 게시글</p>
		</aside>
		<div class="divider"></div>	
		<div class="container">
			<h3>크루 리스트</h3>
			<div class="crew-options">
				<p class="title3" onclick="location.href='memberCrewListView'">(소속 크루)</p>
				<p class="title3 ${pageName == 'memberCrewListView' ? 'active' : ''}" onclick="location.href='requestedCrewListView'">(신청 크루)</p>
				<p class="title3" onclick="location.href='likedCrewListView'">(좋아요 크루)</p>
				</div>
				<div class="crew-list">
					<!-- 리스트가 여기에 동적으로 추가됩니다. -->
				</div>
					<div class="no-crew-message"
				style="display: none; text-align: center; margin-top: 150px;">
				신청한 크루가 없습니다.</div>
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
$(document).ready(function() {
    loadCrewList(1); // 첫 페이지 로드

    // 크루 리스트를 불러오는 AJAX 호출
    function loadCrewList(page) {
    $.ajax({
        type: 'GET',
        url: 'requestedCrewList.ajax',
        data: { page: page, cnt: 4 },
        dataType: 'JSON',
        success: function(data) {
            console.log("AJAX 요청 성공:", data);
            if (data.error) {
                alert(data.error);
            } else {
                $('.crew-list').empty(); // 기존 리스트 초기화
                $('.no-crew-message').hide(); // 초기에는 메시지 숨김
                if (data.list.length === 0) {
                    $('.no-crew-message').show(); // 데이터가 없을 경우 메시지 표시
                    $('.pagination-container').hide(); // 초기에는 메시지 숨김
                } else {
                    $.each(data.list, function(index, crew) {
                        // 크루 카드 HTML 구조 수정
							var crewCard = '<div class="card" onclick="location.href=\'/crewDetail/' + crew.crew_idx + '\'">' + // 상세 페이지로 이동
                            '<img src="' + (crew.crew_image || '/resources/img/crew/crewImg300.png') + '" class="crew-image" alt="크루 이미지" />' + // 크루 이미지 추가
                            '<div class="crew-details">' +
                            '<p class="title2">' + (crew.crew_name || '크루 이름 없음') + '</p>' +
                            '<p>총 인원: ' + (crew.member || '정보 없음') + '명</p>' +
                            '<p>가입 인원: ' + (crew.current_member || '정보 없음') + '명</p>' +
                            '<p>요일: ' + (crew.days || '정보 없음') + '</p>' +
                            '<p>주소: ' + (crew.address || '정보 없음') + '</p>' +
                            '</div>' +
                            '</div>';
                        $('.crew-list').append(crewCard);
                    });
                    setupPagination(data.totalpages, page); // 수정된 변수명 사용
                }
            }
        },
        error: function(e) {
            console.error('크루 리스트를 불러오는 중 오류 발생:', e);
        }
    });
}
    // 페이지네이션 설정
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
                loadCrewList(page); // 선택한 페이지의 크루 리스트 로드
            }
        });
    }
});
</script>
</html>
