<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>관심/차단 리스트</title>
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
    align-items: center;
    padding: 10px;
    border: 1px solid #ddd;
    background-color: white;
    transition: background-color 0.3s;
    cursor: pointer;
    height: 85px;
    width: 750px;
    margin-bottom: 10px;
    position: relative;
}

.card::after {
    content: ''; 
    display: block;
    height: 1px; 
    background-color: #ddd; 
    position: absolute;
    bottom: 0; 
    left: 0;
    right: 0; 
}

.chat-list {
    padding: 0; 
    margin: 0; 
}

.no-liked-message {
    display: none; 
    text-align: center;
    margin-top: 20px; 
}

.card:hover {
    background-color: #f1f1f1;
}

.friend-image {
    width: 65px;
    height: 65px;
    border-radius: 50%;
    margin-bottom: -45px;
    margin-right: 540px;
}

.friend-name {
    font-size: 16px;
    color: #555;
}

.friend-details {
    display: flex;
    margin-left: 60px; /* 텍스트와 이미지 사이의 여백 */
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

.liked-options {
    display: flex;
    justify-content: flex-start;
    margin-bottom: 50px;
}

.liked-options .title3 {
    margin-right: 5px;
    cursor: pointer;
    color: black;
    text-decoration: underline;
    margin-left: 0;
}

.liked-options .title3:hover {
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

.liked-list {
    display: flex;
    flex-direction: column; /* 수직 정렬 */
    align-items: center; /* 가운데 정렬 */
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
            <h3>관심/차단 멤버</h3>
            <div class="liked-options">
                <p class="title3" onclick="location.href='likedMemberListView'">(관심 멤버)</p>
                <p class="title3 ${pageName == 'likedMemberListView' ? 'active' : ''}" onclick="location.href='blockMemberListView'">(차단 멤버)</p>
            </div>
            <div class="liked-list">
                <!-- 리스트가 여기에 동적으로 추가됩니다. -->
            </div>
            <div class="no-liked-message" style="display: none; margin-top:100px;">
                차단한 회원이 없습니다.
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
    loadLikedMemberList(1); // 첫 페이지 로드

    // 관심 회원 리스트를 불러오는 AJAX 호출
    function loadLikedMemberList(page) {
        $.ajax({
            type: 'GET',
            url: 'blockMemberList.ajax', // 실제 요청할 URL로 변경하세요
            data: { page: page, cnt: 8 },
            dataType: 'JSON',
            success: function(data) {
                console.log("AJAX 요청 성공:", data);
                if (data.error) {
                    alert(data.error);
                } else {
                    $('.liked-list').empty(); // 기존 리스트 초기화
                    $('.no-liked-message').hide(); // 초기에는 메시지 숨김
                    if (data.list.length === 0) {
                        $('.no-liked-message').show(); // 데이터가 없을 경우 메시지 표시
                    } else {
                        $.each(data.list, function(index, member) {
                            const birthDate = new Date(member.birth);
                            const age = new Date().getFullYear() - birthDate.getFullYear();
                            // 생일이 지나지 않았다면 나이 하나 감소
                            const currentMonth = new Date().getMonth() + 1; // 0부터 시작하므로 +1
                            const currentDay = new Date().getDate();
                            if (currentMonth < (birthDate.getMonth() + 1) || 
                                (currentMonth === (birthDate.getMonth() + 1) && currentDay < birthDate.getDate())) {
                                age--;
                            }
                            // 연령대 그룹 계산
                            let ageGroup;
                            if (age < 20) {
                                ageGroup = "10대";
                            } else if (age < 25) {
                                ageGroup = "20~25대";
                            } else if (age < 30) {
                                ageGroup = "26~30대";
                            } else if (age < 35) {
                                ageGroup = "31~35대";
                            } else if (age < 40) {
                                ageGroup = "36~40대";
                            } else {
                                ageGroup = "41대 이상";
                            }

                            var memberCard = 
                                '<div class="card" data-id="' + member.id + '">' +
                                    '<img src="/photo/ + profile.image" alt="' + member.nickname + ' 이미지" class="friend-image" />' +
                                    '<div class="friend-details">' +
                                        '<p class="friend-name">' + member.nickname + '</p>' +
                                        '<p class="friend-info"> | 연령대: ' + ageGroup + ' | 주소: ' + member.address + ' | 성별: ' + member.gender + '</p>' + // 성별과 주소 위치 변경
                                    '</div>' +
                                '</div>';
                            $('.liked-list').append(memberCard);
                        });
                        $('.no-liked-message').hide(); // 데이터가 있을 경우 메시지 숨김
                        setupPagination(data.totalCount, page); // 페이지네이션 설정
                        $('.pagination-container').show(); // 데이터가 있을 때 페이지네이션 표시           
                    }
                }
            },
            error: function(e) {
                console.error('관심 회원 리스트를 불러오는 중 오류 발생:', e);
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
                loadLikedMemberList(page); // 선택한 페이지의 크루 리스트 로드
            }
        });
    }
});

</script>
</html>
