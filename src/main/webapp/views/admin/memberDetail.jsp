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
	
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../header.jsp"/> 
	
	<!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
		
	<div class="inner">
	
		<p class="title1" >회원정보</p>
		<p class="title2" >'view.id'+님</p>
	    <p class="title2" >관리자</p>
	    <p class="title3" onclick="location.href='adminMember'">회원정보</p>
	    <p class="title3" onclick="location.href='adminReport'">신고</p>
	    <p class="title3" onclick="location.href='adminAsk'">문의하기</p>
	    <p class="title3" onclick="location.href='adminTag'">태그</p>
	    <p class="title3" onclick="location.href='adminIcon'">아이콘</p>
	    <p class="title3" onclick="location.href='adminPopup'">팝업</p>
	    <p class="title3" onclick="location.href='adminCode'">구븐코드</p>
	    <p class="title3" onclick="location.href='adminJoin'">회원가입</p>
		
		<ul >
		    <li>아이디 </li>
		    <li>닉네임</li>
		    <li>이메일</li>
		    <li>주소</li>
		    <li>성별</li>
		    <li>생년월일</li>
		    <li>전화번호</li>
		</ul>
	 
	  
		<table>
			<thead>
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
			
		 		<c:forEach items="${ban}" var="ban">
				<tr>
					<td><a href="rightDetail/=${ban.id}">${ban.code_name}</a></td>
					<td>${ban.start_date} ~ ${ban.end_date}</td>
					<td>${report.use_yn} ~ </td>
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