<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Crew Member List</title>
<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <script src="/resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="/resources/js/layerPopup.js"></script>
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
    	margin-top: 00px;
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
       height: fit-content !important;
   	   overflow-y: auto;
   }
    .profileDetail .user-info .user-name{
       font-size: 30px;
       margin-bottom: 0px;
   }

   .layoutbox-bt {
	    height: 90px; /* 하단 배너 영역의 높이를 90px로 설정 */
	    background-color: white; /* 배경색을 흰색으로 설정 */
	}
    
    .input-txt-l01{
    	width: 300px;
   	 	padding: 11px 8px;
    	height: 46px;
    }
    
  	
  	table thead tr th.thSize{
  		width: 550px;
  	}
  	
  	.headlayout{
  		margin-top : 140px;
  	}
  	
  	#crew_name{
  		font-size: 14px;
	    margin-bottom: 0px;
  	}
  	
  	.btn01-l{
	    margin-top: 31px;
  	}
	
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<input type="hidden" name="crew_idx" value="${crew_idx}"/>
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
<script>
	var firstPage = 1;
	var paginationInitialized = false;
	
	
	var loginId = '${sessionScope.loginId}';
	
    var crew_idx = $('input[name="crew_idx"]').val();
	
	$(document).ready(function () {
		pageCall(firstPage);
	    console.log('crew_idx =>', crew_idx);
	});
	
	// 검색 폼 제출 시 AJAX 호출
	$('#searchForm').on('submit', function(event) {
	    event.preventDefault();  // 폼 제출 기본 동작 중지
	    firstPage = 1;
	    paginationInitialized = false;
	    pageCall(firstPage);  // 검색어가 추가된 상태에서 호출
	});
	

	function pageCall(page) {
		var option = $('#searchOption').val();
	    var keyword = $('#searchKeyword').val();  // 검색어
	    
	    $.ajax({
	        type: 'POST',
	        url: '/crew/noticeList',
	        data: {
	        	'crew_idx' : crew_idx,
	            'page': page,
	            'cnt': 15,
	            'option': option,
	            'keyword': keyword  // 검색어
	        },
	        datatype: 'JSON',
	        success: function(response) {
	            console.log(response.result);
	            
	            if (response.length > 0) {
	                // response 배열로부터 데이터 리스트 접근
	            }
	            
	            var result = response.result;
	            
	            var totalCount = response.result[0].totalpage;  // 총 게시글 수를 서버에서 가져옴
	            var pageSize = 15;  // 한 페이지당 게시글 수
	            var totalPages = Math.ceil(totalCount / pageSize);  // 총 페이지 수 계산
	            console.log('총 페이지 수=> ', totalCount);
	            drawList(result);
	            
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
	function drawList(result) {
		var content ='';
		
		
		result.forEach(function(item,idx){
			var priority = item.priority; // 순위
			var noticeBtn = '';
			
			if(item.priority == 1 || item.priority == 2 || item.priority == 3){
				console.log('필독 1번 =>', item.notice_idx);
				noticeBtn = '<button class="btn02-s">필독공지</button>';
			}else{
				console.log('일반 공지');
				noticeBtn = item.notice_idx;
			}
			
			// 리더인지 체크해서 버튼 숨기고, 보이기
            if(loginId === item.id){
            	console.log('id : id', loginId, item.id);
            	$('.btn01-l').css('visibility', 'visible');
            }
			
			$('#crew_name').html('<a href="/crewDetail/' + item.crew_idx + '">' + item.crew_name + '</a>');
			
            content += '<tr>';
            
            content += '<td>'+noticeBtn+'</td>';
            content += '<td class="subjectTable"><a href="/crewNoticeDetail/'+item.notice_idx+'">'+item.subject+'</a></td>';
            content += '<td><a class="user" style=" cursor: pointer;"  data-id="' + item.id + '">'+item.nickname+'</a></td>';
            content += '<td>'+item.hit+'</td>';
            content += '<td>'+item.create_date+'</td>';
	        content += '</tr>';

		});
		$('#list').html(content);
	}
	
	// 팝업 취소
	function applBtn2Act() {
	    removeAlert(); 
	}
	
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
	document.getElementsByClassName("close")[0].onclick = function() {
	    document.getElementById("profilePopup").style.display = "none";
	};


</script>
</html>