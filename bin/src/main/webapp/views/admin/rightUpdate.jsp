<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
#searchForm{
	margin-left: 300px;
	
	}
	#teid{
	margin-top: 50px;
	}
	.title1{
	margin-top: 120;
	}
	#form{
	margin-top: 50px;
	margin-bottom: 50px;
	}
	
	.btn01-l{
	margin-top: 50px;
	margin-left: 680px;
	}
	.
	.title2 {
        color: var(--font-color);
        font-family: "Pretendard Variable", sans-serif;
        font-size: 20px;
        font-weight: 900;
    }

	.input-container {
    display: flex;        /* Flexbox 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 20px;
    margin-top: 20px;
	}
	
	.input-container p {
	    margin-right: 20px;  /* 입력창과의 간격 조정 */
	}
    .radio{
    	 transform: scale(1.5);
    }
    
    #content{
    	width: 750px; /* 너비를 250픽셀로 설정 */
        height: 350px;
        resize: vertical; /* 높이를 50픽셀로 설정 */
        font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
        padding: 10px; /* 내부 여백을 10픽셀로 설정 */
    
    }
    
    #start_date{
    	width: 200px;
    }
    #end_date{
    	width: 200px;
    }
    
    
    .fixed-left {
    position: fixed;
    top: 80; /* 화면 상단에 고정 */
    left: 50; /* 화면 왼쪽에 고정 */
    width: 400px; /* 원하는 너비 설정 */
    padding: 10px;
    z-index: 999;
   /* background-color: #f0f0f0;  배경색 설정 */
    border-right: 1px solid #ccc; /* 오른쪽에 구분선 */
    height: 100%; /* 전체 높이 설정 */
    overflow-y: auto; /* 글이 길면 스크롤 가능하도록 설정 */
    
	}
	
	.inner{
    margin-left: 550px;
    height: 890px;
	}
	
	.image img {
    width: 30%;  /* 또는 원하는 픽셀 값 */
    height: auto;
    margin-bottom: 20px; /* 비율을 유지 */
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
		
	<div class="inner">
	
	<p class="title1" >회원정보</p>
	<p class="title1"  id="teid">${info.nickname}님</p>
	
	
		<div class="fixed-left">
	    <div class="image">
		    <img class="profile-img" src="resources/img/common/admin_profile.png" alt="관리자 프로필 이미지"/>
	    </div>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title2" id="admin_name">관리자</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminMember'"> 회원정보</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminReport'">신고</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminAsk'">문의하기</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminTag'">태그</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminIcon'">아이콘</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminPopup'">팝업</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminCode'">구븐코드</p>
	    <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
	    <p class="title3" onclick="location.href='adminJoin'">회원가입</p>
	    
	    </div>
		
	 
	  	<form action="memberRightUpdate" method="get">
		
   		
   		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="subject">카테고리</p>
			<input type="radio" name="code_name" value="A100"
						<c:if test="${info.code_name eq 'A100'}">checked</c:if>						
						/>게시글
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="code_name" value="A101"
						<c:if test="${info.code_name eq 'A101'}">checked</c:if>						
						/>댓글
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="code_name" value="A102"
						<c:if test="${info.code_name eq 'A102'}">checked</c:if>						
						/> 회원
		</div>
		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="subject">정지기간</p>
			<input type="text" name="start_date" id="start_date" value="${info.start_date}"/>
			<p class="title2" id=""> ~ </p>
			<input type="text" name="end_date" id="end_date" value="${info.end_date}"/>
		</div>
		
		<div class="input-container">
			<p class="title2" id="dot">•</p>
			<p class="title2" id="subject">정지내용</p>
			<input type="text" name="ban_content" id="content" value="${info.ban_content}"/>
		</div>
		
   		
   	<button class="btn01-l" type="submit">수정</button>
	<div class="btn02-l" onclick="location.href='adminMemberDetail?id=${info.id}'">취소</div> <!-- 클릭시 색깔변경 -->
	</form>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="../footer.jsp"/>
</body>



<script>

    
</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>