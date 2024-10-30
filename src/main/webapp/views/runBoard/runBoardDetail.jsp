<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>러닝코스 게시글 상세보기</title>   
    <link rel="stylesheet" href="/resources/css/common.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d&libraries=services"></script>
	<script src="/resources/js/common.js"></script>
	<script src="/resources/js/layerPopup.js"></script>
	
    <style>
    	.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
		.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
		.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
		.number {font-weight:bold;color:#ee6152;}
		.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
		.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
		.distanceInfo:after {content:none;}
		
		.label {
	    color: #333; /* 텍스트 색상 */
	    font-weight: bold; /* 굵게 */
	    font-size: 14px; /* 폰트 크기 */
	    margin-right: 5px; /* 오른쪽 여백 */
		}
    
    
    	a{
    		color: #333;
    	}
        #dori {
            width: 1280px;          /* 박스의 너비 설정 */
            /* 박스의 높이 설정 */
            border: 1px solid #EAEAEA;  /* 연한 회색(#d3d3d3) 선 설정 */
            background-color: transparent;
            margin: 80px auto 0;
            border-radius: 15px;
        }
        #title3{
        	font-size: 16;
        }
        .rectangle-250,
			.rectangle-250 * {
			  box-sizing: border-box;
			}
		.rectangle-250 {
		
			    display: flex;
    			justify-content: space-between;
			  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
		}
		.duri{
			margin: 15px;
		}
		.title1{
    		margin-top: 160px;
    		margin-left: 10px;
    	}
    	.dari{
    		margin-top: 45px;
    	}
    	.title2{
			transform: translateY(0px);
    	}
    	.ori{

			  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  
    	}
    	#butt{
    		transform: translateY(-35px);
    	}
    	.repo{
    		  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;

    	}
    	#pre{
    		margin-left: 565px;
    		    margin-bottom: 30px;
    	}
    	#reo{
    		border-color: #AAAAAA;
    	}
    	.com{
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 1px 1px 1px 1px;
			  position: relative;
			  margin: 40px;
			  display: flex;
			  padding: 20px;
			  border-radius: 15px;
			  justify-content: space-between;
    	}
    	#title2-1{
    		margin-left: 0px;
    	}
    	.colist{
    		  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;
    	}
		.sort{
			background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;
			  justify-content: space-between;
			  min-height: 120px;
			  
		}
		#con{
			width: 1200px;
			font-size: 16;
			min-height: 250px;
		}
		.dat {
			display: flex;
			justify-content: space-between;
		}
		
		.detail{
			    margin-left: 35px;
		}
		#bih{
			margin-top: -50px;
		}
		
		.nick{
			margin-left: 18;
   		 	margin-bottom: 7px;
		}

		.date{
			margin-left: 50;
			margin-top: 10px;
		}
		
		.supa{
			margin-left: 60px;
   		 	margin-top: -20px;
		}
		.coco{
			width: 1000;
   		 	margin-left: 50px;
		}
		#ins{
			margin-left: -28px;
			margin-top: 34px;
		}
		input[type="text"].tex{
    		margin-left: 30px;
    		width: 1000px;
		}
		.bubu{
			display: flex;
			justify-content: space-between;
			margin: 17px;
		}
		.suj1{
			  background: #eeeeee;
			  border: solid 1px;
			  border-color: AEAEAE;
			  text-align: center;
			  margin-top: 5px;
		}
		.suj2{
			  background: #eeeeee;
			  border: solid 1px;
			  border-color: AEAEAE;
			  text-align: center;
			  
		}
		
		/*신고 레이어팝업*/
		#reportPopup {
		    width: fit-content;
		    top: 130px;
		    left: 50%;
		    transform: translateX(-50%);
			z-index: 996;
			
		}
		#reportPopup .close {
		    font-size: 40px;
		    font-weight: 300;
		    position: absolute;
		    z-index: 996;
		    top: 30px;
		    right: 30px;
		    display: inline-block;
		    width: 30px;
		    height: 30px;
		    line-height: 27px;
		    text-align: center;
		}
		#reportPopup .modal-content{
		    padding: 20px 20px;
		    background: #f8f8f8;
		    border: none;
	    	border-radius: 0;
	    }
	    #reportPopupBody {
	    	background: #fff;
	    	border-radius: 10px;
	    }
		
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <input type="hidden" name="board_idx"/>
	<div class="inner">
		<p class="title1">러닝코스 게시글</p>
		
		<div id="dori">
			<div class="rectangle-250">
				<div class="dari">
					<p class="title2">${info.subject}</p>
					<p class="title3-1"><img style="height: 30;" src="/resources/img/run/running_8421565.png" alt="아이콘">  ${info.nickname}</p>
				</div>
				<div style="text-align: right;" class="duri">
					<div id="butt"class=btn03-s>비활성화</div>					
					<p class="title3-2">${info.create_date}</p>
					<span class="title3-3">조회수 ${info.bHit}</span>
					<span class="title3-4"><img src="/resources/img/run/image 14.png" alt="댓글"> 댓글 2</span>
				</div>
			</div>
			<div class="ori">
				<div id="map" style="width:1200px; height:400px;"></div>
				<br>
				<div id="con">${info.content}</div>
			</div>
	    	<div class="repo">
	    		<div id="pre" class="btn-like btn02-s" style="padding: 20px;" onclick="boardLike(${info.board_idx})">
					<img class="icon" data-board-idx="${info.board_idx}" 
							 src="${isLike ? '/resources/img/common/ico_heart_act.png' : '/resources/img/common/ico_heart_no_act.png'}" 
        					 alt="${isLlike ? '좋아요' : '안좋아요'}" 
        					 style="height: 17px;">
				</div>
	    	<!--
	    		<c:choose>
					<c:when test="${not result.like}">
				    	<div id="pre" class="btn-like btn02-s" style="padding: 20px;" onclick="boardLike(${info.board_idx})">
				    		<img class="icon" src="/resources/img/common/ico_heart_no_act.png" alt="안좋아요" style="height: 17px;">
				    	</div>
			        </c:when>
			        <c:otherwise>
				        <div id="pre" class="btn-like btn02-s" style="padding: 20px;" onclick="boardLike(${info.board_idx})">
				        	<img class="icon" src="/resources/img/common/ico_heart_act.png" alt="좋아요" style="height: 17px;">
				        </div>				           			
			        </c:otherwise>
		        </c:choose>
		          -->
		    	<div id="reo" class="btn-like btn02-s" data-board-idx="${info.board_idx}" style="padding: 20px;"><img src="/resources/img/run/신고.png" alt="신고"></div>	    	
	    	</div>
	    	<div class="supa">
		    	<span id="title2-1" class="title2">등록순</span>
	    		<span id="title2-2" class="title2">최신순</span>
	    	</div>
	    	<div class="sort">
 				<div>
		    		<div class="nick"><img style="height: 30;" src="/resources/img/run/running_8421565.png" alt="아이콘">     김진형</div>
		    		<p class="coco">댓글내용</p>
		    		<div class="date">2024-10-25</div>
	    		</div>
	    		<div class="ard">
		    		<div class="detail"><img style="height: 5; margin-top: 25px;" src="/resources/img/run/Group 308.png" alt="상세"></div>
		    		<div id ="bih" class=btn03-s>비활성화</div>
		    		<div class="suj1 btn-popup">수정</div>
		    		<div class="suj2 btn-popup">삭제</div>
	    		</div>
    		</div>
	    	<div class="com">
	    		<div>
	    			<div class="nick"><img style="height: 30;" src="/resources/img/run/running_8421565.png" alt="아이콘">   ${sessionScope.loginId}</div>
		    		<input type="text" class="tex">
	    		</div>
	    		<div>
	    			<div id="ins" class=btn03-s>등록</div>	    		
	    		</div>
	    	</div>
	    </div>
	    <div class="bubu">
	    	<div class="bbs">
	    		<c:if test="${sessionScope.loginId == info.id}">
			        <button type="button" class="btn01-l" onclick="location.href='/runBoardUpdate/${info.board_idx}'">수정</button>
				    <button type="button" class="btn03-l btn-popup" >삭제</button>	    	    	
	    		</c:if>
	    	</div>
		    <button type="button" class="btn02-l" onclick="location.href='/runBoard'">목록</button>
	    </div>
	    
	    <!-- 모달 -->
		<div id="reportPopup" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div id="reportPopupBody"></div>
		    </div>
		</div>
	    
	
	</div>
    <jsp:include page="../footer.jsp" />

    
</body>
<script>

// 지도가 로드된 후 경로 표시 및 거리 계산을 수행하는 함수
function initializeMap() {
    var mapContainer = document.getElementById('map');
    var mapOption = { 
        center: new kakao.maps.LatLng(37.566641, 126.978202), 
        level: 3 
    };
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 서버에서 전달받은 `mapData` JSON 데이터 파싱
    var routeData = JSON.parse('<c:out value="${mapData}" escapeXml="false" />');
    var path = [];
    var totalDistance = 0;

    routeData.forEach(function(data, index) {
        if (!isNaN(data.latitude) && !isNaN(data.longitude)) {
            var position = new kakao.maps.LatLng(data.latitude, data.longitude);
            path.push(position);

            var dotContent = '<span class="dot"></span>';
            var customOverlay = new kakao.maps.CustomOverlay({
                position: position,
                content: dotContent,
                zIndex: 1
            });
            customOverlay.setMap(map);

            // 구간 거리 계산 및 표시
            if (index > 0) {
            	 var prevData = routeData[index - 1];
                 var segmentDistance = Math.round(calculateDistance(
                     prevData.latitude, prevData.longitude,
                     data.latitude, data.longitude
                 ));
                 totalDistance += segmentDistance;

                var distanceContent = '<div class="dotOverlay distanceInfo">거리: <span class="number">' + segmentDistance + '</span>m</div>';
                showDistance(distanceContent, position);
            }
        }
    });

    // Polyline으로 경로 표시
    var polyline = new kakao.maps.Polyline({
        path: path,
        strokeWeight: 4,
        strokeColor: '#FB7E3A',
        strokeOpacity: 1,
        strokeStyle: 'solid'
    });
    polyline.setMap(map);

    // 총거리 표시 (마지막 경로 지점에 표시)
    if (path.length > 1) {
        var totalDistanceContent = '<div class="dotOverlay distanceInfo">총거리: <span class="number">' + totalDistance + '</span>m</div>';
        showDistance(totalDistanceContent, path[path.length - 1]);
    }

    // 거리 정보 표시 함수
    function showDistance(content, position) {
        var overlay = new kakao.maps.CustomOverlay({
            map: map,
            content: content,
            position: position,
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3
        });
    }

    // 첫 번째 경로 지점을 중심으로 설정
    if (path.length > 0) {
        map.setCenter(path[1]);
    }
}

	// Kakao 지도 API 로드 완료 후 `initializeMap` 호출
	window.onload = function() {
	    kakao.maps.load(initializeMap);
	};
	
	function calculateDistance(lat1, lon1, lat2, lon2) {
	    var R = 6371e3; // 지구 반지름 (미터)
	    var φ1 = lat1 * Math.PI / 180;
	    var φ2 = lat2 * Math.PI / 180;
	    var Δφ = (lat2 - lat1) * Math.PI / 180;
	    var Δλ = (lon2 - lon1) * Math.PI / 180;
	
	    var a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
	            Math.cos(φ1) * Math.cos(φ2) *
	            Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
	    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	
	    return R * c; // 거리 (미터)
	}
	
	
	 // 추천 업데이트
	 function boardLike(board_idx) {
		 	 
		 var userId = "${sessionScope.loginId}";
         console.log(userId);
         if(!userId){
         	alert("로그인이 필요한 서비스 입니다.");
         	return;
         }
		 
		 
	        $.ajax({
	            type: 'POST',
	            url: '/boardLike',
	            data: { board_idx: board_idx},
	            success: function(data) {
	            	console.log("변함?:", data.like);
	            	var icon = $(`.icon[data-board-idx='${board_idx}']`);
	                if (data.like == true) {
	                	icon.attr('src', '/resources/img/common/ico_heart_act.png');
	                	console.log("좋아요?:", data.like);
	                } else {
	                	icon.attr('src', '/resources/img/common/ico_heart_no_act.png');
	                	console.log("안좋아요?:", data.like);
	                }
	                 
	                
	            },
	            error: function() {
	                alert('추천에 실패 했습니다.');
	            }
	        });
	    }
	 
	 	/*
	 	function runDelete(board_idx) {
	        if (confirm("정말 삭제하시겠습니까?")) {
	            $.ajax({
	                type: "POST",
	                url: "/runBoardDelete/" + board_idx ,
	                data: { board_idx: board_idx },
	                success: function(response) {
	                    if (response.success) {
	                        alert("게시글이 삭제 되었습니다.");
	                        location.href = "/runBoard";
	                    } else {
	                        alert("삭제에 실패했습니다.");
	                    }
	                },
	                error: function(error) {
	                    alert("오류가 발생했습니다.");
	                }
	            });
	        }
	    }
	 	*/
	 	
	 	/* 레이어팝업 */

	 	function secondBtn1Act() {
	 	    // 두번째팝업 1번버튼 클릭시 수행할 내용
	 	    
	 	    var board_idx = "${info.board_idx}";
	 	    
	 	    console.log('두번째팝업 1번 버튼 동작');
	 	   $.ajax({
               type: "POST",
               url: "/runBoardDelete/" + board_idx ,
               data: { board_idx: board_idx },
               success: function(response) {
                   if (response.success) {
                       location.href = "/runBoard";
                   } else {
                       alert("삭제에 실패했습니다.");
                   }
               },
               error: function(error) {
                   alert("오류가 발생했습니다.");
               }
           });
	 	}

	 	function secondBtn2Act() {
	 	    // 두번째팝업 2번버튼 클릭시 수행할 내용
	 	    console.log('두번째팝업 2번 버튼 동작');
	 	    removeAlert();
	 	}

	 	$('.btn-popup').on('click',function(board_idx){
	 		layerPopup('정말 삭제 하시겠습니까?','삭제','취소' ,secondBtn1Act , secondBtn2Act);
	 	});
	 	
	 	$('#reo').on('click',function(board_idx){
	 		layerPopup('정말 신고 하시겠습니까?','신고','취소' ,secondBtn3Act , secondBtn2Act);
	 	});
	 	
	 	function secondBtn3Act() {
	 	    // 두번째팝업 3번버튼 클릭시 수행할 내용
	 	    console.log('두번째팝업 2번 버튼 동작');
	 	   var boardIdx = $(this).data('board_idx');
	 	   openReport(boardIdx);
	 	   removeAlert();
	 	}
	 	
	 	
	 	// 클릭시 신고하기 레이어 팝업
	 	/*
		$(document).on('click','#reo',function(){
		    var boardIdx = $(this).data('board_idx');
		   // console.log('toUserId',toUserId);
		    openReport(boardIdx);
		});
		*/
		
		// 신고 레이어 팝업 열기
		function openReport(boardIdx){
			var modal = document.getElementById("reportPopup");
		    var PopupBody = document.getElementById("reportPopupBody");
		    var userId = '${sessionScope.loginId}';
		    var board_idx = '${info.board_idx}';
			console.log('가지고와ㅣ?',board_idx);
			console.log('가지고와ㅣ?',userId);
		    // AJAX 요청 데이터 넣을때 해당 게시판 idx 값 넣기!!!!
		    var xhr = new XMLHttpRequest();
		    xhr.open("GET", "/reportForm/"+board_idx, true);
		    xhr.onreadystatechange = function() {
		        if (xhr.readyState === 4 && xhr.status === 200) {
		            PopupBody.innerHTML = xhr.responseText; // 응답을 모달에 넣기
		            modal.style.display = "block"; // 모달 열기
		            
		         	// JS 파일을 동적으로 로드
		         	
		            var script = document.createElement('script');
		            script.src = '/resources/js/report.js'; 
		            document.body.appendChild(script);
		            
		        }
		    };
		    xhr.send();
		}
		
		// 팝업 닫기
		document.getElementsByClassName("close")[0].onclick = function() {
		    document.getElementById("reportPopup").style.display = "none";
		};
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	


</script>
</html>
