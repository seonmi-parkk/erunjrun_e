<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	#searchForm {
        float: right;
        margin: 10px;
    }
    .btn01-l{
    	float: right;
    	margin: -80px -80px;	
    }
	.container{
		margin-top: 18px;
	}
	.highlight {
    	background-color: FFEADE;
    	
    }
    .tag-l-bd{
    	margin-left: 51px;
    	background-color: #FB7E3A;
    	color: #fff;
    }
    .title1{
    	margin-top: 160px;
    }
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="inner">
	<p class="title1">러닝코스 게시판</p>
	<form id="searchForm">
    <select id="searchOption">
        <option value="subject">제목</option>
        <option value="nickname">작성자</option>
        <option value="content">내용</option>
    </select>
    <input class="input-txt-l" type="text" id="searchKeyword" placeholder="검색어를 입력하세요"/>
    <input class="btn-sch" type="submit" value="검색"/>
</form>
	<table>
		<thead>
			<tr>
				<th>글번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>조회수</th>
				<th>추천수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody id="list" >
	
		</tbody>
		<tr>
			<th colspan="6">
				<div class="container">
		    		<nav aria-label="Page navigation">
		        		<ul class="pagination" id="pagination"></ul>
						<div class="btn01-l" onclick="location.href='runBoardWrite'">게시글 등록</div>
		    		</nav>
				</div>
			</th>
		</tr>
	</table>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
<script>
	var show = 1;
	var paginationInitialized = false;
	
	pageCall(show);
	
	// 검색 폼 제출 시 AJAX 호출
	$('#searchForm').on('submit', function(event) {
	    event.preventDefault();  // 폼 제출 기본 동작 중지
	    show = 1;
	    paginationInitialized = false;
	    pageCall(show);  // 검색어가 추가된 상태에서 호출
	});
	

	function pageCall(page) {
	    var option = $('#searchOption').val();  // 검색 옵션 (제목, 작성자, 내용)
	    var keyword = $('#searchKeyword').val();  // 검색어
	
	    $.ajax({
	        type: 'GET',
	        url: 'runBoardList',
	        data: {
	            'page': page,
	            'cnt': 15,
	            'opt': option,  // 검색 옵션
	            'keyword': keyword  // 검색어
	        },
	        datatype: 'JSON',
	        success: function(data) {
	            console.log(data.resultList);
	            var totalCount = data.totalpages;  // 총 게시글 수를 서버에서 가져옴
	            var pageSize = 15;  // 한 페이지당 게시글 수
	            var totalPages = Math.ceil(totalCount / pageSize);  // 총 페이지 수 계산
	            console.log('총 페이지 수',totalPages);
	            
	            drawList(data.resultList,page,keyword);
	            
	            if(!paginationInitialized || keyword !== ''){
	            	$('#pagination').twbsPagination('destroy');
		            $('#pagination').twbsPagination({
		                startPage: page,
		                totalPages: totalPages,
		                visiblePages: 10,
		                initiateStartPageClick: false,
		                onPageClick: function(evt, page) {
		                    console.log('evt', evt);
		                    console.log('page', page);
		                    pageCall(page);
		                }
		            });
		            paginationInitialized = true;
	            }
	        },
	        error: function(e) {
	            console.log(e);
	        }
	    });
	}

	function drawList(resultList,page,keyword) {
		var content ='';
		resultList.forEach(function(view,idx){
			
			if (page == 1 && !keyword && idx < 3) {
                content += '<tr class="highlight">';
                content += '<td><div class="tag-l-bd">추천코스</div></td>';
            } else {
                content += '<tr>';
                content +='<td>'+view.board_idx+'</td>';
            }
			
			content +='<td>'+view.nickname+'</td>';
			content +='<td><a href="detail.go?idx='+view.board_idx+'">'+view.subject+'<a/></td>';
			content +='<td>'+view.bHit+'</td>';
			content +='<td>'+view.likes+'</td>';

	        // 날짜 부분만 추출
	        var dateOnly = view.create_date.split('T')[0];
	        content += '<td>' + dateOnly + '</td>';
	        content += '</tr>';
		});
		$('#list').html(content);
	}
	

</script>
</html>