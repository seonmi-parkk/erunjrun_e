<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의하기 게시글 등록</title>
    <link rel="stylesheet" href="/resources/css/common.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src="/resources/js/runSummerNote.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d"></script>
    <script src="/resources/js/layerPopup.js"></script>
    <style>
        #dori {
            width: 1280px;
            border: 1px solid #EAEAEA;
            background-color: transparent;
            margin: 80px auto 0;
            border-radius: 15px;
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
    	#tagFilters{
    		display: flex;
    	}
        
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <div class="inner">
        <form enctype="multipart/form-data">
            <p class="title1">문의하기 게시글 등록</p>
            <div id="dori">
                <div class="firstbox">
                    <div class="boxheigth">
                        <span id="span1" class="title2">제목 </span>
                        <input type="text" class="sub" name="subject" placeholder="제목을 입력해 주세요." required />
                    </div> <br>
                    <span class="title2" style="width: 140px; margin-left: 14px; margin-top: 4px;">카테고리 <span class="requiredText">※ 필수</span></span>
                        <span id="tagFilters">
                            <label><input type="checkbox" name="tag_idx_list" value="Q100">크루</label>
                            <label><input type="checkbox" name="tag_idx_list" value="Q101">‍러닝메이트</label>
                            <label><input type="checkbox" name="tag_idx_list" value="Q102">게시글</label>
                            <label><input type="checkbox" name="tag_idx_list" value="Q103">회원</label>
                            <label><input type="checkbox" name="tag_idx_list" value="Q104">기타</label>
                         </span> <br>
                    <div class="boxheigth">
                        
                    </div> <br>
                </div> <br>
                
                <div class="content_layout" style="margin-top: -75px;">
                    <p id="span3" class="title2" style="margin-left: -4px;">내용</p> <br><br>
                    <div class="post-form">
                        <textarea name="postContent" id="summernote" maxlength="10000"></textarea>
                    </div>
                </div>
            </div>
            <div class="btn-parent">
                <button type="button" class="btn03-l" id="cancelWrite" >등록 취소하기</button>
                <button type="button" class="btn01-l" id="writeRun" >게시글 등록하기</button>
            </div>
        </form>
    </div>
    <jsp:include page="../footer.jsp" />

    <script src="/resources/js/common.js"></script>

</body>
<script>
    
    var tagCheckboxes = [];  // 선택된 태그 체크박스를 추적할 배열

    // 모든 체크박스에 change 이벤트 리스너 추가
    $('input[name="tag_idx_list"]').on('change', function () {
        if ($(this).is(':checked')) {
            if (tagCheckboxes.length >= 1) {
                var firstChecked = tagCheckboxes.shift(); // 배열에서 첫 번째 체크박스를 제거
                $(firstChecked).prop('checked', false); // 첫 번째 체크박스 해제
                $(firstChecked).parent().removeClass('checked'); // 해당 체크박스의 label에서 'checked' 클래스 제거
            }
            tagCheckboxes.push(this); // 새로운 체크박스를 배열에 추가
            $(this).parent().addClass('checked'); // 현재 체크박스의 label에 'checked' 클래스 추가
        } else {
            tagCheckboxes = tagCheckboxes.filter(item => item !== this); // 선택 해제된 체크박스를 배열에서 제거
            $(this).parent().removeClass('checked'); // label에서 'checked' 클래스 제거
        }
    });
        
         
        // 레이어 팝업
	 	function secondBtn1Act() {
	 	// 두번째팝업 1번버튼 클릭시 수행할 내용
	 	    console.log('두번째팝업 1번 버튼 동작');
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
			var code_name =$('input[name="tag_idx_list"]:checked').val();
            console.log("선택한 태그의 코드네임 ->",code_name);

			
            formData.append('content', content);
            //formData.append('subject', subject);
            formData.append('id', userId);
            formData.append('code_name', code_name);

            
            console.log('게시글 등록 데이터:', {
                subject: subject,
                content: content,
                id: userId,
                code_name: code_name
            });

            // 서버에 데이터 전송
            $.ajax({
                type: "POST",
                url: "/askBoardWrite",
                contentType: false,
                processData: false,
                enctype: 'multipart/form-data',  // multipart/form-data 사용
                data: formData,
                success: function (data) {
                    console.log(data);
                    location.href = "/askBoardDetail/"+data.ask_idx;
                },
                error: function (xhr, status, error) {
                    alert("게시글 등록 중 오류가 발생했습니다: " + error);
                }
            });
	 	}
        
        
	 	function secondBtn2Act() {
	 	    // 두번째팝업 2번버튼 클릭시 수행할 내용
	 	    console.log('두번째팝업 2번 버튼 동작');
	 	   	removeAlert();
	 	}

	 	$('#writeRun').on('click',function(){
	 		var sub = $("input[name='subject']").val();
	 		var content = $('#summernote').summernote('code');
            console.log('나오닝',content);
	 		
	 		if(!sub){
	 			layerPopup('제목을 입력해 주세요.','확인',false ,secondBtn2Act , secondBtn2Act);	 			
	 		}else if(!content){
	 			layerPopup('내용을 입력해 주세요.','확인',false ,secondBtn2Act , secondBtn2Act);
	 		}else{
	 			layerPopup('게시글을 등록 하시겠습니까?','등록','취소' ,secondBtn1Act , secondBtn2Act);
	 		}
	 		
	 	});
	 	
	 	$('#cancelWrite').on('click',function(){
	 		layerPopup('등록을 취소 하시겠습니까?','확인','취소' ,secondBtn3Act , secondBtn2Act);
	 	});
	 	
	 	function secondBtn3Act() {
	 		console.log('두번째팝업 3번 버튼 동작');
	 		location.href = "/askBoard";
	 	}
	 	
	 	
	 	
        
        
        
        
        
        
        
        
</script>
</html>
