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
</head>
<body>
    <jsp:include page="../header.jsp" />
    <div class="crewWriteView"> <!-- 체크박스 순위 올리기 위함 -->

        <div class="inner">
            <form enctype="multipart/form-data">
                <p class="title1">크루 공지사항 등록</p>
                <input type="hidden" name="crew_idx" value="${crew_idx}"/>

                <div id="doricn">
                    <div class="firstbox"> <!-- 레이아웃 구성을 위한 div -->

                        <div class="boxheigth">
                            <span class="title2cn">제목 </span>
                            <input type="text" class="textB" name="subject" required />
                        </div> <br>


                        <div class="boxheigth">
                            <span class="title2cn">필독</span>
                            <input type="radio" name="priority" value=""  id="priorityChack"/><span class="basictex">필독</span>
                            <input type="radio" name="priority" value=""  id="checkReturn" checked/><span class="basictex">일반</span>
                            <select id="priorityOption" style='visibility : hidden'>
                            	<option value="">순위선택</option>
						        <option value="pr1">1순위</option>
						        <option value="pr2">2순위</option>
						        <option value="pr3">3순위</option>
					    	</select>
					    	<span id="priorityOverlay" style='visibility : hidden'></span>
                        </div> <br>


                    </div> <!-- 레이아웃 구성을 위한 div --> <br>

                    <div class="content_layoutcn"> <!-- 레이아웃 구성을 위한 div -->
                        <p class="title2cn">공지 내용</p> <br><br>
                        <div class="post-form">
                            <textarea name="postContent" id="summernote" maxlength="10000"></textarea>
                        </div>
                    </div>

                </div>

                <div class="btn-parentcn">
                    <button type="button" class="btn03-l" onclick="location.href='/crewNoticeList/${crew_idx}'">등록 취소하기</button>
                    <button type="button" class="btn01-l" onclick="sendSubmitPost()">공지사항 등록하기</button>
                </div>
            </form>
        </div>
    </div>
    
    <div class="layoutbox1"></div>
    
    <jsp:include page="../footer.jsp" />
</body>

<script src="/resources/js/common.js"></script>

<script>

	var loginId = '${sessionScope.loginId}';
	var overlayCheck = 'Y';
	var notice_idx = '';
	var crew_idx = $('input[name="crew_idx"]').val();
	
	function sendSubmitPost(){
		if(overlayCheck === 'Y'){
			layerPopup('공지사항을 등록하시겠습니까?', '확인', '취소', submitPost, applBtn2Act);
		}else{
			layerPopup('기존 공지 순위를 변경하시겠습니까?', '확인', '취소', updatePriority, applBtn2Act);
		}
	}
	
    function submitPost() {
        var formData = new FormData($('form')[0]); 

        var content = $('#summernote').summernote('code');
        
        var priority = $('#priorityOption').val();
        priority = priority.replace(/^,|,$/g, '');
        

        formData.append('id', loginId); 
        formData.append('content', content);  
		formData.append('priority', priority);
        formData.append('crew_idx', crew_idx); // todo - 받아온 값으로 수정 필요
		
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
	            	layerPopup('공지사항 등록이 완료되었습니다.', '확인',false, function(){locationHref(response.notice_idx)} ,locationHref);
	            }
	        },
	        error: function (e) {
	            console.log('글 전송 에러:', e);
	        }
	    });
       
    }
	
	function updatePriority(){
		var priority = $('#priorityOption').val();
		var notice_idx = notice_idx;
		
		$.ajax({
			type: 'PUT',
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
	
    
    $('#priorityChack').on('change', function(){
		$('#priorityOption').css('visibility', 'visible');
    });
    
    $('#checkReturn').on('change', function(){
		$('#priorityOption').css('visibility', 'hidden');
    });
    
    $('#priorityOption').on('change', function(){
    	
    	 var priority = $('#priorityOption').val();
    	 console.log(priority);
    	 
    	 var crew_idx = $('input[name="crew_idx"]').val();
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
    
    function locationHref(notice_idx){
     	location.href = "/crewNoticeDetail/" +notice_idx; 
    }
    
	// 팝업 취소
	function applBtn2Act() {
	    removeAlert(); 
	}
    
</script>
</html>