<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>runBoardWrite</title>
	<link rel="stylesheet" href="/resources/css/common.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="/resources/js/summernote.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d"></script>


    <style>

        #dori {
            width: 1280px;          /* 박스의 너비 설정 */
            /* 박스의 높이 설정 */
            border: 1px solid #EAEAEA;  /* 연한 회색(#d3d3d3) 선 설정 */
            background-color: transparent;
            margin: 80px auto 0;
        }

        .content_layout {
            padding: 20px;
        }
        .dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
		.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
		.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
		.number {font-weight:bold;color:#ee6152;}
		.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
		.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
		.distanceInfo .label {display:inline-block;width:50px;}
		.distanceInfo:after {content:none;}

    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
        <div class="inner">
            <form enctype="multipart/form-data">
                <p class="title1">러닝코스 게시글 등록</p>
                <div id="dori">
                    <div class="twobox">
 
                    </div>
                    <div class="firstbox"> <!-- 레이아웃 구성을 위한 div -->
                        <div class="boxheigth">
                            <span class="title2">제목 </span>
                            <input type="text" name="subject" placeholder="제목을 입력해 주세요." required/>
                        </div> <br>
                        <div class="boxheigth">
                            <span class="title2">경로</span>
							<div id="map" style="width:1200px; height:400px;"></div>
                        </div> <br>
                    </div> <!-- 레이아웃 구성을 위한 div --> <br>
                    <div class="content_layout"> <!-- 레이아웃 구성을 위한 div -->
                        <p class="title2">내용</p> <br><br>
                        <div class="post-form">
                            <textarea name="postContent" id="summernote" maxlength="10000"></textarea>
                        </div>
                    </div>
                </div>
                <div class="btn-parent">
                    <button type="button" class="btn03-l">등록 취소하기</button>
                    <button type="button" class="btn01-l" onclick="writeRun()">게시글 등록하기</button>
                </div>
            </form>
        </div>
    <jsp:include page="../footer.jsp" />
</body>

<script src="/resources/js/common.js"></script>
<script src="/resources/js/daumapi.js"></script>

<script>
	
	var routeData = []; // 지도 경로 좌표를 담을 변수
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	mapOption = { 
	    center: new kakao.maps.LatLng(37.566641, 126.978202), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
	var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
	var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
	var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
	var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
	
	//지도에 클릭 이벤트를 등록합니다
	//지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	
	// 마우스로 클릭한 위치입니다 -- 좌표 얻어내기
	var clickPosition = mouseEvent.latLng;
	//console.log(clickPosition);
	
	// 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
	if (!drawingFlag) {
	
	    // 상태를 true로, 선이 그리고있는 상태로 변경합니다
	    drawingFlag = true;
	    
	    // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
	    deleteClickLine();
	    
	    // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
	    deleteDistnce();
	
	    // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
	    deleteCircleDot();
	
	    // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
	    clickLine = new kakao.maps.Polyline({
	        map: map, // 선을 표시할 지도입니다 
	        path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
	        strokeWeight: 3, // 선의 두께입니다 
	        strokeColor: '#db4040', // 선의 색깔입니다
	        strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	        strokeStyle: 'solid' // 선의 스타일입니다
	    });
	    
	    // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
	    moveLine = new kakao.maps.Polyline({
	        strokeWeight: 3, // 선의 두께입니다 
	        strokeColor: '#db4040', // 선의 색깔입니다
	        strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	        strokeStyle: 'solid' // 선의 스타일입니다    
	    });
	
	    // 클릭한 지점에 대한 정보를 지도에 표시합니다
	    displayCircleDot(clickPosition, 0);
	
	        
	} else { // 선이 그려지고 있는 상태이면
	
	    // 그려지고 있는 선의 좌표 배열을 얻어옵니다
	    var path = clickLine.getPath();
		//console.log(path);
	
	    // 좌표 배열에 클릭한 위치를 추가합니다
	    path.push(clickPosition);
	    
	    // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
	    clickLine.setPath(path);
	
	    var distance = Math.round(clickLine.getLength());
	    displayCircleDot(clickPosition, distance);
	}
	});
	
	//지도에 마우스무브 이벤트를 등록합니다
	//선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
	kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
	
	// 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
	if (drawingFlag){
	    
	    // 마우스 커서의 현재 위치를 얻어옵니다 
	    var mousePosition = mouseEvent.latLng; 
	
	    // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
	    var path = clickLine.getPath();
	    
	    // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
	    var movepath = [path[path.length-1], mousePosition];
	    moveLine.setPath(movepath);    
	    moveLine.setMap(map);
	    
	    var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
	        content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
	    
	    // 거리정보를 지도에 표시합니다
	    showDistance(content, mousePosition);   
	}             
	});                 
	
	//지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
	//선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
	kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
	
	// 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
	if (drawingFlag) {
	    
	    // 마우스무브로 그려진 선은 지도에서 제거합니다
	    moveLine.setMap(null);
	    moveLine = null;  
	    
	    // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
	    var path = clickLine.getPath();
	    
        for (var i = 0; i < path.length; i++) {
            routeData.push({
                latitude: path[i].getLat(),
                longitude: path[i].getLng(),
                path: i === 0 ? 'S' : (i === path.length - 1 ? 'E' : 'P'),  // S: 시작, E: 종료, P: 중간
                order_num: i + 1
            });
        }
        
        /*
        $.ajax({
            type: "POST",
            url: "/runBoardWrite",
            contentType: "application/json",
            data: JSON.stringify({ routeData: routeData }),
            success: function(response) {
                console.log("경로 저장 성공");
            },
            error: function(xhr, status, error) {
                console.error("경로 저장 실패: " + error);
            }
        });
	    */
	    
	
	    // 선을 구성하는 좌표의 개수가 2개 이상이면
	    if (path.length > 1) {
	
	        // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
	        if (dots[dots.length-1].distance) {
	            dots[dots.length-1].distance.setMap(null);
	            dots[dots.length-1].distance = null;    
	        }
	
	        var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
	            content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
	            
	        // 그려진 선의 거리정보를 지도에 표시합니다
	        showDistance(content, path[path.length-1]);  
	         
	    } else {
	
	        // 선을 구성하는 좌표의 개수가 1개 이하이면 
	        // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
	        deleteClickLine();
	        deleteCircleDot(); 
	        deleteDistnce();
	
	    }
	    
	    // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
	    drawingFlag = false;          
	}  
	});    
	
	console.log('총 경로',routeData);
	
	//클릭으로 그려진 선을 지도에서 제거하는 함수입니다
	function deleteClickLine() {
	if (clickLine) {
	    clickLine.setMap(null);    
	    clickLine = null;        
	}
	}
	
	//마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
	//마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
	function showDistance(content, position) {
	
	if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
	    
	    // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
	    distanceOverlay.setPosition(position);
	    distanceOverlay.setContent(content);
	    
	} else { // 커스텀 오버레이가 생성되지 않은 상태이면
	    
	    // 커스텀 오버레이를 생성하고 지도에 표시합니다
	    distanceOverlay = new kakao.maps.CustomOverlay({
	        map: map, // 커스텀오버레이를 표시할 지도입니다
	        content: content,  // 커스텀오버레이에 표시할 내용입니다
	        position: position, // 커스텀오버레이를 표시할 위치입니다.
	        xAnchor: 0,
	        yAnchor: 0,
	        zIndex: 3  
	    });      
	}
	}
	
	//그려지고 있는 선의 총거리 정보와 
	//선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
	function deleteDistnce () {
		if (distanceOverlay) {
		    distanceOverlay.setMap(null);
		    distanceOverlay = null;
		}
	}
	
	//선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
	//클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
	function displayCircleDot(position, distance) {
	
	// 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
	var circleOverlay = new kakao.maps.CustomOverlay({
	    content: '<span class="dot"></span>',
	    position: position,
	    zIndex: 1
	});
	
	// 지도에 표시합니다
	circleOverlay.setMap(map);
	
	if (distance > 0) {
	    // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
	    var distanceOverlay = new kakao.maps.CustomOverlay({
	        content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
	        position: position,
	        yAnchor: 1,
	        zIndex: 2
	    });
	
	    // 지도에 표시합니다
	    distanceOverlay.setMap(map);
	}
	
	// 배열에 추가합니다
	dots.push({circle:circleOverlay, distance: distanceOverlay});
	}
	
	//클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
	function deleteCircleDot() {
	var i;
	
	for ( i = 0; i < dots.length; i++ ){
	    if (dots[i].circle) { 
	        dots[i].circle.setMap(null);
	    }
	
	    if (dots[i].distance) {
	        dots[i].distance.setMap(null);
	    }
	}
	
	dots = [];
	}
	
	//마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
	//그려진 선의 총거리 정보와 계산하여
	//HTML Content를 만들어 리턴하는 함수
	function getTimeHTML(distance) {

	var content = '<ul class="dotOverlay distanceInfo">';
		content += '    <li>';
		content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
		content += '    </li>';
		content += '</ul>'
		
		return content;
	}
	console.log("맨아래",routeData);
	
	function writeRun() {
	    var subject = $("input[name='subject']").val();
	    var content = $('#summernote').val();  // Summernote 내용을 HTML로 가져옵니다.

		console.log(subject);
		console.log(content);
	    
	    // 경로 데이터와 이미지 데이터를 포함한 게시글 정보를 서버로 전송
	    $.ajax({
	        type: "POST",
	        url: "runBoardWrite",
	        contentType: "application/json",
	        data: JSON.stringify({
	            subject: subject,
	            content: content,
	            routeData: routeData  // 지도에서 수집한 경로 데이터
	        }),
	        success: function(data) {
	            alert("게시글이 성공적으로 등록되었습니다.");
	            location.href = "runBoardLlist";
	        },
	        error: function(xhr, status, error) {
	            alert("게시글 등록 중 오류가 발생했습니다: " + error);
	        }
	    });
	}

	
	
	
	
	// 썸머노트-----------------
	
	
	
	
	
	
	
	
	
	

</script>
</html>