<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>첫 프로필 생성</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d&libraries=services&autoload=false"></script>

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 20px;
}

.container {
	background: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	max-width: 600px;
	margin: 0 auto;
}

.profile-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
	text-align: left;
}

.profile-header img {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	object-fit: cover;
	margin-right: 15px;
}

.profile-header h2 {
	margin: 0;
	font-size: 24px;
	color: #333;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	color: #555;
}

input[type="text"], input[type="number"], input[type="file"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
}

input[readonly] {
	background-color: #f9f9f9;
}

#map {
	margin-top: 20px;
	border: 1px solid #ddd;
	border-radius: 4px;
	height: 300px;
}

.submit-group {
	text-align: center;
	margin-top: 20px;
}

button {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

button:hover {
	background-color: #218838;
}

.radio-group {
	display: flex;
}

.radio-group label {
	margin: 0;
}

.divider {
	border: none;
	border-top: 2px solid black;
	margin: 10px 0;
}

.profile-image-container {
	position: relative;
}

.edit-button {
	position: absolute;
	bottom: 5px; /* 하단에서 5px */
	right: 5px; /* 오른쪽에서 5px */
	width: 30px;
	height: 30px;
	background-color: #007bff;
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

.edit-button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<div class="profile-header">
			<div class="profile-image-container">
				<img src="/photo/${sessionScope.profileImage}" alt="회원 이미지">
				<div class="edit-button" onclick="editProfile()">✎</div>
			</div>
			<h2>${sessionScope.loginId}</h2>
		</div>
		<hr class="divider">
		<form id="profileCreate" action="firstExerciseProfile" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="id" value="${sessionScope.loginId}" />
			<div class="form-group">
				<label for="nickname">닉네임</label> <input type="text" name="nickname"
					id="nickname" value="${member.nickname}" readonly />
			</div>
			<div class="form-group">
				<label>연령대</label> <input type="text" id="ageGroup" readonly />
			</div>
			<div class="form-group">
				<label for="exercise">나의 성향</label> <input type="text"
					name="exercise" id="exercise" required />
			</div>
			<div class="form-group">
				<label for="mate">원하는 메이트 성향</label> <input type="text" name="mate"
					id="mate" required />
			</div>
			<div class="form-group">
				<label for="content">소개글</label> <input type="text" name="content"
					id="content" required />
			</div>
			<div class="form-group">
				<label for="exercise">운동 시간 (분) / 운동 거리 (km)</label> <input
					type="number" name="exercise_min" id="exercise_min" placeholder="분"
					required style="width: calc(50% - 10px); margin-right: 10px;" /> <input
					type="number" name="exercise_dis" id="exercise_dis"
					placeholder="km" required style="width: calc(50% - 10px);" />
			</div>
			<div class="form-group">
				<label for="address">운동 지역</label> <input type="text"
					name="detail_address" id="detail_address" readonly />
			</div>
			<div id="map"></div>
			<input type="hidden" name="latitude" id="latitude" /> <input
				type="hidden" name="longitude" id="longitude" /> <input
				type="hidden" name="sido" id="sido" />
			<!-- sido hidden input 추가 -->
			<input type="hidden" name="dong" id="dong" />
			<!-- dong hidden input 추가 -->
			<input type="hidden" name="shortsido" id="shortsido" />
			<!-- shortsido hidden input 추가 -->
			<div class="form-group">
                <label>프로필 공개 여부</label>
                <div class="radio-group">
                    <label><input type="radio" name="profile_use" value="Y" checked> 공개</label>
                    <label><input type="radio" name="profile_use" value="N"> 비공개</label>
                </div>
            </div>
            <div class="form-group">
                <label>운동 메이트 찾기 여부</label>
                <div class="radio-group">
                    <label><input type="radio" name="mateSearch" value="Y" checked> 찾기</label>
                    <label><input type="radio" name="mateSearch" value="N"> 찾지 않기</label>
                </div>
			</div>
			<div class="submit-group">
				<button type="submit">생성 완료</button>
			</div>
		</form>
	</div>

	<script>
	
	$(document)
	.ready(
			function() {
				var birthString = "${birthString}"; // JSP에서 JavaScript로 변수 전달
				console.log("생년월일:", birthString); // 값 확인

				// 나이 계산 로직
				if (birthString.length === 8 && !isNaN(birthString)) {
					const birthYear = parseInt(birthString
							.substring(0, 4), 10);
					const birthMonth = parseInt(birthString.substring(4,
							6), 10);
					const birthDay = parseInt(
							birthString.substring(6, 8), 10);

					const currentDate = new Date();
					const currentYear = currentDate.getFullYear();
					const currentMonth = currentDate.getMonth() + 1; // 0부터 시작하므로 +1
					const currentDay = currentDate.getDate();

					let age = currentYear - birthYear;

					// 생일이 지나지 않았다면 나이 하나 감소
					if (currentMonth < birthMonth
							|| (currentMonth === birthMonth && currentDay < birthDay)) {
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
