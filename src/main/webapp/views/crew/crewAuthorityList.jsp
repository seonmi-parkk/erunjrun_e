<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Crew Authority List</title>
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
   .addr{
   	    transform: translateY(5px);
    	display: inline-block;
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
    
    .genderImg{
    	padding-bottom: 2px;
    }
    
    .btn04-s{
    	display: inline-block;
        height: 32px;
        padding: 6px 11px;
        margin: 0 4px;
        border-radius: 10px;
        border: 1px solid #6994FF;
        color: #6994FF;
        background: #fff;
        cursor: pointer;
        font-size: 14px;
    }
    
		/* 프로필 컨테이너 */
		table tbody tr td.profileContainer {
		    position: relative; /* 자식 요소의 절대 위치 기준으로 설정 */
		    display: flex; /* 수평 정렬을 위한 flex 설정 */
		    align-items: center; /* 수직 가운데 정렬 */
		    vertical-align: middle;
		    text-align: left;
		    margin-left: 60px;
		}
		
		/* 프로필 이미지 */
		.profileBox {
		    margin-right: 10px;
		    border-radius: 50%; /*프로필 둥글게*/
		}
		
		/* 아이콘 이미지 */
		.profile-box2 {
		    position: absolute;
		    top: -8px; /* profileBox와 같은 높이에 위치 */
		    left: 10px; /* profileBox 오른쪽에 배치 */
		    width: 44px;
		    height: 44px;
		    margin-right: 2px;
		    transform: translateY(50%); /* 필요 시 위치 조정 */
		} 
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<input type="hidden" name="crew_idx" value="${crew_idx}"/>
	<div class="inner">
	<p class="title1" onclick="location.href='/crewManagerList/${crew_idx}'">크루장 권한 기록</p>
	<form id="searchForm">
    <select id="searchOption">
        <option value="subject">닉네임</option>
    </select>
    <input class="input-txt-l01" type="text" id="searchKeyword" placeholder="검색어를 입력하세요"/>
    <input class="btn-sch" type="submit" value="검색"/>
</form>
	<table>
		<thead>
			<tr>
				<th>크루장</th>
				<th>크루원</th>
				<th>요청일자</th>
				<th>응답일자</th>
				<th>결과</th>
			</tr>
		</thead>
		<tbody id="list" >
	
		</tbody>
		<tr>
			<th colspan="5">
				<div class="container">
		    		<nav aria-label="Page navigation">
		        		<ul class="pagination" id="pagination"></ul>
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
	
	pageCall(firstPage);
	
	// 검색 폼 제출 시 AJAX 호출
	$('#searchForm').on('submit', function(event) {
	    event.preventDefault();  // 폼 제출 기본 동작 중지
	    firstPage = 1;
	    paginationInitialized = false;
	    pageCall(firstPage);  // 검색어가 추가된 상태에서 호출
	});
	

	function pageCall(page) {
	    var keyword = $('#searchKeyword').val();  // 검색어
	    var crew_idx = $('input[name="crew_idx"]').val(); // 나중에 변경 필요
		console.log('실행은?');
	    $.ajax({
	        type: 'POST',
	        url: '/crew/applicationAdminList',
	        data: {
	        	'crew_idx' : crew_idx,
	            'page': page,
	            'cnt': 15,
	            'keyword': keyword  // 검색어
	        },
	        datatype: 'JSON',
	        success: function(response) {
	            console.log(response.result);
	            
	            console.log(response.result.totalpage);
	            
	            var result = response.result;
	            
	            
	            var totalCount = response.result[0].totalpage; // 총 게시글 수를 서버에서 가져옴
	            var pageSize = 15;  // 한 페이지당 게시글 수
	            var totalPages = Math.ceil(totalCount / pageSize);  // 총 페이지 수 계산
	            console.log('총 페이지 수=> ', totalPages);
	            
	            
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
		var btn = '';
		result.forEach(function(item,idx){
			
			if(item.is_agree === 'Y'){
				btn = '<button class="btn02-s">수락</button>';
			}else if(item.is_agree === 'N'){
				btn = '<button class="btn04-s">거절</button></td>';
			}else{
				btn = '<button class="btn04-s">대기</button></td>';
			}
			
			if(item.update_date === null){
				item.update_date = '없음';
			}
			
			var member_profileImg = '';
			var leader_profileImg = '';
	        var member_icon_img = '';
	        var leader_icon_img = '';
	        
	        if(item.member_image != null && item.member_image != ''){
				member_profileImg = '/photo/'+item.member_image;
			}else{
				member_profileImg = '/resources/img/common/profile.png';
			}
	        
	        if(item.leader_image != null && item.leader_image != ''){
				leader_profileImg = '/photo/'+item.leader_image;
			}else{
				leader_profileImg = '/resources/img/common/profile.png';
			}
	        
			if(item.member_icon_image != null && item.member_icon_image !== ''){
				member_icon_img = 'background: url(/resources/img/icon/' + item.member_icon_image + ') center center / 100% 100% no-repeat;';
			}
			
			if(item.leader_icon_img != null && item.leader_icon_img !== ''){
				leader_icon_img = 'background: url(/resources/img/icon/' + item.leader_icon_img + ') center center / 100% 100% no-repeat;';
			}
            
            // 프로필 + 닉네임 (나중에 연결 필요)
            content +='<td class="profileContainer"><img src="'+member_profileImg+'" width="32px" class="profileBox"/>'
            + '<div class="profile-box2" style="' + member_icon_img + '"></div>'
            + '<a class="user" style="cursor: pointer;"  data-id="' + item.member_id + '">'
            +item.member_nickname+'</a></td>';
            content +='<td class="profileContainer"><img src="'+leader_profileImg+'" width="32px" class="profileBox"/>'
            + '<div class="profile-box2" style="' + leader_icon_img + '"></div>'
            + '<a class="user" style="cursor: pointer;"  data-id="' + item.leader_id + '">'
            +item.leader_nickname+'</a></td>';
            
			content +='<td>'+item.create_date+'</td>'; // 신청일자
			content +='<td>'+item.update_date+'</td>'; // 응답일자
			content += '<td>'+btn+'</td>';
	        content += '</tr>';

		});
		$('#list').html(content);
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