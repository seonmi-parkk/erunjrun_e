<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	
</style>
</head>
<body>
	<!-- 검색기능 -->
	<!-- <form action="adminMemberList" method="get">
		<select name="opt">
			<option value="id">아이디</option>
			<option value="name">이름</option>
			<option value="email">이메일</option>
		</select>	
		<input type="text" name="keyword" placeholder="검색어를 입력하세요"/>
		<button>검색</button>
	</form> -->
	
	<!-- 리스트 -->
	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>권한</th>
				<th>신고누적수</th>
				<th>가입일시</th>
			</tr>
		</thead>
		<tbody id ="list" >
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
</body>
<script>

var showPage = 1; // 기본 보여줄 페이지

pageCall(showPage);

   
 function pageCall(showPage){
    console.log('pageCall');
    $.ajax({
          type: 'GET',
          url: 'memberList', 
          data:{
          	'page':page, //몇페이지 보여줘?
          	'cnt':15 // 페이지당 몇 개의 게시물을 보여줘??
          		
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

	 
/* <c:forEach items="${memberList}" var="memberList">
	<tr>
		<td style="color:${reporter_status == 'Y'?'blue':'black'};">${memberList.id}</td>
		<td><a href="memberdetail/${memberList.id}">${memberList.nickname}</a></td>
		<td>${memberList.email}</td>
		<td><a href="memberright/${memberList.id}">권한</a></td>
		<td>${memberList.join_date}</td>
	</tr>
</c:forEach> */
	
	/* $('#pagination').twbsPagination({ 
		startPage:1, 
		totalPages:10, 
		visiblePages:10,
		/* onPageClick:function(evt,page){
			console.log('evt',evt); 
			console.log('page',page); 
			pageCall(page);
		} 
	}); */
</script>
</html>


<%-- <c:forEach items="${memberList}" var="memberList">
		 	<tr>
		 		<td style="color:${reporter_status == 'Y'?'blue':'black'};">${memberList.id}</td>
		 		<td><a href="memberdetail/${memberList.id}">${memberList.nickname}</a></td>
		 		<td>${memberList.email}</td>
		 		<td><a href="memberright/${memberList.id}">권한</a></td>
		 		<td>${memberList.join_date}</td>
		 	</tr>
		</c:forEach> --%>