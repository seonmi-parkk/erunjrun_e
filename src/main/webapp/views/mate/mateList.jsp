<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.erunjrun.mate.dto.MateProfileDTO" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<html>
<head>
<meta charset="UTF-8">
<title>운동프로필</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d&libraries=services,clusterer"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer"></script> -->

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
	  	padding : 20px 24px;
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
	
	.mateList .profile-box {
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
	#profilePopup {
	    left: 400px !important;
	    transform: none !important;
	}
/* 	.info-title {
	    width: fit-content;
        padding: 2px 10px;
	    display: block;
	    background-color: rgba(255,255,255,0.9);
	    text-align: center;
	    border-radius:10px;
	    font-weight: 500;
	}
	.info-title .gender{
		width: 9px;
		margin-left: 4px;
    	transform: translateY(3px);
	} */
	.profile-area {
	    position: relative;
	    width: 48px;
	    height: 70px;
	    background: url(/resources/img/common/ico_marker.png) center / 100% no-repeat;
	}
	.profile-area .profile-box{
	    position: absolute;
	    left: 50%;
	    transform: translateX(-50%);
	    top: 4px;
	}
	.mateList .marker-img {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
		-webkit-box-orient: vertical; -ms-flex-direction: column; flex-direction: column;
	}
	.mateList .marker-img .profile-box{
		width: 46px;
    	height: 46px;
	}
	.mateList .marker-img .profile-img{
	    width: 30px;
	    height: 30px;
	}
	.marker-img .text{
	    background: #fff;
	    padding: 2px 10px;
	    border-radius: 10px;
	    font-weight: 500;
	}
	.marker-img .gender{
		width: 9px;
		margin-left: 4px;
    	transform: translateY(3px);
	}
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="mateList">
		<div class="list">
			<div class="sch-box">
				<input class="input-txt-l" type="text" name="sch-addr" value="${userShortsido} ${userDong}"/> 
				<input class="btn-sch" type="button" value="검색">
			</div>
			<div class="memList">
				<c:forEach items="${closeList}" var="member">
					<a class="user">
						<input type="hidden" name="toUserId" value="${member.id}"/>
					  	<div class="profile-box" style="background: url('/resources/img/icon/${member.icon_image}') center center / 100% 100% no-repeat;">
		               		<c:choose>
								<c:when test="${not empty member.image}">  
									<div class="profile-img" style="background: url(/photo/${member.image}) center center / cover no-repeat;"></div>
								</c:when>
								<c:otherwise>
									<div class="profile-img"  style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div>
								</c:otherwise>
							</c:choose>
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
	var closeList = '${closeList}';

	// 클릭시 운동프로필 레이어 팝업
	$('.user').on('click',function(){
	    var modal = document.getElementById("profilePopup");
	    var PopupBody = document.getElementById("PopupBody");
	    var toUserId = $(this).find('input[name="toUserId"]').val();
	    console.log('toUserId',toUserId);
	
	    // AJAX 요청
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "/mate/"+toUserId, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            PopupBody.innerHTML = xhr.responseText; // 응답을 모달에 넣기
	            modal.style.display = "block"; // 모달 열기
	            
	         	// JS 파일을 동적으로 로드
	            var script = document.createElement('script');
	            script.src = '/resources/js/profileDetail.js'; 
	            document.body.appendChild(script);
	        }
	    };
	    xhr.send();
	});
	
	// 모달 닫기
	document.getElementsByClassName("close")[0].onclick = function() {
	    document.getElementById("profilePopup").style.display = "none";
	};

	
	
	
	
	
	  //카카오맵 API
	  var container = document.getElementById('map'); 
	    var options = { 
	        center: new kakao.maps.LatLng(37.402707, 126.922044), 
	        level: 12
	    };

	    var map = new kakao.maps.Map(container, options); 
	    // </맵 생성>
	    
	    var positions = [];
		<c:forEach items="${posList}" var="user">
			console.log('${user.longitude}');
			positions.push({
				'title' :'${user.nickname}',
				'lat' : '${user.latitude}',
				'lng': '${user.longitude}',
				'gender' : '${user.gender}',
				'profile' : '${user.image}',
				'icon' : '${user.icon_image}',
				
				'latlng' : new kakao.maps.LatLng('${user.latitude}', '${user.longitude}')
			});
		</c:forEach>
		console.log(positions);

			
			
	    /* var positions = [
	        {
	            title: '안양역', 
	            "lat": 37.402707,
	            "lng": 126.922044
	        },
	        {
	            title: '안양역 주위 1', 
	            "lat": 37.400707,
	            "lng": 126.920044
	        },
	        {
	            title: '안양역 주위 2', 
	            "lat": 37.403007,
	            "lng": 126.925044
	        },
	        {
	            title: '안양역 주위 3',
	            "lat": 37.405707,
	            "lng": 126.925044
	        }
	    ]; */
    	//var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
/* 		for (var i = 0; i < positions.length; i ++) {
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
			 // 마커 이미지를 생성합니다 
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		} */
	   var overlays = [];	
		for (let i = 0; i < positions.length; i ++) {
		    let wrap = document.createElement('div'); //overlay content를 생성합니다.
		    wrap.className = 'marker-img';
		    wrap.onclick = () => { //클릭 이벤트를 등록합니다.
		        console.log(positions[i].title);
		    }
		    
		    let profileArea = document.createElement('div'); //overlay content를 생성합니다.
		    profileArea.className = 'profile-area';
		    //$(wrap).append('<div class="profile-area"><</div>');
		    //<span>'+positions[i].mate_idx+'</span>
			profileArea.innerHTML = '<div class="profile-box" onclick="" style="background: url(resources/img/icon/'+positions[i].icon_image+') center center / 100% no-repeat;"><div class="profile-img" style="background: url(/photo/profile_img1.jpg) center center / cover no-repeat;"></div></div>';
			console.log('positions[i].icon_image',positions[i].icon_image);			

			 wrap.appendChild(profileArea);
		    
		    let text = document.createElement('div');
		    text.className = 'text';
		    
		    if(positions[i].gender == '남'){
		    	genderImage = 'ico_male.png'
	    	}else{
	    		genderImage = 'ico_female.png'
    		}
		    text.innerHTML = positions[i].title + '<img class="gender" src="/resources/img/common/'+genderImage+'"/>';
		    wrap.appendChild(text);
		     
		    let overlay = new kakao.maps.CustomOverlay({ 
		        map: map,
		        position: positions[i].latlng,
		        content: wrap
		    });
		    
		    overlays.push(overlay);
		}
	   
	   
			
	    var clusterer = new kakao.maps.MarkerClusterer({
	            map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	            averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	            minLevel: 8, // 클러스터 할 최소 지도 레벨 
	           // markers: markers // 클러스터에 마커 추가
	    });
	    
	    clusterer.addMarkers(overlays);
	    
	    


	    
	

 
	
/* 	setTimeout(function(){
	    panTo();
	}, 2000); */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
</script>
</html>