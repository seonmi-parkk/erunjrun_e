<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>crewWrite</title>
	<link rel="stylesheet" href="/resources/css/crew.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/resources/js/summernote.js"></script>
	<script src="/resources/js/layerPopup.js"></script>


    <style>
        #img_miri {
            width: 300px;          /* 박스의 너비 설정 */
            height: 200px;         /* 박스의 높이 설정 */
            border: 1px solid #EAEAEA;  /* 연한 회색(#d3d3d3) 선 설정 */
            background-color: transparent;  /* 배경색 없음 */
        }

        #file {
            display: none;
        }

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
        
        #priorityOption{
        	margin-left: 45px;
        }
        .title2 {
		    color: var(--main-color);
		    font-family: "Pretendard Variable", sans-serif;
		    font-size: 20px;
		    font-weight: 500;
		    display: inline-block;
		    width: 100px;
		    float: left;
		    margin-top: 7px;
		}
		
		.layoutbox {
		    height: 90px;                  /* 이 높이와 동일한 값을 .two의 top에 설정 */
		    background-color: white;        /* 헤더 영역이 배경과 겹치지 않도록 배경색 추가 */
		}
		
		.btn-parent {
		    text-align: center;
		    margin-top: 40px;
		}
		
		input[type="text"] {
		    width: 85%;
		    padding: 7px 8px;
		    margin-right: 4px;
		    font-size: 16px;
		    border-radius: 6px;
		    border: 1px solid var(--input-bd);
		}
		
		#priorityOverlay{
			margin-left: 30px;
		}

    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    
	<div class="inner">
	    <form enctype="multipart/form-data">
	        <p class="title1">크루 공지사항 수정</p>
	
	        <div id="dori">
	            <div class="firstbox"> <!-- 레이아웃 구성을 위한 div -->
	
	                <div class="boxheigth">
	                    <span class="title2" id="subject"></span>
	                    <input type="text" name="subject" required />
	                </div> <br>
	
	
	                <div class="boxheigth">
	                    <span class="title2">필독</span>
	                    <input type="radio" name="priority" value=""  id="priorityChack"/><span class="basictex">필독</span>
	                    <input type="radio" name="priority" value=""  checked/><span class="basictex">일반</span>
	                    <select id="priorityOption" style='visibility : hidden'>
	                    	<option value="">순위선택</option>
					        <option value="pr1">1순위</option>
					        <option value="pr2">2순위</option>
					        <option value="pr3">3순위</option>
				    	</select>
				    	<span id="priorityOverlay" style='visibility : hidden'></span>
	                </div> <br>
	
	
	            </div> <!-- 레이아웃 구성을 위한 div --> <br>
	
	            <div class="content_layout"> <!-- 레이아웃 구성을 위한 div -->
	                <p class="title2">공지 내용</p> <br><br>
	                <div class="post-form">
	                    <textarea name="postContent" id="summernote" maxlength="10000"></textarea>
	                </div>
	            </div>
	
	        </div>
	
	        <div class="btn-parent">
	            <button type="button" class="btn03-l">수정 취소하기</button>
	            <button type="button" class="btn01-l" onclick="sendUpdatePost()">공지사항 수정하기</button>
	        </div>
	    </form>
	</div>
    
    <div class="layoutbox"></div>
    
    <jsp:include page="../footer.jsp" />
</body>

<script src="/resources/js/common.js"></script>

<script>

	var loginId = '${sessionScope.loginId}';
	var overlayCheck = 'Y';
	var notice_idx = '';

	function sendUpdatePost(){
		if(overlayCheck === 'Y'){
			layerPopup('공지사항을 수정하시겠습니까?', '확인', '취소', updatePost, applBtn2Act);
		}else{
			layerPopup('기존 공지 순위를 변경하시겠습니까?', '확인', '취소', updatePost, applBtn2Act);
		}
	}
	
	
	// 크루 넘버! 
    function updatePost() {
        var formData = new FormData($('form')[0]); // radio 값 받아오는지 체크 필요

        var content = $('#summernote').summernote('code');
        
        var priority = $('#priorityOption').val();
        priority = priority.replace(/^,|,$/g, '');
        

        formData.append('id', loginId); // 세션값 체크해서 넣어줘야 함!
        formData.append('content', content);  // summernote의 HTML 내용 추가 (이미지 포함)
		formData.append('priority', priority); // 순위 -> 없을 경우 서버에서 defarult = 0으로 받기
        formData.append('crew_idx', 52);
		
        var tempDom = $('<div>').html(content);
        var imgsInEditor = [];

        tempDom.find('img').each(function () {
            var src = $(this).attr('src');
            if (src && src.includes('/photo-temp/')) {  
                var filename = src.split('/').pop();  
                imgsInEditor.push(filename);  
            }
        });

        var finalImgs = tempImg.filter(function (temp) {
            return imgsInEditor.includes(temp.img_new);  
        });

        /* console.log("최종 전송할 이미지 쌍:", finalImgs); */

        formData.append('imgsJson', JSON.stringify(finalImgs));  

	    $.ajax({
	        type: 'POST',
	        url: '/crew/noticeWrite', 
	        data: formData,  
	        contentType: false, 
	        processData: false,  
	        enctype: 'multipart/form-data', 
	        success: function (response) {
	            console.log('글 전송 성공:', JSON.stringify(response, null, 2));
	            if(response.success){
	            	console.log('왜?');
	            	removeAlert();
	            	layerPopup('공지사항 수정이 완료되었습니다.', '확인',false, locationHref ,locationHref);
	            }
	        },
	        error: function (e) {
	            console.log('글 전송 에러:', e);
	        }
	    });
       
        
    }
	
	function updatePost(){
		var priority = $('#priorityOption').val();
		var crew_idx = 52;
		var notice_idx = notice_idx;
		
		$.ajax({
			type: 'POST',
    		url: '/crew/noticePriorityUpdate',
    		data: {'crew_idx' : crew_idx,
    				'priority' : priority},
    		dataType: 'JSON',
    		success: function(response){
    			if(response.success){
	    			submitPost();
    			}
    			
    		},error: function(e){
    			console.log('순위 수정 중 에러 => ', e);
    		}
		});
		
	}
    
	
	
	
    
    // 기존에 작성된 순위인지 확인하고 체크 팝업 필요 (아이디 중복체크처럼)
    $('#priorityChack').on('change', function(){
		$('#priorityOption').css('visibility', 'visible');
    });
    
    $('#priorityOption').on('change', function(){
    	
    	 var priority = $('#priorityOption').val();
    	 console.log(priority);
    	 
    	 var crew_idx = 52;
    	 console.log(crew_idx);
    	 
    	 if(priority === 'pr1' || priority === 'pr2' || priority === 'pr3'){
	    	 $.ajax({
	    		type: 'POST',
	    		url: '/crew/priorityOverlay',
	    		data: {'crew_idx' : crew_idx,
	    				'priority' : priority},
	    		dataType: 'JSON',
	    		success: function(response){
	    			console.log(response);
	    			console.log(response.notice_idx);
	    			
	    			if(response.count > 0){
	    				$('#priorityOverlay').css('visibility', 'visible');
	    				$('#priorityOverlay').html('이미 사용중인 순위입니다.');
	    				$('#priorityOverlay').css('color', '#666666');
	    				overlayCheck = 'N';
	    				notice_idx = response.notice_idx;
	    			}else{
	    				$('#priorityOverlay').css('visibility', 'visible');
	    				$('#priorityOverlay').html('사용 가능한 순위입니다.');
	    				$('#priorityOverlay').css('color', '#FF903F');
	    				overlayCheck = 'Y';
	    			}
	    			
	    		},error: function(e){
	    			console.log('중복체크 중 에러 => ', e);
	    		}
	    	 });
    	 }
    });
    
    function locationHref(){
    	location.href = '/crewNoticeList';
    }
    
	// 팝업 취소
	function applBtn2Act() {
	    removeAlert(); 
	}
	
    
    
</script>
</html>