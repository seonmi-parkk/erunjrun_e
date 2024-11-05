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
	#content{
    	width: 750px; /* 너비를 250픽셀로 설정 */
        height: 350px;
        resize: vertical; /* 높이를 50픽셀로 설정 */
        font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
        padding: 10px; /* 내부 여백을 10픽셀로 설정 */
    
    }
	#dot{
	font-size: 34px;
	color: #FB7E3A;
	}
	.btn01-l{
	margin-top: 50px;
	margin-left: 510px;
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
         
		<p class="title1" >신고</p>
		<form action="/adminReportUpdate" method="get">
		
	 		<div class="input-container">
	  			<p class="title2" id="dot">•</p>
				<p class="title2" id="text">카테고리</p>
				<p class="title2" id="text">${info.category}</p>
			</div>	
			
	 		<div class="input-container">
	  			<p class="title2" id="dot">•</p>
				<p class="title2" id="text">게시글번호</p>
				<p class="title2" id="text" >${info.report_idx}</p>
			</div>	
			
	 		<div class="input-container">
	  			<p class="title2" id="dot">•</p>
				<p class="title2" id="text">작성일시</p>
				<p class="title2" id="text">${info.create_date}</p>
			</div>	
	
	 		<div class="input-container">
	  			<p class="title2" id="dot">•</p>
				<p class="title2" id="text">신고자</p>
				<p class="title2" id="text">${info.unlike_id}</p>
			</div>	
			
			<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">이미지</p>
		 	<img alt="${file.img_ori}" src="/photo/${file.img_new}">	
					<!-- /photo 라는 컨텍스트 요청이 있으면 C:/upload 로 연결하도록 설정 되어야 한다.(server.xml) -->
					<!-- server 파일에서 server.xml - >   <Context docBase="C:/upload" path="/photo" /> -->
	
			</div>
			
	 		<div class="input-container">
	  			<p class="title2" id="dot">•</p>
				<p class="title2" id="text">내용</p>
				<p class="title2" id="text">${info.content}</p>
			</div>	
			
						
	 		<div class="input-container">
	  			<p class="title2" id="dot">•</p>
				<p class="title2" id="text">처리내용</p>
				<textarea class="title2" id="content" name="process">${info.process}</textarea>
			</div>	
			
			<input type="text" name="report_idx" value="${info.report_idx}" hidden="hidden"/>
			
			<button class="btn01-l" type="submit" name="code_name" value="D103">처리완료</button>
			<button class="btn02-l" type="submit" name="code_name" value="D102">처리중</button>
			<button class="btn02-l" type="submit" name="code_name" value="D100">취소</button>
		</form>
						
         </main>
	
	
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="../footer.jsp"/>
</body>



<script>

    
</script>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>
</html>