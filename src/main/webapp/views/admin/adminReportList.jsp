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
	footer {
    position: relative; /* 또는 fixed */
    bottom: 0;
    z-index: 0;
    width: 100%;
     margin-top: 20px;
	}
	

	.title1{
	margin-top: 100px;
	
	}
	
	#searchForm{
	margin-left: 0px;
	margin-bottom: 10px;
	margin-top: 10px;
	}
	.
	.title2{
        color: var(--font-color);
        font-family: "Pretendard Variable", sans-serif;
        font-size: 20px;
        font-weight: 800;
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
	.btn02-l{
	margin-top: 0px;
	margin-bottom: 50px;
	}

</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../header.jsp"/> 
	
	<!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
	<div class="inner">
	
		<p class="title1" >회원정보</p>
	
		<p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
		
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
		
		<div class="btn02-l" onclick="location.href='adminMember'">전체</div> <!-- 클릭시 색깔변경 -->
	    <div class="btn03-l" onclick="location.href='admin'">게시글</div>
	    <div class="btn03-l" onclick="location.href='admin'">댓글</div>
	    
	   	
		 <table>
			<thead>
			<colgroup>
		 		<col width="20%"/>
		 		<col width="20%"/>
		 		<col width="20%"/>
		 		<col width="20%"/>
		 		<col width="20%"/>
		 	</colgroup>
			
			<tr>
				<th>카테고리</th>
				<th>작성자</th>
				<th>처리자</th>
				<th>처리여부</th>
				<th>작성일자</th>
			</tr>
		
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
	<jsp:include page="footer.jsp" />
</body>



<script>

	var show = 1;
	pageCall(show);



	function pageCall(page) {
		$.ajax({
			type:'GET',
			url:'adminReportList',
			data:{
				'page':page,
				'cnt':15,
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
            content += '<td>'+view.category+'</td>';
			content += '<td><a href="adminReportDetail?id='+view.id+'">'+view.unlike_id+'<a/></td>';
			 var admin_name = view.name ? view.name : '관리자';
			content +='<td>'+admin_name+'</td>';
			var processValue = view.process ? view.process : '미확인';
			content +='<td>'+processValue+'</td>';
			content +='<td>'+view.create_date+'</td>';
			content +='</tr>';
		  }
	      $('#list').html(content);
	   }
 
    
	
    
</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>