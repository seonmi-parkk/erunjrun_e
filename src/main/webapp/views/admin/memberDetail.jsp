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
	.table-container{
	 display: block; 
	justify-content: space-between;  /* 테이블 사이에 공간 배분 */
    gap: 20px;  
	}
	
	table {
    margin-bottom: 100px;
    margin-top: 100px;    /* 테이블 사이 간격을 20px로 설정 */
    padding: 10px;          /* 테이블 내부 여백 */
	}
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
	
	
	<p class="title1" id="nick" >${info.nickname}님</p>
	
	
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
	    
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="admin_name">아이디</p>
			<p class="title2" id="admin_name"> ${info.id}</p>
		</div>	

	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="admin_name">닉네임</p>
			<p class="title2" id="admin_name">${info.nickname}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="admin_name">이메일</p>
			<p class="title2" id="admin_name"> ${info.id}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="admin_name">주소</p>
			<p class="title2" id="admin_name"> ${info.address}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="admin_name">성별</p>
			<p class="title2" id="admin_name">${info.gender}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="admin_name">생년월일</p>
			<p class="title2" id="admin_name">${info.birth}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="admin_name">전화번호</p>
			<p class="title2" id="admin_name">${info.phone}</p>
		</div>	
		
		
		<div class="table-container">
	 	<table>
		<thead class="reportlist">

				<tr>
					<th>카테고리</th>
					<th>신고자</th>
					<th>처리여부</th>
					<th>신청일자</th>
				</tr>
			</thead>
		 	<tbody>
		 	
		 	<c:forEach items="${list}" var="report">
				<tr>
					<td>${report.code_name}</td>
					<td><a href="reportDetail/=${report.id}">${report.unlike_id}</a></td>
					<td>${report.use_yn}</td>
					<td>${report.create_date}</td>
				</tr>
			</c:forEach>
		 	</tbody>
   </table>
   
   <table>
		<thead>
		
		</thead>
			<colgroup>
		 		<col width="30%"/>
		 		<col width="40%"/>
		 		<col width="30%"/>
		 	</colgroup>
			
			<tr>
				<th>카테고리</th>
				<th>정지기간</th>
				<th>신청일자</th>
			</tr>
		
		
	 	<tbody>
	 		<c:forEach items="${result}" var="ban">
			<tr>
				<td><a href="memberRightDetail?id=${ban.id}">${ban.content}</a></td>
				<td>${ban.start_date} ~ ${ban.end_date}</td>
				<td>${ban.process_date}</td>
			</tr>
		</c:forEach>
	 	</tbody>
   </table>
			
	</div>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="footer.jsp"/>
</body>



<script>

    
</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>