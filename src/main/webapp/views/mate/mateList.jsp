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
  		position: relative;
  		z-index: 2;
	  	width: 460px;
  	    height: 100%;
    	overflow-y: auto;
	  	padding : 20px 24px;
	  	background-color: #f8f8f8;
	  	box-shadow: rgba(0, 0, 0, 0.12) 4px 4px 13px -4px;
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
 		padding: 5px 10px 5px 6px;
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
  		padding: 3px 5px;
  		font-size: 12px;
  		font-weight:500;
  		background-color: var(--main-color);
  		color: #fff;
  		border-radius: 10px;
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
	.list-area {
		position: relative;
	}
	.list-area .minimize{
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
		position: absolute;
	    z-index: 2;
	    right: -22px;
	    top: calc(50% - 38px);
		width: 22px;
		height: 38px;
		border: 1px solid #fbfbfb;
		border-left: none;
		border-radius: 0 10px 10px 0;
		background: #fbfbfb;
	    box-shadow: rgba(0, 0, 0, 0.12) 4px 4px 13px -4px;
	    opacity: 1;
	}
 	.list-area .minimize.close + .list{
		width: 0;
		padding: 0;
	}
	.list-area .minimize img{
		width: 8px;
	}
	.list-area .minimize.close img{
		transform: rotate(180deg) ;
	}
	
	.mateList .profile-area{
    	width: 44px; height: 44px;
    	position: relative;
    	margin-right: 4px;
    }
    .mateList  .profile-box{
		position: absolute; top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		width: 44px; height: 44px;
		margin-right: 2px;
	}
	.mateList .profile-img{
		position: absolute; top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		width: 32px; height: 32px;
		border-radius: 50%;
	}
	
	.mg-l4{
	    margin-left: 4px;
	}
	#profilePopup {
	    left: 460px !important;
	    transform: none !important;
	}

	#map .profile-area {
	    position: relative;
	    width: 56px;
	    height: 78px;
	    background: url(/resources/img/common/ico_marker.png) center / 100% no-repeat;
	}
	/* .profile-area .profile-box{
	    position: absolute;
	    left: 50%;
	    transform: translateX(-50%);
	    top: 4px;
	} */
	.profile-area .ico-mate{
		position: absolute;
	    bottom: 13px;
	    left: 50%;
	    transform: translateX(-50%);
	    font-size: 12px;
	    color: #fff;
	}
	.mateList .marker-img {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
		-webkit-box-orient: vertical; -ms-flex-direction: column; flex-direction: column;
		cursor: pointer;
	}
	.mateList .marker-img .profile-box{
		width: 48px;
    	height: 48px;
    	top: 30px;
	}
	.mateList .marker-img .profile-img{
	    width: 34px;
	    height: 34px;
	    top: 39%;
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
	.overlaybox {
		  position: relative;
		  display: inline-block;
		  background: #284a6e no-repeat;
		  padding: 10px;
		  border-radius: 10px;
		  color: #fff;
	}
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="mateList">
		<div class="list-area">
			<div class="minimize">
				<img src="/resources/img/common/ico_arrow.png" alt="최소화"/>
			</div>
			<div class="list">
				<div class="sch-box">
					<input class="input-txt-l" type="text" name="sch-addr" value="${userPos.shortsido} ${userPos.dong}"/> 
					<input class="btn-sch" type="button" value="검색">
				</div>
				<div class="memList">
					
				</div>
			</div>

		</div>
		
		<div id="map" style="width:calc(100% - 400px);height:100%;"></div>

		<!-- 모달 -->
		<div id="profilePopup" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div id="PopupBody"></div>
		    </div>
		</div>

	</div>
</body>

<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>
<script>

	
	// 리스트 태그 생성			   
	function closeList(list, loginYn){
		var userCont = '';
		console.log("list--",list);
		
		if(list.length > 0){
			// 유저 위치 정보를 기준으로 list 배열을 거리순으로 정렬
		    list.sort(function(a, b) {
		        var distanceA = getDistance(a.latitude, a.longitude, ${userPos.latitude}, ${userPos.longitude});
		        var distanceB = getDistance(b.latitude, b.longitude,${userPos.latitude}, ${userPos.longitude});
		        return distanceA - distanceB; // 오름차순
		    });
			
			list.forEach(function(member) {
				console.log('member.id =', member.id);
				console.log('sessionId = ','${sessionScope.loginId}');
				if(member.id == '${sessionScope.loginId}'){
					console.log('member.id == 로그인 id');
					return;
				 }
				
				
				userCont +='<a class="user">';
				userCont+='<input type="hidden" name="toUserId" value="'+member.id+'"/>';
	
				userCont+='<div class="profile-area">';
			   	if(member.image != null){
			   		userCont +='<div class="profile-img" style="background: url(/photo/'+member.image+') center center / cover no-repeat;"></div>';
			   	}else{
			   		userCont +='<div class="profile-img" style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div>';
			   	}
			   	if(member.icon_image != null){
			   		userCont +='<div class="profile-box" style="background: url(/photo/'+member.icon_image+') center center / 100% 100% no-repeat;"></div>';
			   	}
				userCont+='</div>';
		          
				userCont+='</div>';
				userCont+='<span>'+member.nickname+'</span><span class="bar">/</span>';
				if(member.gender == '남'){
					userCont+='<img class="ico-gender" src="resources/img/common/ico_male.png" alt="남성">';
				}else{
					userCont+='<img class="ico-gender" src="resources/img/common/ico_female.png" alt="여성">';
				}

				userCont+='<span class="bar">/</span>';
				userCont+='<span>'+member.shortsido+'</span>';
				userCont+='<span class="mg-l4">'+member.dong+'</span>';
				if(loginYn == "Y"){					
					userCont+='<span class="bar">/</span>';
					userCont+='<span class="distance">'+getDistance(member.latitude,member.longitude,${userPos.latitude},${userPos.longitude})+'</span><span>km</span>';
				}
				userCont+='<span>';
				if(member.mate_idx > 0 && loginYn == "Y"){
					userCont+='<span class="tag-mate">메이트</span>';
				}else{
					userCont+='</span></a>';
				}
	
			});
		}

		// 두 유저간 거리 
		 function getDistance(lat1,lng1,lat2,lng2) {//lat1:위도1, lng1:경도1, lat2:위도2, lat2:경도2
		      function deg2rad(deg) {
		          return deg * (Math.PI/180)
		      }
		      var R = 6371; // Radius of the earth in km
		      var dLat = deg2rad(lat2-lat1);  // deg2rad below
		      var dLon = deg2rad(lng2-lng1);
		      var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
		      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		      var d = R * c; // Distance in km
		      return Math.round(d * 100) / 100; 
	    }

		document.getElementsByClassName('memList')[0].innerHTML = userCont;
		console.log('userCont--',userCont);
		
		
	}
	

	// 클릭시 운동프로필 레이어 팝업
	$(document).on('click','.user',function(){
	    var toUserId = $(this).find('input[name="toUserId"]').val();
	   // console.log('toUserId',toUserId);
	    openProfile(toUserId);
	});
	
	
	// 운동프로필 레이어 팝업 열기
	function openProfile(toUserId){
		var modal = document.getElementById("profilePopup");
	    var PopupBody = document.getElementById("PopupBody");
		
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
	}
	
	// 팝업 닫기
	$(document).on('click','#profilePopup .close',function(){
	    document.getElementById("profilePopup").style.display = "none";
	});

	
	// 리스트 최소화
	$('.list-area .minimize').on('click',function(){
			$(this).toggleClass('close');
			// 지도 크기 동적 변경
		    var mapContainer = document.getElementById('map');
		    mapContainer.style.width = '100%';
		    mapContainer.style.height = '100%'; 
			map.relayout();
	});
	
	
	    //카카오맵 API
	    var container = document.getElementById('map'); 
	    var options = { 
	        center: new kakao.maps.LatLng(${userPos.latitude}, ${userPos.longitude}), 
	        level: 4
	    };
	
	    // 맵 생성
	    var map = new kakao.maps.Map(container, options); 	    
	    
	    // 맵- 유저위치 마커
	    var positions = [];
		<c:forEach items="${posList}" var="user">
			console.log('${user.longitude}');
			positions.push({
				'id' :'${user.id}',
				'nickname' :'${user.nickname}',
				'lat' : '${user.latitude}',
				'lng': '${user.longitude}',
				'gender' : '${user.gender}',
				'image' : '${user.image}',
				'icon_image' : '${user.icon_image}',
				'mate_idx' : '${user.mate_idx}',
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
		
		// 유저 마커 내용
	   var overlays = [];	
		for (let i = 0; i < positions.length; i ++) {
		    let wrap = document.createElement('div'); //overlay content를 생성합니다.
		    wrap.className = 'marker-img';
		    wrap.onclick = () => { //클릭 이벤트를 등록합니다.
		        console.log(positions[i].nickname);
		        openProfile(positions[i].id);
		    }
		    
		    let profileArea = document.createElement('div'); //overlay content를 생성합니다.
		   
		    
		    
		    profileArea.className = 'profile-area';
			if(positions[i].id == '${sessionScope.loginId}'){
				profileArea.style.background = 'url(/resources/img/common/ico_marker_b.png) center / 100% no-repeat';
			}
		    
		    var image = 'background: url(/photo/'+positions[i].image+') center center / 100% no-repeat;';
		    if(positions[i].image == ''){
		    	image = 'background: url(/resources/img/common/profile.png) center center / 100% no-repeat;';
		    }
		    var isMate = '';
		    if(positions[i].mate_idx > 0){
		    	//isMate = '메이트';
		    	isMate = '<img class="ico-mate" src="/resources/img/mate/ico_mate.png" alt="메이트" />';
		    }
		    var icon = '';
		    if(positions[i].icon_image != ''){
		    	icon = 'background: url(/photo/'+positions[i].icon_image+') center center / 100% no-repeat;';	
		    }
			profileArea.innerHTML = '<div class="profile-img" style="'+image+'"></div><div class="profile-box" style="'+icon+'"></div></div>'+isMate;

			wrap.appendChild(profileArea);
		    
		    let text = document.createElement('div');
		    text.className = 'text';
		    			
		    if(positions[i].gender == '남'){
		    	genderImage = 'ico_male.png';
	    	}else{
	    		genderImage = 'ico_female.png';
    		}
		    text.innerHTML = positions[i].nickname + '<img class="gender" src="/resources/img/common/'+genderImage+'"/>';
		    wrap.appendChild(text);
		     
		    let overlay = new kakao.maps.CustomOverlay({ 
		        map: map,
		        position: positions[i].latlng,
		        content: wrap,
		        id: positions[i].id
		    });
		    
		    overlays.push(overlay);
		}
		
		// 보여지는 유저들 리스트 가져오기
		moveMap();
		
		
		
		
		
		
		/* // 동 구분
		var customOverlay = new kakao.maps.CustomOverlay({}),
	  kkoMap = {
	    // 지도 생성 및 초기화 함수
	    initKko: function (o) {
	      var e = o.mapId,
	        t = document.getElementById(e),
	        a = {
	          center: new kakao.maps.LatLng(37.567509, 126.980663),
	          level: 13,
	        };
	      (map = new kakao.maps.Map(t, a)),
	        // 행정구역 경계 데이터를 가져온다.
	        $.getJSON("sigu.json", function (o) {
	          let e = $(o.features);
	          e.each(function () {
	            kkoMap.getPolycode($(this)[0]);
	          });
	        });
	    },
	    // 경계면 좌표를 가져오는 함수
	    getPolycode: function (o) {
	      var e = [],
	        t = o.geometry;
	      if ("Polygon" == t.type) {
	        var a = t.coordinates[0],
	          n = { name: o.properties.adm_nm, path: [] };
	        for (var s in a)
	          e.push({ x: p[s][1], y: p[s][0] }),
	            n.path.push(new kakao.maps.LatLng(a[s][1], a[s][0]));
	        kkoMap.setPolygon(n, e);
	      } else if ("MultiPolygon" == t.type)
	        for (var s in t.coordinates) {
	          var p = t.coordinates[s],
	            n = { name: o.properties.adm_nm, path: [] };
	          for (var r in p[0])
	            e.push({ x: p[0][r][1], y: p[0][r][0] }),
	              n.path.push(new kakao.maps.LatLng(p[0][r][1], p[0][r][0]));
	          kkoMap.setPolygon(n, e);
	        }
	    },
	    // 경계면 좌표에 따라 Polygon을 그리는 함수
	    setPolygon: function (o, e) {
	      var t = new kakao.maps.Polygon({
	        name: o.name,
	        path: o.path,
	        strokeWeight: 2,
	        strokeColor: "#004c80",
	        strokeOpacity: 0.8,
	        fillColor: "#fff",
	        fillOpacity: 0.7,
	      });
	      kakao.maps.event.addListener(t, "mouseover", function (a) {
	        t.setOptions({ fillColor: "#09f" }),
	          customOverlay.setPosition(kkoMap.centroid(e)),
	          customOverlay.setContent(
	            "<div class='overlaybox'>" + o.name + "</div>"
	          ),
	          customOverlay.setMap(map);
	      }),
	        kakao.maps.event.addListener(t, "mouseout", function () {
	          t.setOptions({ fillColor: "#fff" }), customOverlay.setMap(null);
	        }),
	        t.setMap(map);
	    },
	    // 경계면의 중심좌표를 구하는 함수
	    centroid: function (o) {
	      var e, t, a, n, s, p, r, i, l;
	      for (e = 0, r = i = l = 0, t = (a = o.length) - 1; e < a; t = e++)
	        (n = o[e]),
	          (s = o[t]),
	          (p = n.y * s.x - s.y * n.x),
	          (i += (n.x + s.x) * p),
	          (l += (n.y + s.y) * p),
	          (r += 3 * p);
	      return new kakao.maps.LatLng(i / r, l / r);
	    },
	  };
		kkoMap.initKko({ mapId: "map" }); */
		
		
		
		
		
		
		
		
	   
	   
		// 클러스터러	
	    var clusterer = new kakao.maps.MarkerClusterer({
	            map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	            averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	            minLevel: 8, // 클러스터 할 최소 지도 레벨 
	           // markers: markers // 클러스터에 마커 추가
	    });
	    
	    clusterer.addMarkers(overlays);
	    
	    
	    // 검색시 지도 이동
	    // 주소-좌표 변환 객체 생성
		var geocoder = new kakao.maps.services.Geocoder();
		
	   $('.btn-sch').on('click',function(){
		   	var address = $('input[name="sch-addr"]').val();
			// 주소로 좌표 검색
			geocoder.addressSearch(address, function(result, status) {		
			    // 정상 검색
			     if (status === kakao.maps.services.Status.OK) {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        // 지도의 중심을 결과값으로 받은 위치로 이동
			        map.panTo(coords);
			    } else if(status === kakao.maps.services.Status.ZERO_RESULT){
			    	alert('정확한 주소를 입력해주세요.');
			    }

			    // 주소 가져오기(shortsido, dong)
			  /*  const callback = function(result, status) {
				   if(status === kakao.maps.services.Status.OK) {			    
				     // 리스트 요청 (시(shortsido),동(dong))
				     closeListReq(result[0].address.region_1depth_name,result[0].address.region_3depth_name,'${sessionScope.loginId}'); 
				  }
				}
			   geocoder.coord2Address(coords.getLng(), coords.getLat(), callback); */
			});    	
	   }) ;

	   
		// 맵 이동시 보여지는 유저들의 닉네임
	   function moveMap(){
			console.log("moveMap실행");
			//$('input[name="sch-addr"]').val('');
		    var bounds = map.getBounds();
		    var inBounds = overlays.filter(function(overlay) {
		        return bounds.contain(overlay.getPosition());
		    });
		    var users = [];
		    for(var user of inBounds){		    	
		    	console.log("inBounds 확인!!",user);
		    	console.log("inBounds",user.a.innerText);
		    	users.push(user.a.innerText);
		    }
		    console.log(users);
	
		    // 리스트 요청
	    	$.ajax({
	    		type: 'POST',
				url: '/moveMateList',
				contentType: 'application/json', // JSON 형식으로 보낼 경우 필요
		        data: JSON.stringify(users),  // 배열을 JSON 문자열로 변환
				dataType: 'JSON',
				success: function(data){
					console.log("list",data.list);
				    closeList(data.list, data.loginYn);
				},
				error: function(e){
					console.log(e);
					document.getElementsByClassName('memList')[0].innerHTML = '';
				}
	    	});
		    
	    	
	   }
		
		// 동 기반으로 리스트 가져오기
		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보 요청
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
		
		function displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		    	for(var i = 0; i < result.length; i++) {
		    		var shortSido = result[0].address.region_1depth_name;
		    		var dong = result[0].address.region_3depth_name;
		    		// console.log('result[0].address.region_3depth_name: ', result[0].address.region_3depth_name);
		    		 //closeListReq(shortSido, dong, '${userPos.id}');
		    		 $('input[name="sch-addr"]').val(shortSido+' '+dong);
		    	}
			}
		}
		
		
	   
	   // 지도 이동이나 확대 수준 변경시 리스트 변경
		kakao.maps.event.addListener(map, 'idle', function() {
			moveMap();
			searchDetailAddrFromCoords(map.getCenter(), displayCenterInfo);
		});
		
	   
	   
		
		
		
		
		
		
		/* // 맵 이동시
		kakao.maps.event.addListener(map, 'dragend', function() {
		    var bounds = map.getBounds();
		    var inBounds = overlays.filter(function(overlay) {
		        return bounds.contain(overlay.getPosition());
		    });
		    for(var user of inBounds){		    	
		    	console.log("inBounds",user.a.innerText);
		    }
		}); */
			   
		
	    
	   
	
		
</script>
</html>