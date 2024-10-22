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
		 	<tbody id="list">
		 		
		 	</tbody>
		 	<tr>
	         <th colspan="6">
	            <div class="container">
	             <nav aria-label="Page navigation">
	              <ul class="pagination" id="pagination"></ul>
	             </nav>
	            </div>
	         </th>
	      </tr>
   </table>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="footer.jsp"/>
</body>

<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>

<script>
var showPage = 1; // 기본 보여줄 페이지

pageCall(showPage);

   
 function pageCall(page){
    console.log('pageCall');
    $.ajax({
          type: 'GET',
          url: 'memberList', 
          data:{
          	'page':page, //몇페이지 보여줘?
          	'cnt':15 // 페이지당 몇 개의 게시물을 보여줘??
          	console.log("page",page);	
          	console.log("cnt",page);	
          },
          dataType: 'json', 
          success: function(data) {
             console.log(data);
             listPrint(data.list);
             
             // 페이징 플러그인 처리
             $('#pagination').twbsPagination({
                startPage: 1, // 현재 보여지는 페이지
                totalPages: 20, // 최대 페이지 수
                visiblePages: 10, // 보여줄 페이지의 수
                onPageClick:function(evt, page){
                   console.log('evt', evt); // 클릭 이벤트의 모든 내용
                   console.log('page', page); // 클릭한 페이지 번호
                   pageCall(page);
                }
             });
             
          },
          error: function(e) {
              console.log("오류 발생", e);
          }       
      });
 }
	
	function listPrint(list) {
		var content ='';
		 for (var view of list) {
			content +='<tr>';
			content +='<td>'+view.id+'</td>';
			content += '<td><a href="adminMemberDetail/'+view.id+'">'+view.nickname+'<a/></td>';
			content +='<td>'+view.email+'</td>';
			content +='<td><a href="board_del?idx='+view.id+'">권한</a></td>';
			content +='<td>'+view.report_count+'</td>';
			content +='<td>'+view.join_date+'</td>';
			content +='</tr>';
		  }
	      $('#list').html(content);
	   }

    
/* 페이지네이션 */
/*$('#pagination').twbsPagination({ 
	startPage:1, 
	totalPages:10, 
	visiblePages:10,
	 onPageClick:function(evt,page){
		console.log('evt',evt); 
		console.log('page',page); 
		pageCall(page);
	} 
});*/
    
</script>
</html>