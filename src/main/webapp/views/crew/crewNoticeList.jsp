<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Crew Member List</title>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/crew/crewNoticeList.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>

</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<input type="hidden" name="crew_idx" value="${crew_idx}"/>
	<input type="hidden" name="loginId" value="${loginId}"> 
	<div class="inner">
		<div class="headlayout">
			<p id="crew_name"></p>
			<p class="title1">크루 공지사항</p>
		</div>
		<form id="searchForm">
		    <select id="searchOption">
		        <option value="subject">제목</option>
		        <option value="nickname">작성자</option>
		        <option value="content">내용</option>
		    </select>
		    <input class="input-txt-l01" type="text" id="searchKeyword" placeholder="검색어를 입력하세요"/>
		    <input class="btn-sch" type="submit" value="검색"/>
		</form>
		<table>
			<thead>
				<tr>
					<th>no</th>
					<th class="thSize">제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody id="list" >
		
			</tbody>
			<tr>
				<th colspan="5">
					<div class="container">
			    		<nav aria-label="Page navigation">
			        		<ul class="pagination" id="pagination"></ul>
			        		<a href="/crewNoticeWrite/${crew_idx}"><button class="btn01-l" style='visibility : hidden'>게시글 등록</button></a> 
			    		</nav>
					</div>
				</th>
			</tr>
		</table>
	
	<!-- 모달 -->
		<div id="profilePopup" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div id="PopupBody"></div>
		    </div>
		</div>
	</div>
	
	<div class="layoutbox-bt"></div>
	
	<jsp:include page="../footer.jsp"/>
</body>
<script src="/resources/js/crew/crewNoticeList.js" type="text/javascript"></script>
</html>