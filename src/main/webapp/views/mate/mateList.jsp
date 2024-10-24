<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.erunjrun.mate.dto.MateProfileDTO" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer"></script>

<style>

  .mateList {
	  	display: flex; display: -moz-box; display: -ms-flexbox;
	  	height: calc(100vh - 80px);
	  	margin-top: 80px;
  }
  .mateList .list {
	  	width: 400px;
  	    height: 100%;
    	overflow-y: auto;
	  	padding : 24px 28px 24px 24px;
	  	background-color: #f8f8f8;
  }
  .mateList .list .sch-box{
  	margin-bottom: 22px;
  }
   .mateList .list .input-txt-l{
   		width : calc(100% - 54px);
 		padding: 11px 14px;
   		border: none;
   }
   .memList .user {
   		display: -moz-box; display: -ms-flexbox; display : flex; 
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;  
   		position: relative;
		width: 100%;
 		padding: 5px 14px 5px 10px;
   		margin: 14px 0;
   		border-radius: 10px;
   		background-color: #fff;
   		cursor: pointer;
 		white-space: nowrap;
	    text-overflow: ellipsis;
	    word-break: break-all;
	    overflow: hidden;
   }
  .memList .user .ico-gender{
  		width: 9px;
  }
  .memList .user .bar{
  		display: inline-block;
  		margin: 0 4px;
  		color: #aaa;
  }
  .memList .user .tag-mate{
  		position: absolute;
  		right: 14px; top: 50%;
  		transform: translateY(-50%);
  		display: inline-block;
  		padding: 3px 8px;
  		font-size: 12px;
  		font-weight:500;
  		background-color: var(--main-color);
  		color: #fff;
  		border-radius: 10px;
  }
  #map {
  	    width: calc(100% - 400px) !important;
    	height: 100% !important;
  }
  
  	.mateList .list::-webkit-scrollbar {
	    width: 10px;
	}
	.mateList .list::-webkit-scrollbar-track {
	    background-color: #eaeaea;
	}
	.mateList .list::-webkit-scrollbar-thumb { 
	    background-color: #d0d0d0;
	    border-radius: 10px;
	}
	.mateList .list::-webkit-scrollbar-button {
	    display: none;
	}
	
	.mateList .list .profile-box {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
		flex-shrink: 0;  
		width: 50px; height: 50px;
		margin-right: 2px;
	}
	.mateList .profile-box .profile-img {
		width: 34px; height: 34px;
		border-radius: 50%;
	}
	.mg-l4{
	    margin-left: 4px;
	}
	#profilePopup .close {
	    font-size: 40px;
	    font-weight: 300;
	    position: absolute;
	    z-index: 999;
	    top: 40px;
	    right: 40px;
	    display: inline-block;
	    width: 30px;
	    height: 30px;
	    line-height: 27px;
	    text-align: center;
	}
	#profilePopup .modal-content{
	    padding: 24px 22px;
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
	<div class="mateList">
		<div class="list">
			<div class="sch-box">
				<input class="input-txt-l" type="text" name="sch-addr"/> 
				<input class="btn-sch" type="button" value="검색">
				
			</div>
			<div class="memList">
				<c:forEach items="${profileList}" var="member">
					<a class="user">
						<input type="hidden" name="toUserId" value="${member.id}"/>
					  	<div class="profile-box" style="background: url('resources/img/icon/${member.icon_image}') center center / 100% 100% no-repeat;">
			               <div class="profile-img" style="background: url(/photo/${member.image}) center center / cover no-repeat;"></div>
			            </div>
						<span>${member.nickname}</span><span class="bar">/</span>
						<c:if test="${member.gender eq '남'}">
							<img class="ico-gender" src="resources/img/common/ico_male.png" alt="남성">
						</c:if>
						<c:if test="${member.gender eq '여'}">
							<img class="ico-gender" src="resources/img/common/ico_female.png" alt="여성">
						</c:if>
						<span class="bar">/</span>
						<span>${member.shortsido}</span>
						<span class="mg-l4">${member.dong}</span>
						<span>
							<c:if test="${member.mate_idx > 0}"><span class="tag-mate">메이트</span></c:if>
						</span>
					</a>
				</c:forEach>
			</div>
		</div>
		<div id="map" style="width:500px;height:400px;"></div>
		
		<!-- 모달 -->
		<div id="profilePopup" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div id="PopupBody"></div>
		    </div>
		</div>
		
		
	</div>
</body>



<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
<script>
	console.log('${profileList}');
	var profileList = '${profileList}';
/* 	profileList.forEach(function(item){
		console.log(item);
	}); */
	
	
	// 클릭시 운동프로필 레이어 팝업
	$('.user').on('click',function(){
	    var modal = document.getElementById("profilePopup");
	    var PopupBody = document.getElementById("PopupBody");
	    var toUserId = $(this).find('input[name="toUserId"]').val();
	
	    // AJAX 요청
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "/mate/"+toUserId, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            PopupBody.innerHTML = xhr.responseText; // 응답을 모달에 넣기
	            modal.style.display = "block"; // 모달 열기
	        }
	    };
	    xhr.send();
	});
	
	// 모달 닫기
	document.getElementsByClassName("close")[0].onclick = function() {
	    document.getElementById("profilePopup").style.display = "none";
	};






	/* 카카오맵 지도 */
	/* var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴 */
		
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	/* 지도 위치이동 */
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	function setCenter() {            
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = new kakao.maps.LatLng(33.452613, 126.570888);
	    
	    // 지도 중심을 이동 시킵니다
	    map.setCenter(moveLatLon);
	}
	
	function panTo() {
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = new kakao.maps.LatLng(33.450580, 126.574942);
	    
	    // 지도 중심을 부드럽게 이동시킵니다
	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    map.panTo(moveLatLon);            
	}        
	
	
	
	
	/* 마커 */

// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
var markers = [];

// 마커 하나를 지도위에 표시합니다 
//addMarker(new kakao.maps.LatLng(33.450701, 126.570667));

// 마커를 생성하고 지도위에 표시하는 함수입니다
function addMarker(position) {
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: position
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
    
    // 생성된 마커를 배열에 추가합니다
    markers.push(marker);
}

// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
function setMarkers(map) {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
    }            
}

// "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
function showMarkers() {
    setMarkers(map)    
}

// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
function hideMarkers() {
    setMarkers(null);    
}


	
	
	
	
	
	
	
	
	// 마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [
	    {
	        title: '카카오', 
	        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
	    },
	    {
	        title: '생태연못', 
	        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
	    },
	    {
	        title: '텃밭', 
	        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
	    },
	    {
	        title: '근린공원',
	        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
	    }
	];

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	}
	
	
	
/* 	setTimeout(function(){
	    panTo();
	}, 2000); */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
</script>
</html>