<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>러닝코스 게시글 등록</title>
    <link rel="stylesheet" href="/resources/css/common.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src="/resources/js/runSummerNote.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d"></script>
    <style>
        #dori {
            width: 1280px;
            border: 1px solid #EAEAEA;
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
		.distanceInfo:after {content:none;}
		
		.label {
	    color: #333; /* 텍스트 색상 */
	    font-weight: bold; /* 굵게 */
	    font-size: 14px; /* 폰트 크기 */
	    margin-right: 5px; /* 오른쪽 여백 */
		}
		
		
		
		
        .title1{
    		margin-top: 160px;
    	}
    	
    	.title2 {
        color: var(--main-color);
        font-family: "Pretendard Variable", sans-serif;
        font-size: 20px;
        font-weight: 500;
        display: inline-block;
   		width: 65px;
   		float: left; /*옆으로 나열!!*/
    	}
    	
    	.sub{
    		margin-top: 30px;
    	}
    	#span1{
    		margin-top: 37px;
    		margin-left: 15px;
    	}
    	#span2{
    		margin-top: 22px;
    		margin-left: 15px;
    		padding-bottom: 15px;
    	}
    	#span3{
    		margin-top: 0px;
    	}
    	#map{
    		margin-left: 30px;
    	}
    	.btn03-l{
    	    margin: 30px;
    		margin-left: 459px;
    	}
    	#info{
    		margin-top: 24px;
    	}
        
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <div class="inner">
        <form enctype="multipart/form-data">
            <p class="title1">러닝코스 게시글 등록</p>
            <div id="dori">
                <div class="firstbox">
                    <div class="boxheigth">
                        <span id="span1" class="title2">제목 </span>
                        <input type="text" class="sub" name="subject" placeholder="제목을 입력해 주세요." required />
                    </div> <br>
                        <span id="span2" class="title2">경로</span> <p id="info">지도를 좌클릭해 경로를 생성하고 우클릭해서 끝내주세요.</p>
                    <div class="boxheigth">
                        <div id="map" style="width:1200px; height:400px;"></div>
                    </div> <br>
                </div> <br>
                <div class="content_layout">
                    <p id="span3" class="title2">내용</p> <br><br>
                    <div class="post-form">
                        <textarea name="postContent" id="summernote" maxlength="10000"></textarea>
                    </div>
                </div>
            </div>
            <div class="btn-parent">
                <button type="button" class="btn03-l" onclick="cancelWrite()">등록 취소하기</button>
                <button type="button" class="btn01-l" onclick="writeRun()">게시글 등록하기</button>
            </div>
        </form>
    </div>
    <jsp:include page="../footer.jsp" />

    <script src="/resources/js/common.js"></script>
    <script>
        var routeData = [];
        var mapContainer = document.getElementById('map');
        var mapOption = { 
            center: new kakao.maps.LatLng(37.566641, 126.978202), 
            level: 3 
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);
        var drawingFlag = false;
        var moveLine;
        var clickLine;
        var distanceOverlay;
        var dots = [];

        // 지도 클릭 이벤트 - 경로 그리기 시작 및 좌표 추가
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            var clickPosition = mouseEvent.latLng;
            console.log('클릭 위치:', clickPosition);

            if (!drawingFlag) {
                // 경로 그리기 시작
                console.log('경로 그리기 시작');
                drawingFlag = true;
                deleteClickLine();
                deleteDistnce();
                deleteCircleDot();

                // 클릭한 위치를 기준으로 선을 생성하고 지도 위에 표시
                clickLine = new kakao.maps.Polyline({
                    map: map, 
                    path: [clickPosition], 
                    strokeWeight: 3, 
                    strokeColor: '#FB7E3A', 
                    strokeOpacity: 1, 
                    strokeStyle: 'solid' 
                });

                moveLine = new kakao.maps.Polyline({
                    strokeWeight: 3, 
                    strokeColor: '#FB7E3A', 
                    strokeOpacity: 0.5, 
                    strokeStyle: 'solid' 
                });

                displayCircleDot(clickPosition, 0);
            } else {
                // 경로에 좌표 추가
                console.log('경로에 좌표 추가');
                var path = clickLine.getPath();
                path.push(clickPosition);
                clickLine.setPath(path);
                var distance = Math.round(clickLine.getLength());
                displayCircleDot(clickPosition, distance);
            }
        });

        // 지도 마우스무브 이벤트 - 경로를 실시간으로 표시
        kakao.maps.event.addListener(map, 'mousemove', function(mouseEvent) {
            if (drawingFlag) {
                var mousePosition = mouseEvent.latLng;
                var path = clickLine.getPath();
                var movepath = [path[path.length-1], mousePosition];
                moveLine.setPath(movepath);
                moveLine.setMap(map);
                var distance = Math.round(clickLine.getLength() + moveLine.getLength());
                var content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>';
                showDistance(content, mousePosition);
            }             
        });

        // 지도 오른쪽 클릭 이벤트 - 경로 그리기 종료 및 최종 경로 저장
        kakao.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
            if (drawingFlag) {
                console.log('경로 그리기 종료');
                moveLine.setMap(null);
                moveLine = null;  
                var path = clickLine.getPath();

                if (path.length > 1) {
                    // 최종 경로 저장
                    routeData = [];
                    for (var i = 0; i < path.length; i++) {                   	
                        routeData.push({
                            latitude: path[i].getLat(),
                            longitude: path[i].getLng(),
                            path: i === 0 ? 'S' : (i === path.length - 1 ? 'E' : 'P'),
                            order_num: i + 1
                        });
                    }
                    console.log('최종 경로 저장:', routeData);

                    if (dots[dots.length-1].distance) {
                        dots[dots.length-1].distance.setMap(null);
                        dots[dots.length-1].distance = null;    
                    }
                    var distance = Math.round(clickLine.getLength());
                    var content = getTimeHTML(distance);
                    showDistance(content, path[path.length-1]);  
                } else {
                    deleteClickLine();
                    deleteCircleDot(); 
                    deleteDistnce();
                }
                drawingFlag = false;          
            }  
        });    

        // 클릭으로 그려진 선을 지도에서 제거
        function deleteClickLine() {
            if (clickLine) {
                console.log('기존 선 삭제');
                clickLine.setMap(null);    
                clickLine = null;        
            }
        }

        // 거리 정보 표시
        function showDistance(content, position) {
            if (distanceOverlay) {
                distanceOverlay.setPosition(position);
                distanceOverlay.setContent(content);
            } else {
                distanceOverlay = new kakao.maps.CustomOverlay({
                    map: map,
                    content: content,
                    position: position,
                    xAnchor: 0,
                    yAnchor: 0,
                    zIndex: 3  
                });      
            }
        }

        // 거리 정보 삭제
        function deleteDistnce () {
            if (distanceOverlay) {
                console.log('거리 정보 삭제');
                distanceOverlay.setMap(null);
                distanceOverlay = null;
            }
        }

        // 클릭 지점에 대한 정보 표시
        function displayCircleDot(position, distance) {
            var circleOverlay = new kakao.maps.CustomOverlay({ 
                content: '<span class="dot"></span>',
                position: position,
                zIndex: 1
            });
            circleOverlay.setMap(map);

            if (distance > 0) {
                var distanceOverlay = new kakao.maps.CustomOverlay({
                    content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
                    position: position,
                    yAnchor: 1,
                    zIndex: 2
                });
                distanceOverlay.setMap(map);
            }
            dots.push({circle:circleOverlay, distance: distanceOverlay});
            console.log('클릭 지점 표시:', position);
        }

        // 클릭 지점에 대한 정보 삭제
        function deleteCircleDot() {
            for (var i = 0; i < dots.length; i++) {
                if (dots[i].circle) { 
                    dots[i].circle.setMap(null);
                }
                if (dots[i].distance) {
                    dots[i].distance.setMap(null);
                }
            }
            dots = [];
            console.log('모든 클릭 지점 정보 삭제');
        }

        // 총 거리 정보 HTML 생성
        function getTimeHTML(distance) {
            var content = '<ul class="dotOverlay distanceInfo">';
            content += '    <li>';
            content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
            content += '    </li>';
            content += '</ul>'
            console.log("생성된 총거리 HTML: ", content); // 디버깅용 로그 추가
            return content;
        }
        
        
        
        function writeRun() {
            // formData 생성
            var formData = new FormData($('form')[0]);
            
            var content = $('#summernote').summernote('code');
            
         // 게시글 에디터 이미지 검증을 위한 코드
            var tempDom = $('<div>').html(content);
            var imgsInEditor = [];

            // 에디터의 이미지 태그에서 new_filename을 추출해 배열에 추가
            tempDom.find('img').each(function () {
                var src = $(this).attr('src');
                if (src && src.includes('/photo-temp/')) {  // 경로 검증을 위해 추가
                    var filename = src.split('/').pop();  // 파일명만 추출
                    imgsInEditor.push(filename);  // 에디터에 있는 이미지의 new_filename 추출
                }
            });

            // new_filename과 일치하는 항목만 필터링
            var finalImgs = tempImg.filter(function (temp) {
                return imgsInEditor.includes(temp.img_new);  // 에디터에 있는 파일과 tempImg의 new_filename 비교
            });

            console.log("최종 전송할 이미지 쌍:", finalImgs);

            // 최종 이미지 파일명 배열을 JSON으로 변환하여 추가
            formData.append('imgsJson', JSON.stringify(finalImgs));  // new_filename과 일치하는 값만 전
            

            // 게시글 제목과 내용 추가
            var subject = $("input[name='subject']").val();
            var content = $('#summernote').val();
            var userId = "${sessionScope.loginId}";  // 세션에서 사용자 ID 가져오기

            if (routeData.length == 0) {
                alert("경로를 입력해 주세요.");
                return;
            }

            formData.append('content', content);
            formData.append('routeData', JSON.stringify(routeData));
            formData.append('id', userId);

            
            console.log('게시글 등록 데이터:', {
                subject: subject,
                content: content,
                routeData: routeData,
                id: userId
            });

            // 서버에 데이터 전송
            $.ajax({
                type: "POST",
                url: "runBoardWrite",
                contentType: false,
                processData: false,
                enctype: 'multipart/form-data',  // multipart/form-data 사용
                data: formData,
                success: function (data) {
                    alert("게시글이 성공적으로 등록되었습니다.");
                    console.log(data);
                    location.href = "runBoard";
                },
                error: function (xhr, status, error) {
                    alert("게시글 등록 중 오류가 발생했습니다: " + error);
                }
            });
        }

        // 등록 취소 버튼 - 작성 취소
        function cancelWrite() {
            if (confirm("작성을 취소하시겠습니까?")) {
                history.back();
                location.href = "runBoard";
            }
        }
    </script>
</body>
</html>
