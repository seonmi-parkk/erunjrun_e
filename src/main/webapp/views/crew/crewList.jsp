<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crew List</title>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/crew.css">

<link rel="stylesheet" href="/resources/css/crew/crewList.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/layerPopup.js"></script>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<div class="innerr">
	
		<div class="layoutbox">
			<div class="mainText">
 				나의 취향에 딱 맞는<br/>
				러닝크루와 함께 달려요
			</div>
		</div> <!-- layoutbox -->
		
		<div class="tagBox">
			<span id="tagFilter">
				<label><input type="checkbox" name="tag_idx_list" value="option0"/>🔔 모집중</label>
                <label><input type="checkbox" name="tag_idx_list" value="option1">🏃‍♂️러닝에 집중</label>
                <label><input type="checkbox" name="tag_idx_list" value="option2">🙋‍♀️ 친목도 중요</label>
                <label><input type="checkbox" name="tag_idx_list" value="option3"><img src="resources/img/common/ico_male.png" width="9px" class="tagImg-01"/> 남성만 가능</label>
                <label><input type="checkbox" name="tag_idx_list" value="option4"><img src="resources/img/common/ico_female.png" width="9px" class="tagImg-01"/> 여성만 가능</label>
                <label><input type="checkbox" name="tag_idx_list" value="option5"><img src="resources/img/common/ico_male.png" width="9px" class="tagImg-01"/><img src="resources/img/common/ico_female.png" width="9px" class="tagImg-01"/> 혼성</label>
                <label><input type="checkbox" name="tag_idx_list" value="option6"> <b style='color: #FD6F22' class="tagImg-01">E</b> 환영해요</label>
                <label><input type="checkbox" name="tag_idx_list" value="option7"> <b style='color: #116DCA' class="tagImg-01">I</b> 환영해요</label>
                <label><input type="checkbox" name="tag_idx_list" value="option8">🐂 소규모 크루</label>
                <label><input type="checkbox" name="tag_idx_list" value="option9">🏆 대회 목적</label>
                <label><input type="checkbox" name="tag_idx_list" value="option10">💦 러닝 고수만</label>
                <label><input type="checkbox" name="tag_idx_list" value="option11">🥳 초보도 환영</label>
                <label><input type="checkbox" name="tag_idx_list" value="option13"/>🗽 수도권(서울,경기,인천)</label>
                <label><input type="checkbox" name="tag_idx_list" value="option14"/><b style='color: gray' class="tagImg-01">#</b>수도권 외</label>
                <label><input type="checkbox" name="tag_idx_list" value="option15"/><b style='color: #116DCA' class="tagImg-01">W</b>평일 포함</label>
                <label><input type="checkbox" name="tag_idx_list" value="option16"/><b style='color: #FD6F22' class="tagImg-01">S</b>주말 포함</label>
            </span> <br>
		</div> <!-- tagBox -->
		
		<div class="crewListBox"> </div> <!-- crewListBox -->
		
		<div class="layoutbox-bt"></div>
		
	</div> <!-- inner -->
	
	<div id="loading" style="text-align: center; padding: 20px;">Loading...</div>
	
	<jsp:include page="../footer.jsp"/>
</body>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/crew/crew.js"></script>
<script src="/resources/js/chatting.js"></script>
</html>