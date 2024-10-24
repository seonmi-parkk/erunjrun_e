<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.erunjrun.mate.dto.MateProfileDTO" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
   .profileDetail {
   	   position: relative;
   	   width: 770px;
       padding: 54px 60px 110px;
       min-height: 950px;
   }
   .profileDetail .user-info{
       display: -moz-box; display: -ms-flexbox; display: flex;
       -webkit-box-pack: space-between; -ms-flex-pack: space-between; justify-content: space-between;
       padding-bottom: 20px;
       border-bottom: 1px solid #ddd;
   }
    .profileDetail .user-info > div{
    	 display: -moz-box; display: -ms-flexbox; display: flex;
    	 -webkit-box-align: start; -ms-flex-align: start; align-items: flex-start;
    }
   .profileDetail .user-info .profile-box{
   		display: inline-block;
   		width: 110px; height: 110px;
     	margin-right: 10px;
    	display: flex; display: -moz-box; display: -ms-flexbox;
	    -webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
	    -webkit-box-align: center; -ms-flex-align: center; align-items: center;
   }
   .profileDetail .user-info .profile-img {
   		width: 75px; height: 75px;
   		border-radius: 50%;
   	}
   .profileDetail .user-info .user-name{
       font-size: 30px;
   }
   .profileDetail .user-info .name-addr, .profileDetail .buttons {
   		margin-top: 18px;
	}
   .profileDetail .user-info .name-addr span{
       margin-left: 4px;
       color: var(--main-color);
   }
   .profileDetail .user-info .name-addr img{
  		transform: translateY(4px);
   }
   .profileDetail .content{
       padding-top: 30px;
   }
   .profileDetail .line{
       margin-bottom: 22px;
   }
   .profileDetail .line .tag-m-gray{
       margin-bottom: 10px;
   }
   .profileDetail .line p{
      	margin-left: 10px;
   }
   .profileDetail .content .btn-block {
       display: inline-block;
	   width: fit-content;
       padding: 8px 6px;
       margin-top: 80px;
       font-size: 14px;
       color: #999;
       text-decoration: underline;
       cursor: pointer;
   }
   .profileDetail .content .btn-block:hover {
   		color: #999;
   }
   .modal-content {
 		width: fit-content;
 		border-radius: 10px;
   }
   
</style>

</head>
<body>
	
	<div class="profileDetail">
		<!-- check!! 프로필 주인 id 정보 나중에 바꿔줘야 함. -->
		<input type="hidden" name="id" value="moma123"/>
	    <div class="user-info">
 	        <div>
 	        	<!-- check!! 회원테이블에 아이콘no 대신 아이콘 이미지를 넣는게 join을 줄일수 있을 듯하여 의견말해보고 변경할지 체크  -->
	           <div class="profile-box" style="background: url('/resources/img/icon/${profileDto.icon_image}') center center / 100% 100% no-repeat;">
	               <div class="profile-img" style="background: url(/photo/${profileDto.image}) center center / cover no-repeat;"></div>
	           </div>
	           <div class="name-addr">
	               <p class="user-name">${profileDto.nickname}</p>
	               <img src="/resources/img/common/ico_map.png" alt="위치"/><span>${profileDto.shortsido} ${profileDto.dong}</span>
	           </div>
           </div>
	       <div class="buttons">
	       		<c:choose>
	       			<c:when test="${result.isBlocked eq false}">
		       			<c:choose>
		       				<c:when test="${result.MateAppl eq 'apply'}">
					           <a class="btn01-s" href="">러닝메이트 신청중</a> <!-- check!! mypage로 이동 -->
							</c:when>
		       				<c:when test="${result.MateAppl eq 'recieve'}">
					           <a class="btn01-s" href="">러닝메이트 신청수락</a> <!-- check!! mypage로 이동 -->
							</c:when>
		       				<c:when test="${result.MateAppl eq 'none'}">
					           <div class="btn-mate-appl btn01-s">러닝메이트 신청</div>
							</c:when>
						</c:choose>
			           <div class="btn-chat btn02-s">채팅하기</div>
			           <div class="btn-like btn02-s" onclick="like()">
			           		<c:choose>
				           		<c:when test="${result.isLiked eq false}">
				           			<img src="/resources/img/common/ico_heart_no_act.png" alt="좋아요비활성">
			           			</c:when>
			           			<c:otherwise>
				           			<img src="/resources/img/common/ico_heart_act.png" alt="좋아요활성">				           			
			           			</c:otherwise>
		           			</c:choose>
		           		</div>
		           </c:when>
		           <c:otherwise>
		           		<div class="btn-unblock btn01-s"  onclick="layerPopup('${profileDto.nickname} 님을 차단해제 하시겠습니까?','차단해제','취소',unblockBtnAct,cancleBtnAct)">차단해제하기</div>
	           		</c:otherwise>
	           </c:choose>
	       </div>
       </div>

	   <div class="content">
  			<div class="line">
	           <div class="tag-m-gray">성별</div>
	           <p>${profileDto.gender}성</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">연령대</div>
	           <p>${profileDto.birth}</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">운동강도</div>
	           <p>${profileDto.exercise_dis}km/${profileDto.exercise_min}분</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">운동성향</div>
	           <p>${profileDto.exercise}</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">원하는 운동 메이트 운동성향</div>
	           <p>${profileDto.mate}</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">소개글</div>
	           <p>${profileDto.content}</p>
	       </div>

	       
     	   <c:choose>
    	   		<c:when test="${result.isBlocked eq false}">
	       			<a class="btn-block" onclick="layerPopup('${profileDto.nickname} 님을 차단하시겠습니까?<br/>차단 시 해당 회원과의 대화기능은 이용 불가합니다.','차단하기','취소',blockBtnAct,cancleBtnAct)">차단하기</a>
       			</c:when>
     		</c:choose>
	    </div>
	
	</div>
</body>



<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>
<script>

	/* 메이트 신청하기 버튼 이벤트 */
	$('.btn-mate-appl').on('click',function(){
		layerPopup('${profileDto.nickname}님께 러닝메이트를 신청하시겠습니까?','신청','취소' ,applBtn1Act, applBtn2Act);
	});
	
	function applBtn1Act() {
	    // 1번버튼 클릭시 수행할 내용

	    $.ajax({
	    	type:'POST',
			url:'/mateAppliaction/',
			data:{
				fromUserId: '${sessionScope.loginId}',
				toUserId: $('input[name="id"]')[0].defaultValue
			},
			dataType:'JSON',
			success:function(data){
				console.log(data.success);
				// 신청완료 팝업
				if(data.success){
					loadingComplete();
					removeAlert(); // 기존 confirmBox 닫기
			    	layerPopup('운동메이트 신청이 완료되었습니다.', '확인','내 운동메이트로 이동',appl2Btn1Act , appl2Btn2Act);
				}
			},
			error:function(e){
				removeAlert();  // 기존 confirmBox 닫기
				layerPopup('운동메이트 신청 실패하였습니다.', '재신청','취소',applBtn1Act , applBtn2Act);
			}
	    	
	    });
	    loading();
	    
	}
	
	function applBtn2Act() {
	    // 취소 버튼 클릭시
	    removeAlert(); // 기존 confirmBox 닫기
	}
	
	function appl2Btn1Act() {
	    // 신청완료 팝업 - 확인 버튼 클릭시
	     removeAlert(); // 기존 confirmBox 닫기
	}
	function appl2Btn2Act() {
	    // 신청완료 팝업 - 내 운동메이트로 이동 버튼 클릭시
	    removeAlert();
	    location.href='/';
	    console.log('2번 버튼 동작');
	}
	
	// 차단하기 버튼 클릭시
	function blockBtnAct(){
		$.ajax({
			type:'POST',
			url:'/mateBlock',
			data:{
				fromUserId: '${sessionScope.loginId}',
				toUserId: $('input[name="id"]')[0].defaultValue
			},
			dataType:'JSON',
			success:function(data){
				console.log(data.success);
				if(data.success){				
					removeAlert();
					layerPopup('차단 하였습니다.', '확인',false,cancleBtnAct,cancleBtnAct);
					location.href='/mate';
				}else{
					removeAlert();
					layerPopup('차단 실패하였습니다.', '차단 재시도','취소',blockBtnAct,cancleBtnAct);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	// 차단하기 취소 버튼 클릭시
	function cancleBtnAct(){
		 removeAlert();
	}
	
	// 차단 해제하기 버튼 클릭시
	function unblockBtnAct(){
		$.ajax({
			type:'POST',
			url:'/mateUnblock',
			data:{
				fromUserId: '${sessionScope.loginId}',
				toUserId: $('input[name="id"]')[0].defaultValue
			},
			dataType:'JSON',
			success:function(data){
				console.log(data.success);
				if(data.success){		
					removeAlert();
					layerPopup('차단이 해제되었습니다.', '확인',false,cancleBtnAct,cancleBtnAct);
					location.href='/mate';
				}else{
					removeAlert();
					layerPopup('차단해제 실패하였습니다.', '해제 재시도','취소',unblockBtnAct,cancleBtnAct);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	// 좋아요 기능
	function like(){
		$.ajax({
			type:'POST',
			url:'/toggleLike',
			data:{
				fromUserId: '${sessionScope.loginId}',
				toUserId: $('input[name="id"]')[0].defaultValue
			},
			dataType:'JSON',
			success:function(data){
				console.log(data.isLiked);
				if(data.isLiked){					
					$('.btn-like img').attr('src','/resources/img/common/ico_heart_act.png');
				}else{
					$('.btn-like img').attr('src','/resources/img/common/ico_heart_no_act.png');					
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	
</script>
</html>