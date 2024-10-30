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
                <p class="title1">크루 공지사항 등록</p>

                <div id="dori">
                    <div class="firstbox"> <!-- 레이아웃 구성을 위한 div -->

                        <div class="boxheigth">
                            <span class="title2">제목 </span>
                            <input type="text" name="crew_name" required />
                        </div> <br>


                        <div class="boxheigth">
                            <span class="title2">필독</span>
                            <input type="radio" name="priority" value=""  id="priorityChack"/><span class="basictex">필독</span>
                            <input type="radio" name="priority" value="" /><span class="basictex">일반</span>
                            <!-- 셀렉터 박스 -->
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
                    <button type="button" class="btn03-l">등록 취소하기</button>
                    <button type="button" class="btn01-l" onclick="submitPost()">공지사항 등록하기</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="../footer.jsp" />
</body>

<script src="/resources/js/common.js"></script>

<script>

	var loginId =  = '${sessionScope.loginId}';

    function submitPost() {
        // formData 생성
        var formData = new FormData($('form')[0]); // radio 값 받아오는지 체크 필요

        var content = $('#summernote').summernote('code');

        formData.append('id', loginId); // 세션값 체크해서 넣어줘야 함!
        formData.append('content', content);  // summernote의 HTML 내용 추가 (이미지 포함)

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
            type: 'POST',
            url: '/crew/noticeWrite',  // 서버에 전송할 URL
            data: formData,  // formData 객체 전송
            contentType: false,  // formData 사용 시 false로 설정
            processData: false,  // formData 사용 시 false로 설정
            enctype: 'multipart/form-data',  // multipart/form-data 사용
            success: function (response) {
                console.log('글 전송 성공:', response);
                if(response.success){
                	console.log(response.page);
                 	/* location.href=response.page;  */
                }
            },
            error: function (e) {
                console.log('글 전송 에러:', e);
            }
        });
    }
    
    // 기존에 작성된 순위인지 확인하고 체크 팝업 필요
    $('#priorityChack').on('click', function(){
/*     	<select id="priorityOption">
	        <option value="subject">1순위</option>
	        <option value="nickname">2순위</option>
	        <option value="content">3순위</option>
    	</select> */
    });
    
    
</script>
</html>