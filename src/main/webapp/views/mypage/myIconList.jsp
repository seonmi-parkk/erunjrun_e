<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>보유 아이콘 리스트</title>
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

.icon-list {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
	gap: 15px;
	margin-top: 20px;
	min-height: 200px;
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
	height: 200px;
	width: 170px;
}

.card:hover {
	background-color: #f1f1f1;
}

.icon-image {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	margin-bottom: 30px;
	z-index: 2;  /* 다른 이미지보다 위에 위치하도록 설정 */
}

.icon-name {
	font-size: 16px;
	color: #555;
	margin-top: -15px;
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

.profile-img2 {
	width: 71px;        /* 크기 조정 (너비) */
    height: 71px;       /* 크기 조정 (높이) */
    position: absolute; /* 절대 위치 지정 */
    top: 24px;         /* 위로 올리기 (위쪽에서 20px 만큼 올림) */
    right: 48px;        /* 오른쪽으로 10px 이동 */
    border-radius: 50%; /* 둥근 이미지 */
	z-index: 1;  /* 다른 이미지보다 위에 위치하도록 설정 */
	
}

.divider {
	width: 2px;
	background-color: #ccc;
	margin: 10px 0;
}

.mate-options {
	display: flex;
	justify-content: flex-start;
	margin-bottom: 50px;
}

.mate-options .title3 {
	margin-right: 5px;
	cursor: pointer;
	color: black;
	text-decoration: underline;
	margin-left: 0;
}

.mate-options .title3:hover {
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

.action-buttons {
    display: flex;
    justify-content: center; /* 버튼을 오른쪽으로 정렬 */
    margin-top: 10px; /* 버튼과 카드 간의 간격 추가 */
}

.action-buttons button {
    margin: 0 5px; /* 좌우로 5px 간격 추가 */
}

#updateIconBtn {
    background-color: white; /* 주황색 배경 */
    color: #FFA500; /* 텍스트 색상은 흰색 */
    border: 2px solid #FFA500; /* 테두리 색상도 주황색 */
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px; /* 둥근 모서리 */
}

.icon-list .card[data-id="null"] .icon-image {
    width: 75px;  /* 기본 아이콘만 60px로 설정 */
    height: 75px; /* 기본 아이콘만 60px로 설정 */
    margin-top:15px;
}

.icon-list .card[data-id="null"] .icon-name {
    margin-top:-4px;
}

.icon-list .card[data-id="null"] input[type="radio"] {
    margin-top: 10px;  /* 기본 아이콘만 margin-top 추가 */
}

.icon-list .card input[type="radio"] {
    margin-top: 10px;  /* 원하는 값을 넣으세요 (예: 10px) */
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
			<h3>내 아이콘 리스트</h3>
			<div class="icon-list">
				<!-- 아이콘 리스트는 AJAX로 동적으로 추가됩니다 -->
			</div>
			<div class="no-icon-message"
				style="display: none; text-align: center; margin-top: -35px;">
				구매한 아이콘이 없습니다.</div>
				<div class="action-buttons">
                <button id="updateIconBtn" class="btn btn-primary" disabled>수정하기</button>
            </div>
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
    loadIconList(1); // 첫 페이지 로드

    function loadIconList(page) {
        $.ajax({
            type: 'GET',
            url: 'myIconList.ajax',
            data: { page: page, cnt: 8 },
            dataType: 'JSON',
            success: function(data) {
                console.log("AJAX 요청 성공:", data);
                if (data.error) {
                    alert(data.error);
                } else {
                    $('.icon-list').empty(); // 기존 리스트 초기화
                    $('.no-icon-message').hide(); // 초기에는 메시지 숨김
                    $('#updateIconBtn').prop('disabled', true); // 수정 버튼 비활성화

                    if (data.list.length === 0) {
                        $('.no-icon-message').show(); // 데이터가 없을 경우 메시지 표시
                        $('#updateIconBtn').hide(); // 수정하기 버튼 숨김
                    } else {
                        // 기본 이미지 카드 추가
                        var defaultCard = '<div class="card default-icon-card" data-id="null">' +
                            '<img class="icon-image" src="resources/img/common/profile.png" alt="기본 이미지" />' +
                            '<p class="icon-name">기본 이미지</p>' +
                            '<input type="radio" name="icon-radio" class="icon-radio" data-id="null" />' +
                            '</div>';
                        $('.icon-list').append(defaultCard); // 기본 카드 추가
                        
                        var selectedIconId = data.selectedIcon;  // 서버에서 보내준 selectedIcon (이미지 파일명) 받아옴
                        
                        $.each(data.list, function(index, icon) {
                            var imageSrc = (icon.image && icon.image.trim()) ? '/resources/img/icon/' + icon.image : '/resources/img/icon/default.png';
                            var profileImageSrc = '/resources/img/common/profile.png'; // 기본 프로필 이미지
                            
                            // 선택된 아이콘인지 확인하고 checked 속성 추가
                            var isChecked = (icon.image === selectedIconId); // icon.image와 selectedIconId를 비교 (파일명 비교)
                            var checkedAttribute = isChecked ? 'checked' : ''; // 아이콘이 선택되었으면 checked 추가

                            console.log("아이콘 이미지: ", icon.image);
                            console.log("선택된 아이콘 이미지: ", selectedIconId);
                            

                            var iconCard = '<div class="card" data-id="' + icon.icon_idx + '">' +
                                '<img class="icon-image" src="' + imageSrc + '" alt="아이콘 이미지" />' +
                                '<img class="profile-img2" src="' + profileImageSrc + '" alt="기본 프로필 이미지" />' +
                                '<p class="icon-name">' + (icon.icon_name || '이름 없음') + '</p>' +
                                '<input type="radio" name="icon-radio" class="icon-radio" data-id="' + icon.icon_idx + '" ' + checkedAttribute + ' />' +
                                '</div>';
                            $('.icon-list').append(iconCard);
                        });
                        $('.no-icon-message').hide(); // 데이터가 있을 경우 메시지 숨김
                        setupPagination(data.totalCount, page); // 페이지네이션 생성
                        $('.pagination-container').show(); // 데이터가 있을 경우 페이지네이션 표시

                        // 수정 버튼을 활성화 (아이콘이 있을 경우)
                        $('#updateIconBtn').prop('disabled', false);
                        $('#updateIconBtn').show(); // 버튼이 활성화되면 보이도록 설정
                    }
                }
            },
            error: function(e) {
                console.error('아이콘 리스트를 불러오는 중 오류 발생:', e);
            }
        });
    }

    function setupPagination(totalCount, currentPage) {
        var totalPages = Math.ceil(totalCount / 8);
        if (totalPages === 0) {
            totalPages = 1;
        }

        $('#pagination').twbsPagination({
            totalPages: totalPages,
            startPage: currentPage,
            visiblePages: 5,
            onPageClick: function(evt, page) {
                loadIconList(page); // 선택한 페이지의 아이콘 리스트 로드
            }
        });
    }

    // 라디오 버튼 변경 시 수정 버튼 활성화/비활성화
    $(document).on('change', '.icon-radio', function() {
        var selectedId = $('.icon-radio:checked').data('id'); // 선택된 라디오 버튼의 data-id를 가져옴
        
        // 기본 아이콘을 선택한 경우 수정 버튼을 비활성화하지 않음
        var isDefaultIcon = selectedId === 'null'; // 기본 아이콘이 선택되었으면 true
        $('#updateIconBtn').prop('disabled', false); // 기본 아이콘도 수정 가능하게끔 처리
    });

    // 수정하기 버튼 클릭 시
    $('#updateIconBtn').click(function() {
        var selectedIcon = $('.icon-radio:checked').data('id'); // 선택된 아이콘의 ID를 가져옵니다.

        // 선택된 아이콘이 기본 아이콘 (null)인 경우
        if (selectedIcon === 'null') {
            $.ajax({
                type: 'POST',
                url: 'iconImageUpdate.ajax',  // 기본 아이콘으로 업데이트 요청
                data: { iconId: null },  // null 값을 서버로 전송
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert('기본 아이콘으로 변경되었습니다.');
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert('기본 아이콘으로 변경하는 데 실패했습니다.');
                    }
                },
                error: function(error) {
                    console.error('아이콘 변경 실패:', error);
                }
            });
        } else {
            // 실제 아이콘을 선택한 경우 (기존대로 아이콘을 변경)
            $.ajax({
                type: 'POST',
                url: 'iconImageUpdate.ajax',
                data: { iconId: selectedIcon }, // 선택된 아이콘 ID로 요청
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert('아이콘 이미지가 변경되었습니다.');
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert('아이콘 이미지 변경 실패');
                        console.log('Error response:', response);  // 응답 내용 확인
                    }
                },
                error: function(error) {
                    console.error('아이콘 변경 실패:', error);
                    console.log('Error response:', error);  // 응답 내용 확인
                }
            });
        }
    });
});


</script>
</html>  