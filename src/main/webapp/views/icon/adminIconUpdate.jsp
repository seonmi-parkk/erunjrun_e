<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>아이콘 수정</title>
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
    	margin-right: 4px;
    }
     #radio + span{
     	margin-right: 14px;
     }
    #short,#searchOption{
	   width: 100px; /* 너비를 250픽셀로 설정 */
	   font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
	   padding: 10px; 
   }
   
    
	.btn01-l{
		margin-top: 50px;
		/* margin-left: 650px; */
	}
	#dot{
		font-size: 34px;
		color: #FB7E3A;
	}
	input[name="cost"]#text{
		margin-right: 8px;
	}
	.title2#text {
		width: 74px;
	}
	#img_miri {
         width: 360px;    
         height: 360px;       
         margin-right: 10px;
         border: 1px solid var(--input-bd); 
         background-color: transparent;  
         overflow: hidden;
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
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminMember'">회원정보</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminReport'">신고</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminAsk'">문의하기</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminTag'">태그</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminIconListView'">아이콘</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminPopup'">팝업</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminCode'">구분코드</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='adminJoin'">회원가입</p>
        </aside>
	 	<main class="main-content">
	 	
		<p class="title1" >아이콘 수정</p>
		
		
	  	<form action="/adminIconUpdate" method="post" id="form" enctype="multipart/form-data">
	  	
			<input type="hidden" name="icon_idx" id="text" value="${iconDto.icon_idx}"/>
			<div class="input-container">
				<p class="title2" id="dot">•</p>
				<p class="title2" id="text">아이콘명</p>
				<input type="text" name="icon_name" id="text" value="${iconDto.icon_name}"/>
			</div>
			<div class="input-container">
				<p class="title2" id="dot">•</p>
				<p class="title2" id="text">가격</p>
				<input type="text" name="cost" id="text" value="${iconDto.cost}"/>P
			</div>
			<!-- <input type="text" name="code_name" id="text" value="PP100" hidden=""/> -->
			
			<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">이미지</p>
			<div id="img_miri"></div>
			<input type="file" name="file" onchange="readFile(this)">	
			</div>
			
			<div class="input-container">
				<p class="title2" id="dot">•</p>
				<p class="title2" id="text">활성여부</p>
				<input type="radio" name="use_yn" value="Y" class="raido" id="radio" 
					<c:if test="${iconDto.use_yn eq 'Y'}">
						checked 
					</c:if>
				/><span>활성</span>
				
				<input type="radio" name="use_yn" value="N" class="raido" id="radio"
					<c:if test="${iconDto.use_yn eq 'N'}">
						checked 
					</c:if>				
				/><span>비활성</span>
			</div>
			
			
		   	<button class="btn01-l" type="submit" id="text">등록</button>
			<div class="btn02-l" onclick="location.href='/adminIconListView'">취소</div> <!-- 클릭시 색깔변경 -->
	</form>
	 </main>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="../footer.jsp"/>
</body>



<script>
	//크루 대표 이미지 미리보기
	 $('#img_miri').append('<img class="preview" width="360px" height="360px" src="/photo/${iconDto.image}"/>');   
	function readFile(input) {
	    var reader;
	    $('#img_miri').empty();
	
	    for (var file of input.files) {
	        reader = new FileReader();
	        reader.readAsDataURL(file);
	        reader.onload = function (e) {
	            $('#img_miri').append('<img class="preview" width="360px" height="360px" src="' + e.target.result + '"/>');
	        }
	    }
	}
    
</script>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>
</html>