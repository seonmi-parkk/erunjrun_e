<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>

	.input-container {
    display: flex;        /* Flexbox 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 20px;
    margin-top: 20px;
	}
	#text{
   
    margin-right: 15px
	}
	body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    margin: 0;
	}

/* 헤더 스타일 */


	/* 콘텐츠와 사이드바 감싸는 래퍼 */
	.content-wrapper {
	    display: flex;
	    width: 100%;
	    margin: 80px 10px; /* 헤더 높이만큼 여백 */
	    flex-grow: 1; /* 남은 공간 채우기 */
	}

	/* 사이드바 스타일 */
	.fixed-left {
	    width: 300px;
	    border-right: 1px solid #ccc;
	    padding: 20px;
	    position: sticky;
	    top: 80px; /* 헤더 아래에 고정 */
	    height: calc(100vh - 80px); /* 화면 높이에 맞추기 */
	    overflow-y: auto;
	}
	.fixed-left p{
	    margin: 15px 0;
	    line-height: 1.5;
	    font-size: 20px;
	}
	
	#admin_name{
	font-weight: 800;
	font-size: 23px;
	}
	
	.image img {
	    width: 35%;  /* 또는 원하는 픽셀 값 */
	    height: auto;
	    margin-bottom: 20px; /* 비율을 유지 */
		}
	/* 메인 콘텐츠 */
	.main-content {
	    flex: 1; /* 남은 공간 채우기 */
	    padding: 20px;
	    overflow: auto;
	}
    .radio{
    	
    	 transform: scale(1.5);
    }
    
  #content{
    	width: 750px; /* 너비를 250픽셀로 설정 */
        height: 350px;
        resize: none; /* 높이를 50픽셀로 설정 */
        font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
       	padding: 7px 8px; /* 내부 여백을 10픽셀로 설정 */
       	border-radius: 6px;
       	border: 1px solid var(--input-bd);
    }
    #radio{
    margin-left: 10px;
    }
   #short,#searchOption{
   width: 100px; /* 너비를 250픽셀로 설정 */
   font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
   padding: 10px; 
   }
   
    
	.btn01-l{
	margin-top: 50px;
	margin-left: 650px;
	}
	#dot{
	font-size: 34px;
	color: #FB7E3A;
	}
	
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../header.jsp"/> 
	
	<!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
		
	<div class="content-wrapper">
		<aside class="fixed-left">
            <div class="image">
                <img class="profile-img" src="/resources/img/common/admin_profile.png" alt="관리자 프로필 이미지"/>
            </div>
           <p class="title2" id="admin_name">관리자</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminMember'">회원정보</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminReport'">신고</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminAsk'">문의하기</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminTag'">태그</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminIconListView'">아이콘</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminPopup'">팝업</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminCode'">구분코드</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminJoin'">회원가입</p>
        </aside>
	 	<main class="main-content">
	 	
		<p class="title1" >팝업</p>
		
		
	  	<form action="/adminPopupUpdate" method="post" id="form" enctype="multipart/form-data">
	  	
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">제목</p>
			<input type="text" name="subject" id="text" value="${info.subject}" required="required"/>
		</div>
		
		<input type="text" name="popup_idx" id="text" value="${info.popup_idx}" hidden=""/>
			<input type="text" name="code_name" id="text" value="PP100" hidden=""/>
		
		<div class="input-container">
	    <p class="title2" id="dot">•</p>
	    <p class="title2" id="text">이미지</p>
	    <input type="file" name="file" id="fileInput" multiple="multiple" onchange="previewImage(event)">      
	
	    <!-- 기존 이미지 미리보기 (수정 페이지에서만 사용) -->
	    <c:if test="${not empty file}">
	        <div id="currentImageContainer">
	            <img alt="${file.img_ori}" src="/photo/${file.img_new}" id="currentImage" style="max-width: 200px;">
	            <button type="button" class="btn01-m" id="deleteImageBtn">이미지 삭제</button>
	        </div>
	    </c:if>
	
	    <!-- 새 이미지 미리보기 -->
	    <div id="newImageContainer" style="display: none;">
	        <img id="newImagePreview" style="max-width: 200px;">
	    </div>
		<div>
		    <input type="hidden" name="deleteImage" value="N" id="deleteImageFlag"/>
		</div>

					
		</div>
		<div class="input-container">
		<p class="title2" id="dot">•</p>
		<p class="title2" id="text">순서</p>
		<select id="searchOption" name="priority">
            <option value="1" <c:if test="${info.priority eq 1}">selected</c:if>>1</option>
		    <option value="2" <c:if test="${info.priority eq 2}">selected</c:if>>2</option>
		    <option value="3" <c:if test="${info.priority eq 3}">selected</c:if>>3</option>
        </select>
		</div>
		
		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">사용여부</p>
			<input type="radio" name="use_yn" value="Y" class="raido" id="radio"
			<c:if test="${info.use_yn eq 'Y'}">checked</c:if>						
				/>사용
		
			<input type="radio" name="use_yn" value="N" class="raido" id="radio"
			<c:if test="${info.use_yn eq 'N'}">checked</c:if>						
				/>미사용
		</div>
		
		
		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">위치</p>
			<p class="title2" id="text"> X: </p>
			<input type="text" name="x" id="short" value="${info.x}"required="required"/>
			<p class="title2" id="text"> Y: </p>
			<input type="text" name="y" id="short" value="${info.y}"required="required"/>
		</div>
		
		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">크기</p>
			<p class="title2" id="text"> 가로: </p>
			<input type="text" name="width" id="short" value="${info.width}"required="required"/>
			<p class="title2" id="text"> 세로: </p>
			<input type="text" name="height" id="short" value="${info.height}"required="required"/>
		</div>
		
		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">기간</p>
			<input type="date" name="start_date" id="start_date" value="${info.start_date}" required="required"/>
			<p class="title2" id=""> ~ </p>
			<input type="date" name="end_date" id="end_date" value="${info.end_date}"required= "required"/>
		</div> 
		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">내용</p>
			<textarea name="content" id="content" required="required">${info.content}</textarea>
		</div>
		

   	<button class="btn01-l" type="submit" id="text">수정</button>
	<div class="btn02-l" onclick="location.href='/adminPopup'">취소</div> <!-- 클릭시 색깔변경 -->
	</form>
	 </main>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="../footer.jsp"/>
</body>



<script>
    // 이미지 삭제 버튼 클릭 시
    $('#deleteImageBtn').on('click', function() {
        $('#deleteImageFlag').val('Y'); // 이미지 삭제 플래그 설정
        $('#currentImageContainer').hide(); // 기존 이미지 숨기기
    });

    // 새 이미지 선택 시 미리보기 기능
    function previewImage(event) {
        var file = event.target.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $('#newImagePreview').attr('src', e.target.result);
                $('#newImageContainer').show(); // 새 이미지 컨테이너 표시
            };
            reader.readAsDataURL(file);
        }
    }
</script>

<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>
</html>