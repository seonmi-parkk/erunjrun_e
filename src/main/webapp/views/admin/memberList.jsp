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
		
		<div class="btn02-l" onclick="location.href='adminMember'">일반회원</div> <!-- 클릭시 색깔변경 -->
	    <div class="btn03-l" onclick="location.href='admin'">관리자</div>
	    
	    <form id="searchForm" onsubmit="return false;">
		    <select id="searchOption">
		        <option value="id">아이디</option>
		        <option value="nickname">닉네임</option>
		        <option value="email">이메일</option>
		    </select>
		    <input class="input-txt-l" type="text"  id="searchKeyword" placeholder="검색어를 입력하세요"/>
		    <input class="btn-sch" type="button" onclick="pageCall(1)" value="검색"/>
	   	</form>
	   	
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
		var keyword = $('#searchKeyword').val(); // 검색어 여기 추가부터 리스트 안옴
        var opt = $('#searchOption').val(); // 검색옵션
		$.ajax({
			type:'GET',
			url:'memberList',
			data:{
				'page':page,
				'cnt':15,
				'opt': opt,
	            'keyword': keyword
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
			if (view.report_status == 'N') {
                content += '<td style="color: black;">'+view.id+'</td>';
            } else {
                content += '<td style="color: blue;">'+view.id+'</td>';
            }
			content += '<td><a href="adminMemberDetail?id='+view.id+'">'+view.nickname+'<a/></td>';
			content +='<td>'+view.email+'</td>';
			content +='<td><a  href="memberRight?nickname='+view.nickname+'" style="color: orange;">권한</a></td>';
			content +='<td>'+view.report_count+'</td>';
			content +='<td>'+view.join_date+'</td>';
			content +='</tr>';
		  }
	      $('#list').html(content);
	   }
 
    
	/* if (view.report_count < 1 || view.report_count == null || view.report_count == '') { */
    
</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>