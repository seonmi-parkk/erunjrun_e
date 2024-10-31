<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.erunjrun.mate.dto.MateProfileDTO" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<html>
<head>
<meta charset="UTF-8">
<title>운동프로필</title>
<style>
   .profileDetail {
   	   position: relative;
   	   width: 760px;
       padding: 34px 50px 10px;
       height: calc(100vh - 120px);
   	   overflow-y: auto;
   }
   .profileDetail .user-info{
       display: -moz-box; display: -ms-flexbox; display: flex;
       -webkit-box-pack: space-between; -ms-flex-pack: space-between; justify-content: space-between;
       padding-bottom: 12px;
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
       padding-top: 24px;
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
   .profileDetail .content .use-n {
   		margin-top: 10px;
   		padding: 20px 10px;
   		color: #666;
   		border-top: 1px dashed #ddd;
   }
   .profileDetail .content .btn-block {
       display: inline-block;
	   width: fit-content;
       padding: 8px 6px;
       margin-top: 50px;
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
   .profileDetail::-webkit-scrollbar {
	    width: 10px;
	}
	.profileDetail::-webkit-scrollbar-track {
	    background-color: #eaeaea;
	}
	.profileDetail::-webkit-scrollbar-thumb { 
	    background-color: #d0d0d0;
	    border-radius: 10px;
	}
	.profileDetail::-webkit-scrollbar-button {
	    display: none;
	}
	.profileDetail .buttons .btn01-s {
		color: #fff;
	}
	.profileDetail .buttons .btn01-s:hover{
		color: #fff;
	} 
	
</style>
</head>
<body>
	<div class="profileDetail">
		<!-- check!! 프로필 주인 id 정보 나중에 바꿔줘야 함. -->
		<input type="hidden" name="id" value="${profileDto.id}"/>
	    <div class="user-info">
 	        <div>
 	        	<!-- check!!  -->
	           <div class="profile-box" style="background: url('/resources/img/icon/${profileDto.icon_image}') center center / 100% 100% no-repeat;">
     				<c:choose>
						<c:when test="${not empty profileDto.image}">  
							<div class="profile-img" style="background: url(/photo/${profileDto.image}) center center / cover no-repeat;"></div>
						</c:when>
						<c:otherwise>
							<div class="profile-img"  style="background: url(resources/img/common/profile.png) center center / cover no-repeat;"></div>
						</c:otherwise>
					</c:choose>
	           </div>
	           <div class="name-addr">
	               <p class="user-name">${profileDto.nickname}</p>
	               <img src="/resources/img/common/ico_map.png" alt="위치"/><span class="addr">${profileDto.shortsido} ${profileDto.dong}</span>
	           </div>
           </div>
           <c:choose>
           	<c:when test="${profileDto.id != sessionScope.loginId}">
		       <div class="buttons">
		       		<c:choose>
		       			<c:when test="${result.isBlocked eq false}">
			       			<c:choose>
			       				<c:when test="${result.MateAppl eq 'apply'}">
						           <a class="btn01-s" style="cursor: default;">러닝메이트 신청중</a> <!-- check!! mypage로 이동 -->
								</c:when>
			       				<c:when test="${result.MateAppl eq 'recieve'}">
						           <a class="btn01-s">러닝메이트 신청수락</a> <!-- check!! mypage로 이동 -->
								</c:when>
			       				<c:when test="${result.MateAppl eq 'none'}">
						           <div class="btn-mate-appl btn01-s">러닝메이트 신청</div>
								</c:when>
							</c:choose>
				           <div class="btn-chat btn02-s" onclick="chat('${sessionScope.loginId}','${profileDto.id}')">채팅하기</div>
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
	       </c:when>
	       </c:choose>
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
	       <c:if test="${profileDto.profile_use eq 'N'}">
	       		<p class="use-n">* 운동 프로필이 비공개된 회원입니다.</p>
	       </c:if>
      		<c:if test="${profileDto.profile_use eq 'Y'}">
	  			<div class="line">
		           <div class="tag-m-gray">운동강도</div>
		           <c:if test="${not empty profileDto.exercise_dis and not empty profileDto.exercise_min}">  
		           		<p>${profileDto.exercise_dis}km / ${profileDto.exercise_min}분</p>
           			</c:if>
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
			</c:if>
     	   <c:choose>
    	   		<c:when test="${result.isBlocked eq false}">
	       			<a class="btn-block" onclick="layerPopup('${profileDto.nickname} 님을 차단하시겠습니까?<br/>차단 시 해당 회원과의 대화기능은 이용 불가합니다.','차단하기','취소',blockBtnAct,cancleBtnAct)">차단하기</a>
       			</c:when>
     		</c:choose>
	    </div>
	 </div>   
</body>
</html>