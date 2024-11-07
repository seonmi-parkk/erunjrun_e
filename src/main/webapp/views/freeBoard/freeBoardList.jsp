<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>자유주제 게시판</title>
<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <script src="/resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="/resources/js/layerPopup.js"></script>
    <script src="/resources/js/rightLayerPopup.js"></script>
<style>
	a{
		color: #333;
	}
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
    
    /*운동프로필 레이어팝업*/
	#profilePopup {
	    width: fit-content;
	    top: 185px;
	    left: 50%;
	    transform: translateX(-50%);
		z-index: 996;
	}
	#profilePopup .close {
	    font-size: 40px;
	    font-weight: 300;
	    position: absolute;
	    z-index: 996;
	    top: 30px;
	    right: 30px;
	    display: inline-block;
	    width: 30px;
	    height: 30px;
	    line-height: 27px;
	    text-align: center;
	}
	#profilePopup .modal-content{
	    padding: 20px 20px;
	    background: #f8f8f8;
	    border: none;
    	border-radius: 0;
    }
    #PopupBody {
    	background: #fff;
    	border-radius: 10px;
    }
	   .profileDetail {
   	   position: relative;
   	   width: 760px;
       padding: 34px 50px 10px;
       height: 70vh !important;
   	   overflow-y: auto;
   }
    .profileDetail .user-info .user-name{
       font-size: 30px;
       margin-bottom: 0px;
   }
   .addr{
   	    transform: translateY(5px);
    	display: inline-block;
   }
    
    
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="inner">
	<p class="title1">자유주제 게시판</p>
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
				<th><p style="cursor:pointer; font-size: 18px;" onclick="sortBy('bHit')">조회수</p></th>
				<th><p style="cursor:pointer; font-size: 18px;" onclick="sortBy('likes')">추천수</p></th>
				<th><p style="cursor:pointer; font-size: 18px;" onclick="sortBy('create_date')">작성일</p></th>
			</tr>
		</thead>
		<tbody id="list" >
	
		</tbody>
		<tr>
			<th colspan="6">
				<div class="container">
		    		<nav aria-label="Page navigation">
		        		<ul class="pagination" id="pagination"></ul>
		        		<!-- onclick="location.href='runBoardWrite'" -->
						<div class="btn01-l" id="loginPop">게시글 등록</div>
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
	<jsp:include page="../footer.jsp"/>
</body>
<script>
	var show = 1;
	var paginationInitialized = false;
	var sortColumn = 'create_date'; // 기본 정렬 기준을 작성일로 설정
	var sortOrder = 'DESC'; // 기본 정렬 순서를 오름차순으로 설정
	
	pageCall(show);
	
	function sortBy(column) {
	    if (sortColumn === column) {
	        // 동일한 컬럼을 클릭하면 정렬 순서를 토글
	        sortOrder = sortOrder === 'ASC' ? 'DESC' : 'ASC';
	    } else {
	        // 새로운 컬럼 클릭 시 오름차순으로 시작
	        sortColumn = column;
	        sortOrder = 'ASC';
	    }
	    show = 1;
	    paginationInitialized = false;
	    pageCall(show);
	}
	
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
	        type: 'POST',
	        url: '/freeBoardList',
	        data: {
	            'page': page,
	            'cnt': 15,
	            'opt': option,  // 검색 옵션
	            'keyword': keyword,  // 검색어
	            'sortColumn': sortColumn, // 정렬 기준 추가
	            'sortOrder': sortOrder // 정렬 순서 추가
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
	// 게시글 리스트
	function drawList(resultList,page,keyword) {
		var content ='';
		resultList.forEach(function(view,idx){
			
            content += '<tr>';
            content +='<td>'+view.board_idx+'</td>';
			content +='<td ><a class="user" style=" cursor: pointer;"  data-id="' + view.id + '">'+view.nickname+'</a></td>';
			content +='<td><a href="/freeBoardDetail/'+view.board_idx+'">'+view.subject+'<a/></td>';
			content +='<td>'+view.bHit+'</td>';
			content +='<td>'+view.likes+'</td>';

	        // 날짜 부분만 추출
	        var dateOnly = view.create_date.split('T')[0];
	        content += '<td>' + dateOnly + '</td>';
	        content += '</tr>';

		});
		$('#list').html(content);
	}
			
	// 체크
	function secondBtn1Act() {
		// 두번째팝업 2번버튼 클릭시 수행할 내용
	 	console.log('두번째팝업 1번 버튼 동작');
	 	location.href='/loginView';
	 	removeAlert();
	 	}
	function secondBtn2Act() {
 	    // 두번째팝업 2번버튼 클릭시 수행할 내용
 	    console.log('두번째팝업 2번 버튼 동작');
 	    removeAlert();
 	}
		
	
	$('#loginPop').on('click',function(){
 		
 		var userId = "${sessionScope.loginId}";
 		
 		if(!userId){
 			layerPopup('로그인이 필요한 서비스 입니다.','로그인 페이지','닫기',secondBtn1Act,secondBtn2Act);		
 		}else if('${sessionScope.loginId}' == '${right.id}' && '${right.code_name}' == 'A100' && '${right.is_right}' == 'Y'){
 			rightLayerPopup('${right.end_date} 까지 정지된 서비스 입니다.','확인',secondBtn2Act);
 		}else{
 			location.href='freeBoardWrite';
 		}
 		
 	});
	 	
	 	
	 // 클릭시 운동프로필 레이어 팝업
		$(document).on('click','.user',function(){
		    var toUserId = $(this).data('id');
		   // console.log('toUserId',toUserId);
		    openProfile(toUserId);
		});
		
		
		// 운동프로필 레이어 팝업 열기
		function openProfile(toUserId){
			var modal = document.getElementById("profilePopup");
		    var PopupBody = document.getElementById("PopupBody");
			
		    // AJAX 요청
		    var xhr = new XMLHttpRequest();
		    xhr.open("GET", "/mate/"+toUserId, true);
		    xhr.onreadystatechange = function() {
		        if (xhr.readyState === 4 && xhr.status === 200) {
		            PopupBody.innerHTML = xhr.responseText; // 응답을 모달에 넣기
		            modal.style.display = "block"; // 모달 열기
		            
		         	// JS 파일을 동적으로 로드
		            var script = document.createElement('script');
		            script.src = '/resources/js/profileDetail.js'; 
		            document.body.appendChild(script);
		        }
		    };
		    xhr.send();
		}
		
		// 팝업 닫기
		/*
		document.getElementsByClassName("close")[0].onclick = function() {
		    document.getElementById("profilePopup").style.display = "none";
		};
		*/
		$(document).on('click','#profilePopup .close',function(){
		    document.getElementById("profilePopup").style.display = "none";
		});
	 	
	 	
	
	
	
	
	

</script>
</html>