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
	.table-container{
	 display: block; 
	justify-content: space-between;  /* 테이블 사이에 공간 배분 */
    gap: 20px;  
	}
	table {
    margin-bottom: 100px;
    margin-top: 30px;    /* 테이블 사이 간격을 20px로 설정 */
    padding: 10px;          /* 테이블 내부 여백 */
	}
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


	.btn02-l{
	margin-top: 0px;
	margin-bottom: 50px;
	}
	#dot{
	font-size: 34px;
	color: #FB7E3A;
	}
	
	
	
	 #dori .profile-area{
    	width: 120px; height: 120px;
    	position: relative;
	    }
	    #dori .profile-box {
			position: absolute; top: 50%; left: 50%;
			transform: translate(-50%, -50%);
			width: 120px; height: 120px;
			margin-right: 2px;
		}
		#dori .profile-img {
			position: absolute; top: 50%; left: 50%;
			transform: translate(-50%, -50%);
			width: 96px; height: 96px;
			border-radius: 50%;
		}
	
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../header.jsp"/> 
	
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
		<p class="title1" >회원정보</p>
		<p class="title1" id="nick" >${info.nickname}님</p>
		<div class="input-container">	
		<div id="dori">
		
		<div class="profile-area">
			<div class="profile-img" style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div><div class="profile-box" style="background: url(/resources/img/icon/${info.icon_image}) center center / 100% 100% no-repeat;"></div>				
	    	</div>
		</div>
		
	    
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">아이디</p>
			<p class="title2" id="text"> ${info.id}</p>
		</div>	

	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">닉네임</p>
			<p class="title2" id="text">${info.nickname}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">이메일</p>
			<p class="title2" id="text"> ${info.id}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">주소</p>
			<p class="title2" id="text"> ${info.address}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">성별</p>
			<p class="title2" id="text">${info.gender}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">생년월일</p>
			<p class="title2" id="text">${info.birth}</p>
		</div>	
		
	    <div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">전화번호</p>
			<p class="title2" id="text">${info.phone}</p>
		</div>	
		
		
		<div class="table-container"></div>
	 	<div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">신고내역 리스트</p>
		</div>	
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
					<td><a href="/adminReportDetail/${report.report_idx},${report.code_name}">${report.unlike_id}</a></td>
					<td>${report.use_yn}</td>
					<td>${report.create_date}</td>
				</tr>
			</c:forEach>
		 	</tbody>
   </table>
   
		<div class="input-container">
  			<p class="title2" id="dot">•</p>
			<p class="title2" id="text">정지내역 리스트</p>
		</div>	
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
					<td><a href="/memberRightDetail/${ban.ban_idx}">${ban.content}</a></td>
					<td>${ban.start_date} ~ ${ban.end_date}</td>
					<td>${ban.process_date}</td>
				</tr>
			</c:forEach>
		 	</tbody>
	   </table>	
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