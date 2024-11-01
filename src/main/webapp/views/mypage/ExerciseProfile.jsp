<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>운동프로필</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d&libraries=services&autoload=false"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f0f0f0; /* 회색 배경 */
}

aside {
	width: 250px; /* 사이드바 너비 조정 */
	padding: 20px;
	background: #fff; /* 필요에 따라 배경색 추가 */
	border-top-left-radius: 8px; /* 왼쪽 위 모서리 둥글게 */
	border-bottom-left-radius: 8px; /* 왼쪽 아래 모서리 둥글게 */
}

.main-container {
	display: flex; /* 사이드바와 컨테이너를 가로로 배치 */
	width: 80%; /* 전체 너비의 80%로 조정 */
	max-width: 1100px; /* 최대 너비 설정 */
	margin: 120px auto; /* 상하 여백 추가, 중앙 정렬 */
}

.container {
	flex: 1; /* 남은 공간을 차지 */
	padding: 20px; /* 여백 추가 */
	background: white; /* 흰색 배경 */
	border-top-right-radius: 8px; /* 오른쪽 위 모서리 둥글게 */
	border-bottom-right-radius: 8px; /* 오른쪽 아래 모서리 둥글게 */
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

.form-group {
	margin-bottom: -16px;
	padding: 10px;
	border-radius: 8px; /* 모서리 둥글게 */
}

h3 {
	text-align: left;
	margin-bottom: 20px;
	color: dark; /* 주황색 */
	font-size: 40px;
}

label {
	display: inline-block;
	margin-bottom: -5px;
	color: #555;
	background-color: #f9f9f9;
	padding: 4px 10px;
	border-radius: 4px;
	font-size: 14px;
}

.radio-group label {
	border: none; /* 테두리 제거 */
	padding: 4px 10px; /* 패딩 추가 (필요시 조정) */
	display: inline-block; /* 인라인 블록으로 설정 */
	color: #555; /* 글자 색상 */
	background-color: white; /* 배경색 설정 */
	border-radius: 4px; /* 모서리 둥글게 */
}

.div, .div * {
	box-sizing: border-box;
}

input[type="text"], input[type="nickname"], input[type="email"], input[type="number"],
	input[type="password"] {
	width: calc(60% - 20px);
	padding: 10px;
	border: 1px solid #ccc; /* 테두리 제거 */
	border-radius: 4px; /* 모서리 둥글게 */
	background-color: white; /* 흰색 배경 */
	display: block;
	margin-top: 7px; /* 위쪽 여백 추가 */
	border: none; /* 테두리 없애기 */
}

input#ageGroup[readonly] {
	background-color: transparent; /* 투명 배경 */
	border: none; /* 테두리 없애기 */
}

button {
	width: 15%;
	padding: 10px;
	background-color: #ff7f50; /* 주황색 */
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 8px;
	margin-left: 10px;
}

button:hover {
	background-color: #ff6347; /* 버튼 hover 색상 */
}

.check-button {
	padding: 10px; /* 위아래 패딩을 줄이고 좌우 패딩도 조금 줄임 */
	background-color: #ff7f50;
	/* 주황색 */
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-left: 10px;
	background-color: #ff7f50; /* 입력 필드와 버튼 간 간격 */
}

.check-button:hover {
	background-color: #ff6347; /* hover 색상 */
}

.submit-group {
	flex: 1; /* 남은 공간을 차지 */
}

.profile-image {
	max-width: 100px; /* 원하는 최대 너비 */
	max-height: 100px; /* 원하는 최대 높이 */
	border-radius: 4px; /* 모서리 둥글게 */
}

.profile-img1 {
	max-width: 100px; /* 원하는 최대 너비 */
	max-height: 100px; /* 원하는 최대 높이 */
	border-radius: 4px; /* 모서리 둥글게 */
	margin-left: -60px;
}

.image-info {
	display: flex; /* 수평 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
	gap: 15px; /* 이미지와 정보 간의 간격을 조정 */
	margin-top: 40px; /* h3와의 간격을 조정 (20px으로 설정) */
}

.info {
	display: flex;
	flex-direction: column; /* 텍스트 세로 정렬 */
	align-items: center; /* 가운데 정렬 */
	text-align: center; /* 텍스트 가운데 정렬 */
}

.divider {
	width: 2px; /* 선의 두께 */
	background-color: #ccc; /* 선의 색상 */
	margin: 10px 0; /* 위아래 여백 */
}

.horizontal-divider {
	height: 2px; /* 선의 두께 */
	background-color: #ccc; /* 선의 색상 */
	margin: 10px 0; /* 위아래 여백 */
}

#map {
	margin-top: 20px;
	border: 1px solid #ddd;
	border-radius: 4px;
	height: 300px;
}

.edit-icon {
	position: relative;
	bottom: -30px; /* 하단에서 5px */
	right: 120px; /* 오른쪽에서 5px */
	width: 30px;
	height: 30px;
	background-color: #ff7f50;
	color: white;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 16px;
	cursor: pointer;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	transition: background-color 0.3s;
}

.edit-icon:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <div class="main-container">
        <aside>
            <div class="image">
                <img class="profile-img1" src="resources/img/common/profile.png" alt="프로필 이미지" />
            </div>
            <p class="username" id="name">사용자</p>
            <p class="title3" onclick="location.href='profileDetail'">회원정보</p>
            <p class="title3" onclick="location.href='createExerciseProfile'">운동프로필</p>
            <p class="title3" onclick="location.href='pointHistoryList'">포인트 내역</p>
            <p class="title3" onclick="location.href='memberCrewList'">크루 리스트</p>
            <p class="title3" onclick="location.href='myMateList'">내 운동 메이트</p>
            <p class="title3" onclick="location.href='likedMemberList'">내 관심/차단 회원</p>
            <p class="title3" onclick="location.href='messageList'">쪽지</p>
            <p class="title3" onclick="location.href='myIconList'">아이콘</p>
            <p class="title3" onclick="location.href='myboardList'">내 게시글/댓글</p>
            <p class="title3" onclick="location.href='likedBoardList'">좋아요 게시글</p>
        </aside>
        <div class="divider"></div>
        <div class="container">
            <h3>운동 프로필</h3>
            <form id="profileCreate" action="firstExerciseProfile" method="get" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${member.id}" />
                <div class="image-info">
                    <c:choose>
                        <c:when test="${not empty profile.image}">
                            <img class="profile-image" src="/photo/${profile.image}" alt="회원 이미지" id="previewImage" />
                        </c:when>
                        <c:otherwise>
                            <img class="profile-image" src="resources/img/common/profile.png" alt="기본 프로필 이미지" id="previewImage" />
                        </c:otherwise>
                    </c:choose>
                    <div class="info">
                        <p class="title2" id="name">${member.nickname}</p>
                    </div>
                </div>
                <div class="horizontal-divider"></div>
                <hr class="divider">

                <div class="form-group">
                    <label>성별</label>
                    <input type="text" name="gender" id="gender" readonly />
                </div>
                <div class="form-group">
                    <label>연령대</label>
                    <input type="text" id="ageGroup" readonly />
                </div>
                <div class="form-group">
                    <label for="exercise">운동 시간 (분) / 운동 거리 (km)</label>
                    <div style="display: flex; align-items: center;">
                        <input type="number" name="exercise_min" id="exercise_min" placeholder="분" style="width: 10%; margin-right: 5px;" value="${mypage.exercise_min}" readonly />
                        <span>분</span>
                        <input type="number" name="exercise_dis" id="exercise_dis" placeholder="km" style="width: 10%; margin-left: 5px;" value="${mypage.exercise_dis}" readonly />
                        <span>km</span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="exercise">나의 성향</label>
                    <input type="text" name="exercise" id="exercise" style="width: 100%; height: 100px;" value="${mypage.exercise}" readonly />
                </div>
                <div class="form-group">
                    <label for="mate">원하는 메이트 성향</label>
                    <input type="text" name="mate" id="mate" style="width: 100%; height: 100px;" value="${mypage.mate}" readonly />
                </div>
                <div class="form-group">
                    <label for="content">소개글</label>
                    <input type="text" name="content" id="content" style="width: 100%; height: 100px;" value="${mypage.content}" readonly />
                </div>
                 <div class="form-group">
                    <button type="button" class="check-button" onclick="location.href='ExerciseProfileUpdateView'">수정하기</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="../footer.jsp" />

    <script>
    $(document).ready(function() {
        var birthString = "${birthString}"; // JSP에서 JavaScript로 변수 전달
        console.log("생년월일:", birthString); // 값 확인

        // 나이 계산 로직
        if (birthString.length === 8 && !isNaN(birthString)) {
            const birthYear = parseInt(birthString.substring(0, 4), 10);
            const birthMonth = parseInt(birthString.substring(4, 6), 10);
            const birthDay = parseInt(birthString.substring(6, 8), 10);

            const currentDate = new Date();
            const currentYear = currentDate.getFullYear();
            const currentMonth = currentDate.getMonth() + 1; // 0부터 시작하므로 +1
            const currentDay = currentDate.getDate();

            let age = currentYear - birthYear;

            // 생일이 지나지 않았다면 나이 하나 감소
            if (currentMonth < birthMonth || (currentMonth === birthMonth && currentDay < birthDay)) {
                age--;
            }

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

            $('#ageGroup').val(ageGroup);
        } else {
            $('#ageGroup').val("정보 없음");
        }

        // 성별 정보 설정 (예: '남성', '여성' 등)
        var genderValue = "${member.gender}"; // JSP에서 성별 정보 가져오기
        $('#gender').val(genderValue ? genderValue : "정보 없음");
    });
    </script>
</body>
</html>
