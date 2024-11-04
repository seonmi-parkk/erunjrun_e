<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>첫 프로필 생성</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d&libraries=services&autoload=false"></script>

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

.title3.active {
    color: #black; /* 활성화된 메뉴 항목의 색상 */
    font-weight: bold; /* 강조 효과 */
    background-color: #f0f0f0; /* 배경 색상 (선택 사항) */
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
			<p class="title3 ${pageName == 'likedMemberListView' ? 'active' : ''}"
				onclick="location.href='likedMemberListView'">내 관심/차단 회원</p>
			<p class="title3 ${pageName == 'messageListView' ? 'active' : ''}"
				onclick="location.href='messageListView'">쪽지</p>
			<p class="title3 ${pageName == 'myIconListView' ? 'active' : ''}"
				onclick="location.href='myIconListView'">아이콘</p>
			<p class="title3 ${pageName == 'myboardListView' ? 'active' : ''}"
				onclick="location.href='myboardListView'">내 게시글/댓글</p>
			<p class="title3 ${pageName == 'likedBoardListView' ? 'active' : ''}"
				onclick="location.href='likedBoardListView'">좋아요 게시글</p>
		</aside>
		<div class="divider"></div>
		<div class="container">
			<h3>운동 프로필 최초 작성</h3>
			<form id="profileCreate" action="firstExerciseProfile" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="id" value="${member.id}" />
				<div class="image-info">
					<c:choose>
						<c:when test="${not empty profile.image}">
							<img class="profile-image" src="/photo/${profile.image}"
								alt="회원 이미지" id="previewImage" />
						</c:when>
						<c:otherwise>
							<img class="profile-image" src="resources/img/common/profile.png"
								alt="기본 프로필 이미지" id="previewImage" />
						</c:otherwise>
					</c:choose>
					<div class="info">
						<p class="title2" id="name">${member.nickname}</p>
					</div>
					<span id="changeImage" class="edit-icon" style="cursor: pointer;">✎</span>
					<input type="file" name="imageFile" id="imageFile"
						style="display: none;" />
				</div>
				<div class="horizontal-divider"></div>
				<hr class="divider">
				<input type="hidden" name="id" value="${sessionScope.loginId}" />
				<div class="form-group">
					<label for="nickname">닉네임</label>
					<div class="input-group">
						<input type="text" name="nickname" id="nickname"
							value="${member.nickname}" required placeholder="예시) 달려달려달려" />
						<button type="button" id="nickNameCheck">중복확인</button>
					</div>
					<span id="nickNameResult" class="result"></span>
				</div>

				<div class="form-group">
					<label>연령대</label> <input type="text" id="ageGroup" readonly />
				</div>
				<div class="form-group">
					<label for="exercise">나의 성향</label> <input type="text"
						name="exercise" id="exercise" style="width: 100%; height: 100px;"
						required />
				</div>
				<div class="form-group">
					<label for="mate">원하는 메이트 성향</label> <input type="text" name="mate"
						id="mate" style="width: 100%; height: 100px;" required />
				</div>
				<div class="form-group">
					<label for="content">소개글</label> <input type="text" name="content"
						id="content" style="width: 100%; height: 100px;" required />
				</div>
				<div class="form-group">
					<label for="exercise">운동 시간 (분) / 운동 거리 (km)</label>
					<div style="display: flex; align-items: center;">
						<input type="number" name="exercise_min" id="exercise_min"
							placeholder="분" style="width: 10%; margin-right: 5px;" required />
						<span>분</span> <input type="number" name="exercise_dis"
							id="exercise_dis" placeholder="km"
							style="width: 10%; margin-left: 5px;" required /> <span>km</span>
					</div>
				</div>
				<div class="form-group">
					<label for="address">운동 지역</label> <input type="text"
						name="detail_address" id="detail_address" readonly />
				</div>
				<div id="map"></div>
				<input type="hidden" name="latitude" id="latitude" /> <input
					type="hidden" name="longitude" id="longitude" /> <input
					type="hidden" name="sido" id="sido" /> <input type="hidden"
					name="dong" id="dong" /> <input type="hidden" name="shortsido"
					id="shortsido" />
				<div class="form-group">
					<label>프로필 공개 여부</label>
					<div class="radio-group">
						<label> <input type="radio"
							name="profileVisibility" value="Y" checked> 공개
						</label> <label> <input type="radio"
							name="profileVisibility" value="N"> 비공개
						</label>
					</div>
				</div>
				<div class="form-group">
					<label>운동 메이트 찾기 여부</label>
					<div class="radio-group">
						<label> <input type="radio"
							name="mateSearch" value="Y" checked> 찾기
						</label> <label> <input type="radio"
							name="mateSearch" value="N"> 찾지 않기
						</label>
					</div>
				</div>
				<div class="submit-group" style="margin-top: 20px;">
					<button type="submit">작성 완료</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />

	<script>
	$('#nickNameCheck').click(
			function() {
				var nickName = $('input[name="nickname"]').val();
				$.ajax({
					type : 'get',
					url : 'nickNameOverlay',
					data : {
						'nickName' : nickName
					},
					dataType : 'JSON',
					success : function(data) {
						if (data.overlay > 0) {
							$('#nickNameResult').html(
									nickName + ' 는 이미 사용중 입니다.').css(
									'color', 'red');
						} else {
							$('#nickNameResult').html(
									nickName + ' 는 사용 가능합니다.').css('color',
									'green');
						}
					},
					error : function(e) {
						console.log(e);
					}
				});
			});
	
	
	// 이미지 미리보기 기능
	document.getElementById('imageFile').addEventListener('change', function(event) {
	    const file = event.target.files[0];
	    if (file) {
	        const reader = new FileReader();
	        reader.onload = function(e) {
	            document.getElementById('previewImage').src = e.target.result;
	        };
	        reader.readAsDataURL(file);
	    }
	});

	// 이미지 변경 아이콘 클릭 시 파일 선택 대화창 열기
	document.getElementById('changeImage').addEventListener('click', function() {
	    document.getElementById('imageFile').click();
	});
	
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
	});
	
        let marker; // 전역 변수로 마커 선언

        kakao.maps.load(() => {
            const container = document.getElementById('map');
            const options = {
                center: new kakao.maps.LatLng(37.5665, 126.978),
                level: 3
            };
            const map = new kakao.maps.Map(container, options);
            
            // 마커 생성
            marker = new kakao.maps.Marker({
                map: map,
                position: new kakao.maps.LatLng(37.5665, 126.978)
            });

            const geocoder = new kakao.maps.services.Geocoder();

            kakao.maps.event.addListener(map, 'click', (mouseEvent) => {
                const lat = mouseEvent.latLng.getLat();
                const lng = mouseEvent.latLng.getLng();

                // 마커 위치 업데이트
                marker.setPosition(new kakao.maps.LatLng(lat, lng));

                // 주소 검색
                geocoder.coord2Address(lng, lat, (result, status) => {
                    if (status === kakao.maps.services.Status.OK) {
                        const addr = result[0].address.address_name;
                        $('#detail_address').val(addr);
                                
                        // latitude, longitude 업데이트
                        $('#latitude').val(lat);
                        $('#longitude').val(lng);

                        // sido와 dong 추출
                        const addressComponents = result[0].address;
                        $('#sido').val(addressComponents.region_1depth_name); // 시도
                        $('#dong').val(addressComponents.region_2depth_name); // 읍면동
                        $('#shortsido').val(addressComponents.region_3depth_name); // 시군구
                    } else {
                        alert('주소를 찾을 수 없습니다.');
                    }
                });
            });
        });

        function editProfile() {
            // 수정 페이지로 이동하는 로직 추가
            window.location.href = 'editProfilePage'; // 수정 페이지 URL로 변경
        }
    </script>
</body>
</html>
