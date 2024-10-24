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
.inner{
    margin-left: 300px;
	}
	#searchForm{
	margin-left: 300px;
	
	}
	.
	.title2#admin_name {
        color: var(--font-color);
        font-family: "Pretendard Variable", sans-serif;
        font-size: 20px;
        font-weight: 700;
    }

	 #catagory {
        color: var(--font-color);
        font-family: "Pretendard Variable", sans-serif;
        font-size: 16px;
        font-weight: 500;
    }
    .fixed-left {
    position: fixed;
    top: 80; /* 화면 상단에 고정 */
    left: 50; /* 화면 왼쪽에 고정 */
    width: 200px; /* 원하는 너비 설정 */
    padding: 10px;
   /* background-color: #f0f0f0;  배경색 설정 */
    border-right: 1px solid #ccc; /* 오른쪽에 구분선 */
    height: 100%; /* 전체 높이 설정 */
    overflow-y: auto; /* 글이 길면 스크롤 가능하도록 설정 */
	}
	.image img {
    width: 50%;  /* 또는 원하는 픽셀 값 */
    height: auto; /* 비율을 유지 */
	}

	
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../header.jsp"/> 
	
	<!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
		
	<div class="inner">
	
	<p class="title1" >회원정보</p>
	<p class="title1" >id님</p>
	
	
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
		
	 
	  
		<table>
	
		<thead>
			<tr>
				<th>아이디</th>
				<td>${info.id}</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${info.nickname}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${info.email}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${info.address}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${info.gender}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${info.birth}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${info.phone}</td>
			</tr>
			
				<tr>
					<th>카테고리</th>
					<th>신고자</th>
					<th>처리여부</th>
					<th>신청일자</th>
				</tr>
			</thead>
		 	<tbody >
		 		<c:forEach items="${list}" var="report">
				<tr>
					<td>${report.code_name}</td>
					<td><a href="reportDetail/=${report.id}">${report.unlike_id}</a></td>
					<td>${report.use_yn}</td>
					<td>${report.create_date}</td>
				</tr>
			</c:forEach>
			
				<tr>
					<th>카테고리</th>
					<th>정지기간</th>
					<th>신청일자</th>
				</tr>
			
		 		<c:forEach items="${result}" var="ban">
				<tr>
					<td><a href="rightDetail?id=${ban.id}">${ban.code_name}</a></td>
					<td>${ban.start_date} ~ ${ban.end_date}</td>
					<td>${report.create_date}</td>
				</tr>
			</c:forEach>
			
			
			
			
		 	</tbody>
   </table>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="footer.jsp"/>
</body>



<script>

    
</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>