<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기 게시판</title>
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
    	margin-top: 160px;
    	transform: translateY(-28px);
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
   .layoutbox-bt {
    height: 90px;
    background-color: white;
}
    
    
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="inner">
	
	<p class="title1">문의하기 게시판</p>
	<table>
		<thead>
			<tr>
				<th>글번호</th>
				<th>카테고리</th>
				<th>작성자</th>
				<th>제목</th>
				<th>처리결과</th>
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
	
	<div class="layoutbox-bt"></div>
	<jsp:include page="../footer.jsp"/>
</body>
<script>
	var show = 1;
	var paginationInitialized = false;
	
	pageCall(show);
	

	
	function pageCall(page) {

	    $.ajax({
	        type: 'POST',
	        url: 'askBoardList',
	        data: {
	            'page': page,
	            'cnt': 15
	        },
	        datatype: 'JSON',
	        success: function(data) {
	            console.log(data.resultList);
	            var totalCount = data.totalpages;  // 총 게시글 수를 서버에서 가져옴
	            var pageSize = 15;  // 한 페이지당 게시글 수
	            var totalPages = Math.ceil(totalCount / pageSize);  // 총 페이지 수 계산
	            console.log('총 페이지 수',totalPages);
	            
	            drawList(data.resultList);
	            
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
	            console.log("더 노력해라 ",e);
	        }
	    });
	}
	// 게시글 리스트
	function drawList(resultList) {
		var content ='';
		resultList.forEach(function(view,idx){
			// 글번호 카테고리 작성자 제목 처리결과
            content += '<tr>';
            content +='<td>'+view.ask_idx+'</td>';
            if(view.code_name == 'Q100'){
            	content +='<td>크루</td>';
            }else if(view.code_name == 'Q101'){
            	content +='<td>러닝메이트</td>';
            }else if(view.code_name == 'Q102'){
            	content +='<td>게시글</td>';
            }else if(view.code_name == 'Q103'){
            	content +='<td>회원</td>';
            }else if(view.code_name == 'Q104'){
            	content +='<td>기타</td>';
            }
            
			content +='<td ><a class="user" data-id="' + view.id + '">'+view.nickname+'</a></td>';
			
			if(loginId == view.id || ${sessionScope.adminYn == 'Y'}){
				content +='<td><a href="/askBoardDetail/'+view.ask_idx+'">'+view.subject+'<a/></td>';
			}else{
				content +='<td>'+view.subject+'</td>';
			}
			
			if(view.is_ask == 'N'){
				content +='<td style="color : red;">미완료</td>';
			}else{
				content +='<td style="color : green;">답변완료</td>';
			}
			

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
		// 로그인 페이지로 이동하기 넣어주기!!!!!!!!
		location.href="/loginView";
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
	 		}else{
	 			location.href='/askBoardWrite';
	 		}
	 		
	 	});
	 	
	 	
	
	 	
	 	
	
	
	
	
	

</script>
</html>