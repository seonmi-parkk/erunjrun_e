<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Crew Chat List</title>
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
    
    #btn04-s{
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
    
     .profileBox{
    	margin-right: 10px;
    } 
	table td {
		vertical-align: middle;
	}
	
	/* 프로필 컨테이너 */
	table tbody tr td.profileContainer {
	   /*  display: block; */
	    align-items: center;
	    vertical-align: middle;
	    text-align: left;
    	margin-left: 60px;
	}   
	.crew-leader-chat .profile-name {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
	}
	.crew-leader-chat .profile-area{
    	width: 44px; height: 44px;
    	margin-right: 6px;
    	position: relative;
    }
    .crew-leader-chat .profile-box {
		position: absolute; top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		width: 44px; height: 44px;
		margin-right: 2px;
	}
	.crew-leader-chat .profile-img {
		position: absolute; top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		width: 33px; height: 33px;
		border-radius: 50%;
	}
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<div class="inner crew-leader-chat">
	<p class="title1" onclick="location.href='/crewManagerList/${crew_idx}'">크루장 1:1 채팅</p>
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
				<th>회원정보</th>
				<th>연령대</th>
				<th>성별</th>
				<th>일자</th>
				<th>채팅바로가기</th>
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
	<br/>
	<button class="btn02-m" onclick="location.href='/crewManagerList/${crew_idx}'">목록</button>
	
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
<script src="/resources/js/chatting.js" type="text/javascript"></script>
<script>
	var crew_idx = '${crew_idx}';
	console.log('crew_idx : ',crew_idx);

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
	
	    $.ajax({
	        type: 'GET',
	        url: '/crewLdchatList/full',
	        data: {
	        	'crew_idx' : crew_idx,
	            'page': page,
	            'cnt': 15,
	            'keyword': keyword  // 검색어
	        },
	        datatype: 'JSON',
	        success: function(response) {
	            console.log(response);
	            
	           console.log(response[0].totalpage);
	            
	           // var result = response.result;
	            
	            
	            var totalCount = response[0].totalpage;  // 총 게시글 수
	            var pageSize = 15;  // 한 페이지당 게시글 수
	            var totalPages = Math.ceil(totalCount / pageSize);  // 총 페이지 수 계산
	            console.log('총 페이지 수=> ', totalPages);
	            
	            
	            drawList(response);
	            
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
			//console.log('item.gender: ', item.gender);
			
			if(item.gender === '남'){
        		genderImg = '<img src="/resources/img/common/ico_male.png" width="9px" class="genderImg"/>';
        	}else{
        		genderImg = '<img src="/resources/img/common/ico_female.png" width="9px" class="genderImg"/>';
        	}
			
	        var birth = item.birth;
	        console.log("Birth value:", birth); // birth 값 확인
	        
	         // birth의 연도만 추출
	        var birthYear = parseInt(birth.split('-')[0], 10);
	        // 현재 연도에서 출생 연도를 빼고 나이대 계산
	        var ageGroup = Math.floor((new Date().getFullYear() - birthYear) / 10) * 10 + "대";

	        // 날짜만 추출
	        var createDateTime = item.create_date;
			var createDate = createDateTime.split('T')[0];
			var createDateList = createDate.split('-');
			console.log('createDateTime ',createDateTime);
			console.log('createDate ',createDate);
			console.log('createDataList ',createDateList);
			var createDateForm = createDateList[0]+'. '+createDateList[1]+'. '+createDateList[2];
	        
            content += '<tr>';
            content += '<td class="profileContainer"><div class="profile-name"><div class="profile-area">'; 	  	
            if(item.image != null){
            	content += '<div class="profile-img" style="background: url(/photo/'+item.image+') center center / cover no-repeat;"></div>';
            }else{  
            	content += '<div class="profile-img"  style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div>';
            }
            content += '<div class="profile-box" style="background: url(/resources/img/icon/'+item.icon_image+') center center / 100% 100% no-repeat;"></div></div>';
            content += '<span>'+item.nickname+'</span></div>';
            content += '</td>';
            
			content +='<td>'+ageGroup+'</td>';
			content +='<td>'+genderImg+ '&nbsp;' +item.gender+'</td>';
			content +='<td>'+createDateForm+'</td>'; // 신청일자
			content += '<td><button class="btn02-s" onclick="openCrewManagerChat(\'' + item.id + '\')">1:1 채팅</button></td>'; 
	        content += '</tr>';

		});
		$('#list').html(content);
	}
	
	 	$('#loginPop').on('click',function(){
	 		
	 		var userId = "${sessionScope.loginId}";
	 		
	 		if(!userId){
	 			layerPopup('로그인이 필요한 서비스 입니다.','로그인 페이지','닫기',secondBtn1Act,secondBtn1Act);	
	 		}else{
	 			location.href='runBoardWrite';
	 		}
	 		
	 	});
	 	
	 	
/* 	 // 클릭시 운동프로필 레이어 팝업
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
		
		// 팝업 취소
		function applBtn2Act() {
		    removeAlert(); 
		} */
		
		
		/* function memberResult(id, nickname, value) {
		    console.log('ID:', id);
		    console.log('Nickname:', nickname);
		    console.log('value:', value);
		    
			var crew_idx = 52; // 나중에 변경 필요
			var code_name = '';
			
			if(value === 'Y'){
				code_name = 'C101';
			}else{
				code_name = 'C102';
			}

			console.log('code_name : ', code_name);			
			console.log('실행됨>');
			
  			$.ajax({
				type: 'POST',
				url: '/crew/applicationWrite',
				data: {'loginId' : id,
					'crew_idx' : crew_idx,
					'code_name' : code_name},
				dataType: 'JSON',
				success: function(response){
					
					console.log('성공');
					
					if(response.success){
						removeAlert();
						layerPopup(response.msg + '완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
						pageCall(firstPage);
					}else{
						removeAlert();
						layerPopup(response.msg + '미완료되었습니다.', '확인',false,applBtn2Act,applBtn2Act);
					}
					
				},error: function(e){
					soncole.log('에러남 => ', e);
				}
			});  
			 
		    
		}*/
		
		


</script>
</html>