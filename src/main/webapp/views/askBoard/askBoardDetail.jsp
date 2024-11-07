
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의하기 게시글 상세보기</title>   
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
        .rectangle-250,
			.rectangle-250 * {
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
		}
		.duri{
			margin: 15px;
			margin-top: 117px;
		}
		.title1{
    		margin-top: 160px;
    		margin-left: 10px;
    		
    	}
    	.dari{
    		margin-top: 45px;
    	}
    	.title2-3{
			transform: translateY(-25px);
			font-weight: 700;
    		font-size: 24px;
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
   		 	display: flex;
    		align-items: center;
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
		
		/*신고 레이어팝업*/
		#reportPopup {
		    width: fit-content;
		    top: 130px;
		    left: 50%;
		    transform: translateX(-50%);
			z-index: 996;
			
		}
		#reportPopup .close {
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
	    
	    #dori .profile-area{
    	width: 44px; height: 44px;
    	position: relative;
	    }
	    #dori .profile-box {
			position: absolute; top: 50%; left: 50%;
			transform: translate(-50%, -50%);
			width: 44px; height: 44px;
			margin-right: 2px;
		}
		#dori .profile-img {
			position: absolute; top: 50%; left: 50%;
			transform: translate(-50%, -50%);
			width: 33px; height: 33px;
			border-radius: 50%;
		}
		.are{
			display: flex;
			align-items: flex-end;
		}
		
		 .label {
	    color: #333; /* 텍스트 색상 */
	    font-weight: bold; /* 굵게 */
	    font-size: 14px; /* 폰트 크기 */
	    margin-right: 5px; /* 오른쪽 여백 */
		}
		
		#tagFilters1{
    		display: flex;
    	}
    	#tagFilters1 label {
		display: -moz-box; display: -ms-flexbox; display: flex;
		-webkit-box-pack: space-between; -ms-flex-pack: space-between; justify-content: space-between;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;  
	 	padding: 5px 14px;
	 	width: fit-content;
    	height: 38px;
    	line-height: 38px;
   	 	position: relative;
    	border-radius: 100px;
    	border: 1px solid rgba(0,0,0,0.07);
	 	margin-right: 15px;
	  	font-size: 16px;
	}

		
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <input type="hidden" name="board_idx"/>
	<div class="inner">
		<p class="title1">문의하기 게시글</p>
		
		<div id="dori">
			<div class="rectangle-250">
				<div class="dari">
				<span id="tagFilters1">
					
					<c:choose>
						<c:when test="${info.code_name == 'Q100'}">
							<label style="margin-top: -56px;">크루</label>
			    		</c:when>
			    		<c:when test="${info.code_name == 'Q101'}">
							<label style="margin-top: -56px;">러닝메이트</label>  
			    		</c:when>
			    		<c:when test="${info.code_name == 'Q102'}">
							<label style="margin-top: -56px;">게시글</label>
			    		</c:when>
			    		<c:when test="${info.code_name == 'Q103'}">
							<label style="margin-top: -56px;">회원</label>  
			    		</c:when>	    		
			    		<c:otherwise>
			    			<label style="margin-top: -56px;">기타</label> 	    				
						</c:otherwise>
		    		</c:choose>
						
					</span><br>
				
				
				<p class="title2-3">${info.subject}</p>
					<div class="are">
						 <div class="profile-area">
						 <div class="profile-img" style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div><div class="profile-box" style="background: url(/resources/img/icon/${info.icon_image}) center center / 100% 100% no-repeat;"></div></div>
						  <p class="title3-1">
						  ${info.nickname}
					  	  </p>
						</div>
				</div>
				<div style="text-align: right;" class="duri">					
					<p class="title3-2">${info.create_date}</p>
					
				</div>
			</div>
			<div class="ori">
				
				<br>
				<div id="con">${info.content}</div>
			</div>
	    	<div class="repo">
	    			    		    	
	    	</div>
	    	<div class="supa">

	    	</div>
	    	<div id="list">

    		 </div>
    		<c:if test="${sessionScope.adminYn == 'Y'}">   		
		    	<div class="com">
		    		<div>
		    			<div class="nick">
	    				<div class="profile-area">
							<div class="profile-img" style="background: url(/resources/img/common/admin_profile.png) center center / cover no-repeat;"></div><div class="profile-box" style="background: url(/resources/img/icon/${nickname.icon_image}) center center / 100% 100% no-repeat;"></div></div>
	    			   	${sessionScope.loginId}
	    				</div>
		    			
			    		<input type="text" class="tex">
		    		</div>
		    		<div>
		    			<div id="ins" class=btn01-s onclick="comment()">등록</div>	    		
		    		</div>
		    	</div>
    		</c:if> 
	    	
	    </div>
	    <div class="bubu">
	    	<div class="bbs">
	    	
	    		<c:if test="${sessionScope.loginId == info.id || sessionScope.adminYn == 'Y'}">
	    		<c:if test="${info.is_ask != 'Y'}">
	    			<button type="button" id="upda" class="btn01-l" onclick="location.href='/askBoardUpdate/${info.ask_idx}'">수정</button>
	    		</c:if>
	    		<c:if test="${sessionScope.adminYn == 'Y'}">
	    			<button type="button" class="btn03-l btn-popup" >삭제</button>
	    		</c:if>        			    	    	    	
	    		</c:if>
	    		
	    	</div>
	    	
		    <c:if test="${sessionScope.adminYn == 'Y'}">
		    	<button type="button" class="btn01-l" style="margin-left: 820px;" onclick="location.href='/adminAsk'" >돌아가기</button>
		    </c:if>
		    
		    <button type="button" class="btn02-l"  onclick="location.href='/askBoard'" >목록</button>
	    </div>
	    
	    
	    
	
	</div>
    <jsp:include page="../footer.jsp" />

    
</body>
<script>

	 	
	 	/* 레이어팝업 */

	 	function secondBtn1Act() {
	 	    // 두번째팝업 1번버튼 클릭시 수행할 내용
	 	    
	 	    var board_idx = "${info.ask_idx}";
	 	    
	 	    console.log('두번째팝업 1번 버튼 동작');
	 	    
	 	   $.ajax({
               type: "POST",
               url: "/askBoardDelete/" + board_idx ,
               data: { board_idx: board_idx },
               success: function(response) {
                   if (response.success) {
                       location.href = "/askBoard";
                   } else {
                       alert("삭제에 실패했습니다.");
                   }
               },
               error: function(error) {
                   alert("오류가 발생했습니다.");
               }
           });
	 	}

	 	function secondBtn2Act() {
	 	    // 두번째팝업 2번버튼 클릭시 수행할 내용
	 	    console.log('두번째팝업 2번 버튼 동작');
	 	    removeAlert();
	 	}

	 	$('.btn-popup').on('click',function(board_idx){
	 		layerPopup('정말 삭제 하시겠습니까?','삭제','취소' ,secondBtn1Act , secondBtn2Act);
	 	});
	 	
	 	 		 			
		
		// 댓글 리스트 부르는 함수
		commentCall();
		
		// 댓글 리스트
		function commentCall() {
			
			
			var board_idx = '${info.ask_idx}';
			
			
			$.ajax({
	        	type: "POST",
	            url: "/comment/" + board_idx ,
	            data: { 'board_idx': board_idx },
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
				
				var addName = view.nickname;
				var comment_idx = view.comment_idx;
				
				
				content +='<div id="sort-area">';
				content +='<div class="sort" id="sort-update'+comment_idx+'">';
				content +='<div>';
				content +='<div class="nick"><div class="profile-area"><div class="profile-img" style="background: url(/resources/img/common/admin_profile.png) center center / cover no-repeat;"></div><div class="profile-box" style="background: url(/resources/img/icon/'+view.icon_image+') center center / 100% 100% no-repeat;"></div></div>'+addName+'</div>';
				if(view.use_yn == 'N'){
					content +='<p class="coco" style="color: #999;" >(삭제된 댓글 입니다.)</p>';
				}else{
					content +='<p class="coco">'+view.content+'</p>';
				}
				content +='<div class="date">'+view.create_date+'</div>';
				content +='</div>';
				if(view.use_yn == 'Y' && ${sessionScope.adminYn == 'Y'}){
					content +='<div class="ard" id="dis">';					
					content +='<div class="detail" style=" cursor: pointer;" onclick="toggleActions(' + comment_idx + ')"><img style="height: 5; margin-top: 25px;" src="/resources/img/run/Group 308.png" alt="상세"></div>';
					content += '<div class="action-buttons" style="display:none; cursor: pointer;" id="actions-' + comment_idx + '">';
					
					content +='<div class="suj1 btn-popup" style=" cursor: pointer;" onclick="update('+comment_idx+')"  >수정</div>';
					content +='<div class="suj2 btn-popup" style=" cursor: pointer;" onclick="del('+comment_idx+')">삭제</div>';
					
					
				}
				content += '</div>';
				content +='</div>';
				content +='</div>';
				content +='</div>';
			});
			$('#list').html(content);
		}
		/*
		function comment() {
			
			var content = $('input[class="tex"]').val();
			console.log('댓굴 내용 : ',content);
			var board_idx = '${info.ask_idx}';
			console.log('댓글 번호 : ',board_idx);
			
			$.ajax({
				type:'POST',
				url:'/addComment',
				data:{'board_idx':board_idx, 'content':content},
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
		*/
		
			function comment() {
			
				var content = $('input[class="tex"]').val();
				console.log('댓굴 내용 : ',content);
				var board_idx = '${info.ask_idx}';	
				console.log('해당 문의글 번호 : ',board_idx);
				
				$.ajax({
					type:'POST',
					url:'/addAskComment',
					data:{'board_idx':board_idx, 'content':content},
					dataType:'JSON',
					success:function(data){
						console.log('댓글 등록',data);
						commentCall();
						$('#upda').hide();
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
		
		function toggleActions(comment_idx) {
		    $('#actions-' + comment_idx).toggle(); // 버튼 표시/숨김 토글
		}
		
		function saveComment(comment_idx) {
			 // 수정된 댓글 내용 가져오기
			 console.log('선택한 댓글번호 : ',comment_idx);
		    var updatedContent = $("#editContent" + comment_idx).val();
			 console.log('수정내용 : ',updatedContent);
		    var nickname = '${nickname.nickname}';

		    // AJAX 요청으로 수정된 내용 서버에 전송
		    $.ajax({
		        type: 'POST',
		        url: '/updateComment',  // 서버의 댓글 수정 처리 경로
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
			
			console.log('삭제버튼 : ',comment_idx);
			
			$.ajax({
		        type: 'POST',
		        url: '/deleteComment/'+comment_idx,  // 서버의 댓글 삭제 처리 경로
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
		
		
	
		
		
		
		
		
		
		
		
		
		
		
		

	 	
	 	
		 	
	 	


</script>
</html>
