<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>crewUpdate</title>
	<link rel="stylesheet" href="/resources/css/crew.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/resources/js/summernote.js"></script>
	<script src="/resources/js/layerPopup.js"></script>
	
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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

    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <div class="crewWriteView"> <!-- 체크박스 순위 올리기 위함 -->

        <div class="inner">
            <form enctype="multipart/form-data">
                <p class="title1">러닝크루 수정</p>

                <div id="dori">
                    <div class="twobox">
                        <div id="img_miri"> <!-- 이미지 없을 경우 기본이미지 -->
                        	<c:choose>
								<c:when test="${not empty result.img_new}">
									<img src="/photo/${result.img_new}" width="300" height="200"/>
								</c:when>
								<c:otherwise>
									<img src="/resources/img/crew/crewImg300.png" width="300" height="200"/>
								</c:otherwise>                        	
                        	</c:choose>
                        </div> 
                        <span style='color:#d3d3d3'>※ 권장 사이즈 800px / 400px</span>
                        <input type="file" name="crew_img" onchange="readFile(this)" id="file" />
                        <label for="file">
                            <div class="btn03-m">이미지 업로드</div>
                        </label>
                    </div>
                    <div class="firstbox"> <!-- 레이아웃 구성을 위한 div -->
						<input type="hidden" name="crew_idx" value="${crew_idx}"/>
                        <div class="boxheigth">
                            <span class="title2">크루명 </span>
                            <input type="text" name="crew_name" value="${result.crew_name}" required />
                        </div> <br>

                        <span class="title2">태그</span>
                        <span id="tagFilters">
                            <label <c:if test="${fn:contains(result.tag_idxs, '1')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="1" 
                            		<c:if test="${fn:contains(result.tag_idxs, '1')}">checked</c:if>/>🏃‍♂️러닝에 집중</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '2')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="2" 
                            		<c:if test="${fn:contains(result.tag_idxs, '2')}">checked</c:if>/>🙋‍♀️ 친목도 중요</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '3')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="3" 
                            		<c:if test="${fn:contains(result.tag_idxs, '3')}">checked</c:if>/> 남성만 가능</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '4')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="4" 
                            		<c:if test="${fn:contains(result.tag_idxs, '4')}">checked</c:if>/> 여성만 가능</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '5')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="5" 
                            		<c:if test="${fn:contains(result.tag_idxs, '5')}">checked</c:if>/> 혼성</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '6')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="6" 
                            		<c:if test="${fn:contains(result.tag_idxs, '6')}">checked</c:if>/> <b style='color: FD6F22'>E</b> 환영해요</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '7')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="7" 
                            		<c:if test="${fn:contains(result.tag_idxs, '7')}">checked</c:if>/> <b style='color: 116DCA'>I</b> 환영해요</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '8')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="8" 
                            		<c:if test="${fn:contains(result.tag_idxs, '8')}">checked</c:if>/>🐂 소규모 크루</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '9')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="9" 
                            		<c:if test="${fn:contains(result.tag_idxs, '9')}">checked</c:if>/>🏆 대회 목적</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '10')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="10" 
                            		<c:if test="${fn:contains(result.tag_idxs, '10')}">checked</c:if>/>💦 러닝 고수만</label>
                            <label <c:if test="${fn:contains(result.tag_idxs, '11')}">class="checked"</c:if>>
                            	<input type="checkbox" name="tag_idx_list" value="11" 
                            		<c:if test="${fn:contains(result.tag_idxs, '11')}">checked</c:if>/>🥳 초보도 환영</label>
                        </span> <br>

                        <div class="boxheigth">
                            <span class="title2">요일</span>
                            <input type="checkbox" name="days" value="mon" 
                            	<c:if test="${fn:contains(result.days, 'mon')}">checked</c:if>/><span class="basictex" >월</span>
                            <input type="checkbox" name="days" value="tue" 
                            	<c:if test="${fn:contains(result.days, 'tue')}">checked</c:if>/><span class="basictex">화</span>
                            <input type="checkbox" name="days" value="wen" 
                            	<c:if test="${fn:contains(result.days, 'wen')}">checked</c:if>/><span class="basictex">수</span>
                            <input type="checkbox" name="days" value="thu" 
                            	<c:if test="${fn:contains(result.days, 'thu')}">checked</c:if>/><span class="basictex" >목</span>
                            <input type="checkbox" name="days" value="fri" 
                            	<c:if test="${fn:contains(result.days, 'fri')}">checked</c:if>/><span class="basictex" >금</span>
                            <input type="checkbox" name="days" value="sat" 
                            	<c:if test="${fn:contains(result.days, 'sat')}">checked</c:if>/><span class="basictex" >토</span>
                            <input type="checkbox" name="days" value="sun" 
                            	<c:if test="${fn:contains(result.days, 'sun')}">checked</c:if>/><span class="basictex">일</span>
                        </div> <br>

                        <div class="boxheigth">
                            <span class="title2">인원</span> 
                            <input type="number" name="member" min="2" required value="${result.member}" />
                        </div> <br>

                        <div class="boxheigth">
                            <span class="title2">운동강도</span>
                            <input type="number" name="minute" min="1" required value="${result.minute}"/><span class="basictex" > / </span>
                            <input type="number" name="distance" min="1" required value="${result.distance}"/><span class="basictex"> km </span>
                        </div> <br>

                        <div class="boxheigth">
                            <span class="title2">지역</span>
                            <input type="text" name="address" id="sample4_roadAddress" value="${result.address}" required disabled />
                            <input type="button" onclick="search()" class="btn02-m" value="검색">
                        </div>
                        
                        <div class="boxheigth">
                        	<span class="title2">모집</span>
                        	<input type="radio" name="is_recruit" value="Y" checked/>모집
                        	<input type="radio" name="is_recruit" value="N"/>마감
                        </div>

                    </div> <!-- 레이아웃 구성을 위한 div --> <br>

                    <div class="content_layout"> <!-- 레이아웃 구성을 위한 div -->
                        <span class="title2">크루 설명</span> <br><br>
                        <div class="post-form">
                            <textarea name="postContent" id="summernote" maxlength="10000" > </textarea>
                        </div>
                    </div>

                </div>

                <div class="btn-parent">
                    <button type="button" class="btn03-l" onclick="locationHrdf()">수정 취소하기</button>
                    <button type="button" class="btn01-l" onclick="layerPopup('크루를 수정하시겠습니까?', '확인', '취소', submitPost, applBtn2Act)">크루 수정하기</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="../footer.jsp" />
</body>

<script src="/resources/js/common.js"></script>
<script src="/resources/js/daumapi.js"></script>

<script>
	var crew_idx = $('input[name="crew_idx"]').val();

	$.ajax({
		type: 'PUT',
		url: '/crew/updateView',
		data: {'crew_idx' : crew_idx},
		dataType: 'JSON',
		enctype: 'multipart/form-data',
		success: function(response){
			console.log('받아온 데이터 => ', response);
		},error: function(e){
			console.log('에러 => ', e);
		}
	});

var dayCheckboxes = [];  // 선택된 요일 체크박스를 추적할 배열	

	$(document).ready(function() {
		console.log('실행됨');
	
	    // 서버에서 가져온 content 값을 에디터에 삽입
	    var content = '<c:out value="${result.content}" escapeXml="false" />';
	    if (content) {
	        // summernote가 초기화된 후에만 내용을 설정
	        $('#summernote').summernote('code', content);
	    }
	    
	    $('input[name="days"]').each(function () {
	        if ($(this).is(':checked')) {
	            dayCheckboxes.push(this); // 서버로부터 받아온 값이 체크된 경우 dayCheckboxes에 추가
	        }
	    
		});
	
	    console.log("초기 체크된 요일들:", dayCheckboxes.map(item => $(item).val()));

	
	var crew_idx = $('input[name="crew_idx"]').val();


	// 크루 대표 이미지 미리보기
    function readFile(input) {
        var reader;
        $('#img_miri').empty();

        for (var file of input.files) {
            reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function (e) {
                $('#img_miri').append('<img class="preview" width="300px" height="200px" src="' + e.target.result + '"/>');
            }
        }
    }

    

    // 모든 체크박스에 change 이벤트 리스너 추가
    $('input[name="days"]').on('change', function () {
        if ($(this).is(':checked')) {
            if (dayCheckboxes.length >= 2) {
                var firstChecked = dayCheckboxes.shift();
                $(firstChecked).prop('checked', false);
            }
            dayCheckboxes.push(this);
        } else {
            dayCheckboxes = dayCheckboxes.filter(item => item !== this);
        }
    });
    var tagCheckboxes = [];  // 선택된 태그 체크박스를 추적할 배열

    // 모든 체크박스에 change 이벤트 리스너 추가
    $('input[name="tag_idx_list"]').on('change', function () {
        if ($(this).is(':checked')) {
            if (tagCheckboxes.length >= 3) {
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

    function submitPost() {
        var formData = new FormData($('form')[0]);
        var content = $('#summernote').summernote('code'); // summernote 코드

        var fileInput = $('input[type="file"]')[0]; // 파일 input에서 파일 가져오기
        if (fileInput.files.length > 0) {
            formData.append('crew_img', fileInput.files[0]); // 파일 데이터 추가
            console.log(formData.crew_img);
        }

        formData.append('id', 'test'); // todo - 세션값 체크해서 넣어줘야 함!
        
        formData.append('content', content);  // summernote의 HTML 내용 추가 (이미지 포함)

        formData.append('address', roadAddr); // 화면에 출력
        formData.append('sigungu', sigungu);
        formData.append('sido', sido);
        formData.append('shortsido', shortsido);

        var selectedTags = "";
        $('input[name="tag_idx_list"]:checked').each(function () {
            selectedTags += $(this).val() + ",";
        });

        selectedTags = selectedTags.slice(0, -1);

        // tag_idx_list 다시 set
        formData.set('tag_idx_list', selectedTags);

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

        $.ajax({
            type: 'PUT',
            url: '/crew/update',  // 서버에 전송할 URL
            data: formData,  // formData 객체 전송
            contentType: false,  // formData 사용 시 false로 설정
            processData: false,  // formData 사용 시 false로 설정
            enctype: 'multipart/form-data',  // multipart/form-data 사용
            success: function (response) {
                if(response.success){
	                removeAlert();
	                layerPopup('크루 수정이 완료되었습니다.', '확인', false, locationHrdf, locationHrdf);
                }
            },
            error: function (e) {
                console.log('글 수정 에러:', e);
            }
        });
    }
    
    function locationHrdf(){
    	location.href="/crewDetail/"+crew_idx;
    }

	// 팝업 취소
	function applBtn2Act() {
	    removeAlert(); 
	}
    
</script>

</html>