<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.erunjrun.mate.dto.MateDTO" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    Map<String, Object> result = (Map<String, Object>) request.getAttribute("result");
    MateDTO profileDto = (MateDTO) result.get("profileDto");
%>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
   .profileDetail {
       padding: 50px 60px 110px;
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
       text-indent: 10px;
   }
   .profileDetail .btn-block {
       margin-top: 80px;
       font-size: 14px;
       color: #999;
       text-decoration: underline;
   }
   .profileDetail .btn-close{
   		position: absolute;
	    top: 18px;
	    right: 18px;
	    display: inline-block;
	    width: 24px;
	    height: 24px;
	    cursor: pointer;
	    text-indent: -1000px;
	    overflow: hidden;
	    background: url(resources/img/common/ico_close.png) center no-repeat;
	    background-size: 17px;
   }
   
</style>

</head>
<body>
	
	<div class="profileDetail">
		<!-- check!! 프로필 주인 id 정보 나중에 바꿔줘야 함. -->
		<input type="hidden" name="id" value="moma123"/>
	    <a class="btn-close">닫기</a>
	    <div class="user-info">
 	        <div>
	           <a class="profile-box" href="#" style="background: url('resources/img/icon/icon1.png') center center / 100% 100% no-repeat;">
	               <img class="profile-img" src="resources/img/common/profile.png" alt="프로필 이미지">
	           </a>
	           <div class="name-addr">
	               <p class="user-name">한수아</p>
	               <img src="resources/img/common/ico_map.png" alt="위치"/><span>서울 종로3가동</span>
	           </div>
           </div>
	       <div class="buttons">
	       		<c:choose>
	       			<c:when test="${result.isBlocked eq false}">
		       			<c:choose>
		       				<c:when test="${result.isMate eq false}">
					           <div class="btn-mate-appl btn01-s">러닝메이트 신청</div>
							</c:when>
						</c:choose>
			           <div class="btn-chat btn02-s">채팅하기</div>
			           <div class="btn-like btn02-s">
			           		<c:choose>
				           		<c:when test="${result.isLiked eq false}">
				           			<img src="resources/img/common/ico_heart_no_act.png" alt="좋아요비활성">
			           			</c:when>
			           			<c:otherwise>
				           			<img src="resources/img/common/ico_heart_act.png" alt="좋아요활성">				           			
			           			</c:otherwise>
		           			</c:choose>
		           		</div>
		           </c:when>
		           <c:otherwise>
		           		<div class="btn-unblock btn01-s">차단해제하기</div>
	           		</c:otherwise>
	           </c:choose>
	       </div>
       </div>

	   <div class="content">
  			<div class="line">
	           <div class="tag-m-gray">성별</div>
	           <p>${result.gender}성</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">연령대</div>
	           <p class="age-area"></p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">운동강도</div>
	           <p>${result.exercise_dis}km/${result.exercise_min}분</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">운동성향</div>
	           <p>${result.exercise}km/${result.exercise_min}분</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">원하는 운동 메이트 운동성향</div>
	           <p>${result.mate}</p>
	       </div>
  			<div class="line">
	           <div class="tag-m-gray">소개글</div>
	           <p>${result.content}</p>
	       </div>

	       
     	   <c:choose>
    	   		<c:when test="${result.isBlocked eq false}">
	       			<a class="btn-block" onclick="layerPopup('한수아 님을 차단하시겠습니까?<br/>차단 시 해당 회원과의 대화기능은 이용 불가합니다.','차단하기','취소')">차단하기</a>
       			</c:when>
     		</c:choose>
	    </div>
	
	
	
	</div>
	<jsp:include page="../footer.jsp"/>
</body>



<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
<script>
 	var birth = '${result.birth}';
 	var birthYear = parseInt(birth.split('-')[0]);
 	var currentDate = new Date();
 	var year = currentDate.getFullYear();
 	var age = year-birthYear+1;
 	var ageArea = '';
 	for(numMin=20, numMax=24; numMin<=50; numMin+=5, numMax+=5){
	 	if(age>=numMin && age<=numMax){
	 		ageArea = numMin+'~'+numMax;
	 	}
 	}
 	$('.age-area').text(ageArea+'세');
 	console.log("ageArea"+ageArea);
 	
 	console.log(year-birthYear+1);
	/* 현재 메이트 여부에 따라 버튼이 다르게 보여짐 */
	console.log('${result.isMate}',${result.isMate});
	console.log('${result.isBlocked}',${result.isBlocked});
	console.log('${result.isOpened}',${result.isOpened});
	console.log('${result.isLiked}',${result.isLiked});
	/* console.log('${result.profileDto}',${result.profileDto}); */

	console.log("result.birth",'${result.birth}');
	console.log("result.birth",'${result.dong}');
	
	 
/* 	<c:forEach var="item" items="${myMap}">
	    <p>${item.value}</p>
	</c:forEach> */
	
/* 	if(${result.isMate}== true){
		$('.btn-mate-appl').css('display','none');
	} */

	/* 메이트 신청하기 버튼 이벤트 */
	$('.btn-mate-appl').on('click',function(){
		
		layerPopup('ㅇㅇㅇ님께 러닝메이트를 신청하시겠습니까?','신청','취소' ,applBtn1Act, applBtn2Act);
	});
	function applBtn1Act() {
	    // 1번버튼 클릭시 수행할 내용
	    //confirm-box
		//var confirmBox = $('.confirm-box')[0];
	    console.log($('input[name="id"]')[0].defaultValue);
	    $.ajax({
	    	type:'POST',
			url:'/mateAppliaction',
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
	
	//btn-mate-appl
</script>
</html>