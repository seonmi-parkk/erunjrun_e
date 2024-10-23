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
<style>
	
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="header.jsp"/> 
	
	<!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
	<div class="inner">
			
		<br/><p class="title1">--------타이틀 폰트1--------</p>
	    <p class="title1">대제목 34px</p>
	    <p class="title2">소제목 20px</p>
	
	    <br/><p class="title1">--------태그--------</p>
	    <div class="tag-l-bd">태그 L</div>
	    <div class="tag-m-gray">태그 M</div>
	    <div class="tag-s-org">태그 S</div>
	
	    <br/><br/><p class="title1">--------버튼--------</p>
	    <div class="btn01-l">버튼 l</div>
	    <div class="btn02-l">버튼 l</div>
	    <div class="btn03-l">버튼 l</div>
	    <div class="btn01-m">버튼 m</div>
	    <div class="btn02-m">버튼 m</div>
	    <div class="btn03-m">버튼 m</div>
	    <div class="btn01-s">버튼 s</div>
	    <div class="btn02-s">버튼 s</div>
	    <div class="btn03-s">버튼 s</div>
	    <div class="btn-like btn02-s"><img src="resources/img/common/ico_heart_no_act.png" alt="좋아요"></div>
	    <div class="btn-like btn02-s"><img src="resources/img/common/ico_heart_act.png" alt="좋아요"></div>
	
	    <br/><br/><p class="title1">--------input--------</p>
	    <input type="radio" name="" id=""/>
	    <input type="checkbox" name="" id=""/>
	    <select name="">
	        <option value="">옵션</option>
	        <option value="">옵션2</option>
	        <option value="">옵션3</option>
	    </select>
	    <input class="input-txt-l" type="text" name="" id=""/>
	    <input class="btn-sch" type="button" value="검색"/>
	
	    <p class="title2">input text 본문용(넓이는 알아서)</p>
	    <input type="text" name="" id=""/>
	    
	    <br/><br/><p class="title1">--------팝업--------</p>
	    <!-- 
	        <팝업> 
	        onclick="layerPopup('문구','버튼1 텍스트','버튼2 텍스트')"
	        + btn1Act()와  btn2Act() 함수 생성하여 각 버튼 클릭시 이벤트 넣기(422번줄 참고)
	    -->
	    <div class="btn01-m" onclick="layerPopup('~~~하시겠습니까?','다음으로','취소')">팝업</div>
	    <div class="btn02-m btn-popup" >팝업2</div>
	
		 <br/><br/><p class="title1">--------페이지네이션--------</p>
		<div class="container">
	   		<nav aria-label="Page navigation">
	       		<ul class="pagination" id="pagination"></ul>
	   		</nav>
		</div>
		
		 <br/><br/><p class="title1">--------테이블--------</p>
		 <table>
		 	<colgroup>
		 		<col/>
		 		<col width="50%"/>
		 		<col/>
		 		<col/>
		 		<col/>
		 	</colgroup>
		 	<thead>
		 		<tr>
		 			<th>신청회원</th>
		 			<th class="align-l">제목</th>
		 			<th>성별</th>
		 			<th>신청일자</th>
		 			<th>신청처리</th>
	 			</tr>
		 	</thead>
		 	<tbody>
		 		<tr>
		 			<td>김열무</td>
		 			<td class="align-l elipsis">긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬 긴 제목은 왼쪽정렬</td>
		 			<td>남</td>
		 			<td>2024.11.20</td>
		 			<td>승인</td>
		 		</tr>
		 	</tbody>
		 </table>
		 
		 
		 <br/><br/><p class="title1">-------- 운동메이트 태그 --------</p>
		 <div id="tagFilters">
		 	<label><input type="checkbox" value="소셜 모임"> 소셜 모임</label>
		 </div>
		 	 <br/><br/><p class="title1">--------  --------</p>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="footer.jsp"/>
</body>


<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>

<script>
var msg = '${msg}';
if (msg != '') {
   alert(msg);
}

/* 레이어팝업 */
function btn1Act() {
    // 1번버튼 클릭시 수행할 내용
    console.log('1번 버튼 동작');

    // 팝업 연달아 필요할 경우 (secondBtn1Act:1번 버튼 클릭시 수행할 내용/ secondBtn2Act: 2번 버튼 클릭시 수행할 내용)
    layerPopup("두번째", "체크", false ,secondBtn1Act , secondBtn2Act);
}

function btn2Act() {
    // 2번버튼 클릭시 수행할 내용
    console.log('2번 버튼 동작');
}

function secondBtn1Act() {
    // 두번째팝업 1번버튼 클릭시 수행할 내용
    console.log('두번째팝업 1번 버튼 동작');
}

function secondBtn2Act() {
    // 두번째팝업 2번버튼 클릭시 수행할 내용
    console.log('두번째팝업 2번 버튼 동작');
}

$('.btn-popup').on('click',function(){
	layerPopup('~~~하시겠습니까?222','다음으로2','취소2' ,secondBtn1Act , secondBtn2Act);
});

    
/* 페이지네이션 */
$('#pagination').twbsPagination({ 
	startPage:1, 
	totalPages:10, 
	visiblePages:10,
	/* onPageClick:function(evt,page){
		console.log('evt',evt); 
		console.log('page',page); 
		pageCall(page);
	} */
});

var msg = '${msg}';
if (msg != '') {
   alert(msg);
}
    
</script>
</html>