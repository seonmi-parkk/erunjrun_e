<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>운동 메이트 리스트</title>
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

#profilePopup {
	width: fit-content;
	top: -10px;
	left: 50%;
	transform: translateX(-50%);
	z-index: 996;
}

.btn-danger {
background-color: #d3d3d3; /* 연한 회색 */
    color: #333; /* 어두운 텍스트 */
    border: none;
    padding: 5px 15px;
    border-radius: 5px;
    font-size: 13px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
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
			<h3>내 운동 메이트 리스트</h3>
			<div class="mate-options">
				<p class="title3 ${pageName == 'myMateListView' ? 'active' : ''}"
					onclick="location.href='myMateListView'">(내 운동 메이트)</p>
				<p class="title3" onclick="location.href='requestedMateListView'">(신청받은
					메이트)</p>
				<p class="title3" onclick="location.href='requestingMateListView'">(신청한
					메이트)</p>
			</div>
			<div class="friend-list">
                <c:forEach var="friend" items="${friendList}">
                    <div class="card" data-id="${friend.id}" onclick="openProfile('${friend.id}')">
                        <img class="friend-image"
                             src="${friend.image != null && !friend.image.trim().isEmpty() ? '/photo/' + friend.image : 'resources/img/common/profile.png'}"
                             alt="친구 이미지" />
                        <p class="friend-name user">
                            <c:choose>
                                <c:when test="${sessionScope.loginId == friend.id}">
                                    <!-- 사용자의 ID가 friend.id인 경우 (자기 자신) -->
                                    ${friend.unlike_id} <!-- 상대방의 ID 출력 -->
                                </c:when>
                                <c:otherwise>
                                    <!-- 사용자의 ID가 friend.unlike_id인 경우 -->
                                    ${friend.id} <!-- 상대방의 ID 출력 -->
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </c:forEach>
            </div>
            <div class="no-friends-message" style="display: none; text-align: center; margin-top: -100px;">
                메이트가 없어요 ㅜ_ㅜ.
            </div>
            <div class="pagination-container">
                <nav aria-label="Page navigation">
                    <ul class="pagination" id="pagination"></ul>
                </nav>
            </div>
        </div>
    </div>
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
                url: 'myMateList.ajax',
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
                                var imageSrc = (friend.friend_image && friend.friend_image.trim()) ? '/photo/' + friend.friend_image : 'resources/img/common/profile.png';
                                console.log("friend.image: ", friend.friend_image); // friend.image 값 확인
                                console.log("imageSrc: ", imageSrc); // 최종 imageSrc 값 확인
                                var currentUserId = '${sessionScope.loginId}'; // JSP에서 세션 변수 가져오기
                                var friendName;

                                if (currentUserId === friend.id) {
                                    friendName = friend.unlike_id; // 상대방의 ID
                                } else {
                                    friendName = friend.id; // 상대방의 ID
                                }

                                var friendCard = '<div class="card" data-id="' + friend.id + '">' +
                                    '<input type="hidden" name="toUserId" value="' + friend.id + '" />' +
                                    '<img class="friend-image" src="' + imageSrc + '" alt="친구 이미지" />' +
                                    '<p class="friend-name user">' + (friendName ? friendName : '이름 없음') + '</p>' +
                                    '<button class="btn btn-danger unfriend-btn" data-id="' + friend.mate_idx + '">메이트 끊기</button>' +
                                '</div>';
								
                                $('.friend-list').append(friendCard);
                            });
                            $('.no-friends-message').hide(); // 데이터가 있을 경우 메시지 숨김
                            // 페이지네이션 생성
                            setupPagination(data.totalCount, page);
                            $('.pagination-container').show(); // 데이터가 있을 때 페이지네이션 표시           
                        }
                    }
                },
                error: function(e) {
                    console.error('친구 리스트를 불러오는 중 오류 발생:', e);
                }
            });
        }
        
        $(document).on('click', '.unfriend-btn', function() {
            var mateIdx = $(this).closest('.card').data('id');  // .card의 data-id 속성에 mate_idx 값 저장됨
            
            $.ajax({
                type: 'GET',
                url: 'myMateDelete.ajax',
                data: { mateIdx: mateIdx },
                success: function(response) {
                    if (response.success) {
                        alert("메이트 관계가 끊어졌습니다.");
                        location.reload();  // 페이지를 새로고침하여 목록을 갱신
                    } else {
                        alert(response.message || "메이트 끊기 실패");
                    }
                },
                error: function(error) {
                    console.error('메이트 관계 끊기 중 오류 발생:', error);
                }
            });
        });

        // 페이지네이션 설정
        function setupPagination(totalCount, currentPage) {
            var totalPages = Math.ceil(totalCount / 8); // 페이지 수 계산
            if (totalPages === 0) {
                totalPages = 1; // 기본적으로 1페이지 설정
            }

            $('#pagination').twbsPagination({
                totalPages: totalPages,
                startPage: currentPage,
                visiblePages: 5,
                onPageClick: function(evt, page) {
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

                    // JS 파일을 동적으로 로드
                    var script = document.createElement('script');
                    script.src = '/resources/js/profileDetail.js'; // 프로필 디테일 JS 파일 로드
                    document.body.appendChild(script);
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
