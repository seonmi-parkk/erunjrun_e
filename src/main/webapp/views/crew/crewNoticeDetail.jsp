<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crew Notice Detail</title>   
    <link rel="stylesheet" href="/resources/css/common.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d&libraries=services"></script>
	<script src="/resources/js/common.js"></script>
	<script src="/resources/js/layerPopup.js"></script>
	
    <style>
    	.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
		.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
		.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
		.number {font-weight:bold;color:#ee6152;}
		.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
		.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
		.distanceInfo:after {content:none;}
		
		.label {
	    color: #333; /* 텍스트 색상 */
	    font-weight: bold; /* 굵게 */
	    font-size: 14px; /* 폰트 크기 */
	    margin-right: 5px; /* 오른쪽 여백 */
		}
    
    
    	a{
    		color: #333;
    	}
        #dori {
            width: 1280px;          /* 박스의 너비 설정 */
            /* 박스의 높이 설정 */
            border: 1px solid #EAEAEA;  /* 연한 회색(#d3d3d3) 선 설정 */
            background-color: transparent;
            margin: 80px auto 0;
            border-radius: 15px;
        }
        #title3{
        	font-size: 16;
        }
        .rectangle-250, .rectangle-250 * {
			box-sizing: border-box;
		}
		.rectangle-250 {
			display: flex;
    		justify-content: space-between;
			background: #ffffff;
			border-style: solid;
			border-color: #bdbdbd;
			border-width: 0px 0px 1px 0px;
			position: relative;
			margin: 40px;
			margin-top: 10px;
		}
		.duri{
			margin: 15px;
		}
		.title1{
    		margin-top: 160px;
    		margin-left: 10px;
    	}
    	.dari{
    		margin-top: 45px;
    	}
    	.title2{
			transform: translateY(0px);
			font-weight: 700;
    		font-size: 24px;
    		margin-top: -25px;
    		margin-bottom: 25px;
   			font-family: "Pretendard Variable", Pretendard;
    	}
    	.ori{

			  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  
    	}
    	#butt{
    		transform: translateY(-35px);
    	}
    	.repo{
    		  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;

    	}
    	#pre{
    		margin-left: 565px;
    		    margin-bottom: 30px;
    	}
    	#reo{
    		border-color: #AAAAAA;
    	}
    	.com{
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 1px 1px 1px 1px;
			  position: relative;
			  margin: 40px;
			  display: flex;
			  padding: 20px;
			  border-radius: 15px;
			  justify-content: space-between;
    	}
    	#title2-1{
    		margin-left: 0px;
    	}
    	.colist{
    		  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;
    	}
		.sort{
			background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;
			  justify-content: space-between;
			  min-height: 120px;
			  
		}
		#con{
			width: 1200px;
			font-size: 16;
			min-height: 250px;
		}
		.dat {
			display: flex;
			justify-content: space-between;
		}
		
		.detail{
			    margin-left: 35px;
		}
		#bih{
			margin-top: -50px;
		}
		
		.nick{
			margin-left: 18;
   		 	margin-bottom: 7px;
   		 	transform: translate(10px, -2px);
		}

		.date{
			margin-left: 50;
			margin-top: 10px;
		}
		
		.supa{
			margin-left: 60px;
   		 	margin-top: -20px;
		}
		.coco{
			width: 1000;
   		 	margin-left: 50px;
		}
		#ins{
			margin-left: -28px;
			margin-top: 34px;
		}
		input[type="text"].tex{
    		margin-left: 30px;
    		width: 1000px;
		}
		.bubu{
			display: flex;
			justify-content: space-between;
			margin: 17px;
		}
		.suj1{
			  background: #eeeeee;
			  border: solid 1px;
			  border-color: AEAEAE;
			  text-align: center;
			  margin-top: 5px;
		}
		.suj2{
			  background: #eeeeee;
			  border: solid 1px;
			  border-color: AEAEAE;
			  text-align: center;
			  
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
	    
	   .layoutbox-bt {
		    height: 90px; /* 하단 배너 영역의 높이를 90px로 설정 */
		    background-color: white; /* 배경색을 흰색으로 설정 */
		}
		
		#content{
		    min-height: 500px;
		}
		
		.title21{
			font-size: 18px;
			font-family: "Pretendard Variable", Pretendard;
			font-weight: 500;
		    margin-right: 5px;
		}
		
		#comment{
			margin-left: 10px;
		}
		
		/* 프로필 이미지 원처리 */
		#profileImg{
	   		border-radius: 70%;
   			overflow: hidden;
   			margin-right : 13px;
		}
		
		
		/*신고 레이어팝업*/
		#reportPopup {
		    width: fit-content;
		    top: 130px;
		    left: 50%;
		    transform: translateX(-50%);
			z-index: 996;
			
		}
		#reportPopup .dis {
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
		#reportPopup .modal-content{
		    padding: 20px 20px;
		    background: #f8f8f8;
		    border: none;
	    	border-radius: 0;
	    }
	    #reportPopupBody {
	    	background: #fff;
	    	border-radius: 10px;
	    }
	    
	    .profile-box2 {
			position: absolute; top: 97px; left: 15px;
			transform: translate(-50%, -50%);
			width: 44px; height: 44px;
			margin-right: 2px;
		}
		.title3-1{
		
		}

		
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <input type="hidden" name="notice_idx" value="${notice_idx}"/>
	<div class="inner">
		<p class="title1">크루 공지사항</p>
		
		<div id="dori">
			<div class="rectangle-250">
				<div class="dari">
					<p class="title2" id="subject"></p>
					<div class="title3-1" id="leader">
						<img alt="profileImg" src="/resources/img/common/profile.png" onerror="this.src='/resources/img/common/profile.png'" id="profileImg" width = 30px;>
						<div class="profile-box2"></div>
						<span id="leaderId"></span>
					</div>
				</div>
				<div style="text-align: right;" class="duri">
				
					<div id="butt" class="btn03-s" style='visibility : hidden'>비활성화</div>					
					<p class="title3-2" id="create_date"></p>
					<span class="title3-3" >조회수 </span><span id="hit"></span>
					<!-- todo - 댓글 수 카운트해서 가져와야 함! -->
					<span class="title3-4"><img src="/resources/img/run/image 14.png" id="comment" alt="댓글"> 댓글 2</span>
				</div>
			</div>
			<div class="ori">
				<div id="content"></div>
			</div>
			
	    	<div class="supa">
		    	<span id="title2-1" class="title21">등록순</span>
	    		<span id="title2-2" class="title21">최신순</span>
	    	</div>
	    	
	    	<!-- 댓글 리스트 -->
	    	<div id="list"> </div>
	   		
	    	<div class="com">
	    		<div>
	    			<input type="hidden" name="unlike_id" value="${sessionScope.loginId}"/>
	    			<div class="nick" id="name"></div>
		    		<input type="text" class="tex">
	    		</div>
	    		<div>
	    			<div id="ins" class=btn01-s onclick="comment()">등록</div>	    		
	    		</div>
	    	</div>
	    </div>
	    <div class="bubu">
	    	<div class="bbs"> <!-- -->
			    <button type="button" class="btn01-m"  style='visibility : hidden' onclick="location.href='/crewNoticeUpdate/${notice_idx}'">수정</button>
			    <button type="button" class="btn03-m"  style='visibility : hidden' id="btn-popup"  onclick="layerPopup('공지를 삭제하시겠습니까?', '삭제', '취소', crewNoticeDelete ,applBtn2Act)">삭제</button>	
	    	</div>
		    <button type="button" class="btn02-m"  onclick="crewNoticeListView()" >목록</button>
	    </div>
	    
	    
		<!-- 모달 -->
		<div id="profilePopup" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div id="PopupBody"></div>
		    </div>
		</div>
		
		<!-- 신고페이지 모달 -->
		<div id="reportPopup" class="modal">
		    <div class="modal-content">
		        <span class="dis">&times;</span>
		        <div id="reportPopupBody"></div>
		    </div>
		</div>
		
		
		
		
	</div>
	<div class="layoutbox-bt"></div>
	
    <jsp:include page="../footer.jsp" />

    
</body>
<script>

	var notice_idx = $('input[name="notice_idx"]').val();
	var loginId = '${sessionScope.loginId}';
	var crew_idx = '';

	$.ajax({
		type: 'POST',
		url: '/crew/noticeDetail',
		data: {'notice_idx' : notice_idx},
		dataType: 'JSON',
		success: function(response){
			console.log('데이터 잘 받아옴 => ', response);
			console.log('닉네임 잘 받아옴 => ', response.nickname);
			
			var result = response.result;
			crew_idx = result.crew_idx;
			var nickName = response.nickname
			
			$('#subject').html(result.subject);
			
			if(result.image != null && result.image != ''){
				$('#profileImg').attr('src', '/photo/'+result.image);
				
			}
			if(result.icon_image != null && result.icon_image !== ''){
				$('.profile-box2').css({
				    'background': 'url(/resources/img/icon/' + result.icon_image + ') center center / 100% 100% no-repeat'
				});
			}

 			$('#leaderId').html('<a class="user" style="cursor: pointer;"  data-id="' + result.id + '">' + result.nickname + '</a>'); 
			$('#content').html(result.content);
			$('#hit').html(result.hit);
			$('#create_date').html(result.create_date);
			
			$('#name').html('<img style="height: 30;" src="/resources/img/run/running_8421565.png" alt="아이콘">'+nickName.nickname);
			
			if(loginId === result.id){
				console.log('같은데?');
				$('.btn01-m').css('visibility', 'visible');
				$('.btn03-m').css('visibility', 'visible');
			}
			
			console.log('loginId : id', loginId, result.id);
		},error: function(e){
			console.log('받아오던 중 에러 => ', e);
		}
	});
	
	function crewNoticeDelete(){
		
		console.log('삭제 실행');
		
		$.ajax({
			type: 'DELETE',
			url: '/crew/noticeDelete',
			data: {'notice_idx' : notice_idx},
			dataType: 'JSON',
			success: function(response){
				if(response.success){
					removeAlert();
	            	layerPopup('공지사항이 삭제되었습니다.', '확인',false, locationHref ,locationHref);
				}
			},error: function(e){
				removeAlert();
				console.log('삭제 중 에러 => ', e);
			}
		});
	}
	
	function locationHref(){
		location.href="/crewNoticeList/"+crew_idx;
	}
	
	function crewNoticeListView(){
		location.href='/crewNoticeList/'+crew_idx;
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
	
	commentCall();
	
	function commentCall() {
		
		var notice_idx = $('input[name="notice_idx"]').val();
		console.log("공지사항 no :",notice_idx);
		
		$.ajax({
        	type: "POST",
            url: "/crewComment/" + notice_idx ,
            data: { 'notice_idx': notice_idx },
            datatype: 'JSON',
            success: function(data) {
                console.log('댓글 불러오기');
                commentDraw(data.list);
            },
            error: function(error) {
               console.log('댓글 못 불러오기');    
            }
        });
		
	}
 	
	function commentDraw(list) {
		
		var content ='';
		list.forEach(function(view,idx){
			var nickName = $('#name').text();
			var addName = view.nickname;
			var id = view.id
			console.log('아이디나오냐',id);
			var comment_idx = view.comment_idx;
			
			
			content +='<div id="sort-area">';
			content +='<input type="hidden" name="user_id" value="'+id+'"/>';
			content +='<div class="sort" id="sort-update'+comment_idx+'">';
			content +='<div>';
			content +='<div class="nick"><img style="height: 30;" src="/resources/img/run/running_8421565.png" alt="아이콘">'+view.nickname+'</div>';
			if(view.use_yn == 'N'){
				content +='<p class="coco" style="color: #999;" >(삭제된 댓글 입니다.)</p>';
			}else{
				content +='<p class="coco">'+view.content+'</p>';
			}
			content +='<div class="date">'+view.create_date+'</div>';
			content +='</div>';
			if(view.use_yn == 'Y'){
				content +='<div class="ard" id="dis">';					
				content +='<div class="detail" style=" cursor: pointer;" onclick="toggleActions(' + comment_idx + ')"><img style="height: 5; margin-top: 25px;" src="/resources/img/run/Group 308.png" alt="상세"></div>';
				content +='<div id ="bih" class=btn03-s>비활성화</div>';
				content += '<div class="action-buttons" style="display:none; cursor: pointer;" id="actions-' + comment_idx + '">';
				if(nickName == addName){
					content +='<div class="suj1 btn-popup" style=" cursor: pointer;" onclick="update('+comment_idx+')"  >수정</div>';
					content +='<div class="suj2 btn-popup" style=" cursor: pointer;" onclick="del('+comment_idx+')">삭제</div>';
				}else{
					content +='<div id="sin" style="margin-top: 5px;" data-comment_idx="'+comment_idx+'" onclick="report('+comment_idx+')" style=" cursor: pointer;" class="suj2 btn-popup"  >신고</div>';
				}
				
			}
			content += '</div>';
			content +='</div>';
			content +='</div>';
			content +='</div>';
		});
		$('#list').html(content);
	}
	
	function toggleActions(comment_idx) {
	    $('#actions-' + comment_idx).toggle(); // 버튼 표시/숨김 토글
	}
	
	function comment() {
		
		var content = $('input[class="tex"]').val();
		console.log('댓굴 내용 : ',content);
		var notice_idx = $('input[name="notice_idx"]').val();
		var nickname = $('#name').text();
		
		$.ajax({
			type:'POST',
			url:'/noticeComment',
			data:{'notice_idx':notice_idx, 
				'content':content, 
				'nickname':nickname},
			dataType:'JSON',
			success:function(data){
				console.log('댓글 등록',data);
				commentCall();
			},
			error:function(e){
				console.log('댓글 등록 오류',e);
			}
		})
		
	}
	
	function update(comment_idx) {
		
		console.log('댓글no : ',comment_idx);
		
		var commentContent = $("#sort-update" + comment_idx + " .coco").text();
		console.log('눌렀을때 나와?',commentContent);
		var commentAuthor = $("#sort-update" + comment_idx + " .nick").text();
		var commentDate = $("#sort-update" + comment_idx + " .date").text();

			 // 댓글 내용, 작성자, 날짜를 포함한 편집 필드 생성
		var editField = '<div class="edit-container">';
			  editField += '<input type="text" class="tex" value="' + commentContent + '" id="editContent' + comment_idx + '" style="width:800px;" />';
			  editField += '<button class="btn01-s" onclick="saveComment(' + comment_idx + ')">저장</button>';
			  editField += '<button class="btn03-s" onclick="commentCall();">취소</button>';
			  editField += '</div>';

	    // 기존 댓글을 숨기고 편집 필드를 삽입
	    $("#sort-update" + comment_idx + " .coco").html(editField);
				
	}
	
	function saveComment(comment_idx) {
		 // 수정된 댓글 내용 가져오기
		 console.log('선택한 댓글번호 : ',comment_idx);
	    var updatedContent = $("#editContent" + comment_idx).val();
		 console.log('수정내용 : ',updatedContent);
		 var nickname = $('.nick').text();

	    // AJAX 요청으로 수정된 내용 서버에 전송
	    $.ajax({
	        type: 'POST',
	        url: '/updateNoticeComment',  // 서버의 댓글 수정 처리 경로
	        data: JSON.stringify({ comment_idx: comment_idx, content: updatedContent ,nickname:nickname}),
	        contentType: 'application/json',
	        dataType: 'JSON',
	        success: function(data) {
	            if (data.success) {
	            	// 불러오기
	            	commentCall();
	            }	               
	        },
	        error: function(error) {
	            console.log("댓글 수정 오류:", error);
	            alert("오류가 발생했습니다.");
	        }
	    });
	}
	
	
	function del(comment_idx) {
		
		console.log('크루댓글삭제버튼 : ',comment_idx);
		
		$.ajax({
	        type: 'POST',
	        url: '/noticeCommentDel/'+comment_idx,  // 서버의 댓글 삭제 처리 경로
	        contentType: 'application/json',
	        dataType: 'json',
	        success: function(data) {
	            if (data.success) {
	                // 삭제 성공 시 댓글을 "삭제된 댓글입니다."로 업데이트
	                $("#sort-update" + comment_idx + " .coco").text("(삭제된 댓글입니다.)");
	                // 수정, 삭제, 신고 버튼 숨기기
	                $("#sort-update" + comment_idx + " .ard").hide();
	                
	            } 
	        },
	        error: function(error) {
	            console.log("댓글 삭제 오류:", error);
	            alert("오류가 발생했습니다.");
	        }
	    });
	}
	
	// 크루 댓글 신고
	function report(comment_idx) {
	 		layerPopup('정말 신고 하시겠습니까?','신고','취소' ,function (){secondBtn4Act(comment_idx)} , applBtn2Act);
	}
	
	
	
	
	function secondBtn4Act(comment_idx) {
 		// 두번째팝업 4번버튼 클릭시 수행할 내용
 	    console.log('두번째팝업 4번 버튼 동작');
 	   
 	    console.log('동작시 가ㅣ고외?',comment_idx);
 	   	notice(comment_idx);
 	    removeAlert();
 	}
	
	
	
	
	function notice(comment_idx){
		
		var modal = document.getElementById("reportPopup");
	    var PopupBody = document.getElementById("reportPopupBody");
	    var userId = '${sessionScope.loginId}';
	    
		console.log('가지고와번호?',comment_idx);
		console.log('가지고와? 아이디',userId);
	    // AJAX 요청 데이터 넣을때 해당 게시판 idx 값 넣기!!!!
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "/notice/"+comment_idx, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            PopupBody.innerHTML = xhr.responseText; // 응답을 모달에 넣기
	            modal.style.display = "block"; // 모달 열기
	            
	         	// JS 파일을 동적으로 로드
	         	
	            var script = document.createElement('script');
	            script.src = '/resources/js/reportNoticeComment.js'; 
	            document.body.appendChild(script);
	            
	        }
	    };
	    xhr.send();
	}
	
	// 팝업 닫기
	document.getElementsByClassName("dis")[0].onclick = function() {
	    document.getElementById("reportPopup").style.display = "none";
	};	
	
	
	// 관리자 세션 체크! 
	var authority = '${sessionScope.authority}';
	if(authority){
		if(loginId){
			$('#butt').css('visibility', 'visible');
		}
	}


</script>
</html>
