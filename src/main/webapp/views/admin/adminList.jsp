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
	<jsp:include page="header.jsp"/> 
	
	<!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
	<div class="inner">
		
		<div class="btn02-l" onclick="">일반회원</div>
	    <div class="btn03-l" onclick="">관리자</div>
	    
	    <select name="">
	        <option value="">아이디</option>
	        <option value="">이름</option>
	        <option value="">이메일</option>
	    </select>
	    
	    <input class="input-txt-l" type="text" name="keyword" id="keyword"/>
	    <input class="btn-sch" type="button" value="검색"/>
	
	   
		 <table>
		 	<colgroup>
		 		<col/>
		 		<col />
		 		<col/>
		 		<col/>
		 		<col/>
		 	</colgroup>
			<thead>
			<tr>
				<th>아이디</th>
				<th>관리자명</th>
				<th>가입일자</th>
				<th>삭제</th>
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



<script>

var show = 1;
pageCall(show);

	function pageCall(page) {
		$.ajax({
			type:'GET',
			url:'memberList',
			data:{
				
				'page':page,
				'cnt':20
			},
			datatype:'JSON',
			success:function(data){
				console.log(data);
				drawList(data.list)
				
				$('#pagination').twbsPagination({ // 페이징 객체 만들기
				startPage:1, 
           		totalPages:data.totalPages, 
           		visiblePages:10,
           		onPageClick:function(evt,page){
           			console.log('evt',evt); 
           			console.log('page',page); 
           			pageCall(page);
           		}
				});
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	
	function drawList(list) {
		var content ='';
		 for (var view of list) {
			content +='<tr>';
			content +='<td>'+view.admin_id+'</td>';
			content += '<td>'+view.name+'</td>';
			content +='<td>'+view.join_date+'</td>';
			content +='<td><a href="board_del?idx='+view.id+'">삭제</a></td>';
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
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>