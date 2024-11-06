<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>아이콘몰</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/popup.js"></script>
<style>
	.icon-mall{
		margin: 160px auto 140px;
	}
	.cont-area {
		position: relative;
	}
	.cont-area::after {
		content: '';
		display: block;
		clear: both;
	}
	.icon-mall .icon-list, .icon-mall .my-area{
		float: left;
	}
	.icon-mall .icon-list {
		margin-right: 130px;
	}
	.icon-mall .title-area{
		margin-bottom: 80px;
		text-align: center;
	}
	.icon-mall .title-area .txt{
		margin-top: 20px;
		font-size: 20px;
		line-height: 160%;
		color: #555;
	}
	.icon-mall .title-area .txt::before{
		content: "";
		display: block;
		width: 30px;
	    margin: 0 auto 20px;
		border: 1px solid #eee;
	}
	.icon-mall .icon-list {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-lines: multiple; -ms-flex-wrap: wrap; flex-wrap: wrap;
		gap: 20px;
		width: 860px;
	}
	.icon-mall .icon-item {
		width: calc( (100% - 60px) / 4 );
		max-height: 268px;
	    margin-bottom: 20px;
		padding: 22px 22px 25px;
		border: 1px solid #eee;
		border-radius: 20px;
		text-align: center;
	}
	.icon-mall .profile-area, .confirm-box .profile-area{
    	width: 116px; height: 116px;
    	position: relative;
    	margin: 0 auto 14px;
    }
    .icon-mall .profile-box, .confirm-box .profile-box {
		position: absolute; top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		width: 116px; height: 116px;
		margin-right: 2px;
	}
	.icon-mall .profile-img, .confirm-box .profile-img {
		position: absolute; top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		width: 84px; height: 84px;
		border-radius: 50%;
	}
	.icon-mall .icon-item .name {
		color: #777;
		margin-bottom: 1px;
	}
	.icon-mall .icon-item .price {
		margin-bottom: 16px;
		font-size: 20px;
	}
	.icon-mall .icon-item .btn02-s {
	    margin-top: 10px;
	}
	
	
	.icon-mall .my-area {
		width: 310px;
		position: sticky;
		top: 0;
	}
	.icon-mall .my-area .top-area{
		display : flex; display: -moz-box; display: -ms-flexbox;
		height: 268px;
		margin-bottom: 40px;
		background: #fbfbfb;
		border-radius: 20px;
	}
	.icon-mall .my-area .point-area, .icon-mall .my-area .icon-area {
		width: 50%;
		padding: 40px 0;
		text-align: center;
	}
	.icon-mall .my-area .point-area {
		position: relative;
	}
	.icon-mall .my-area .point-area::after {
		content: '';
		position: absolute;
		top: 50%; right: 0;
		transform: translate(-50%,-50%);
		width:1px;
		height: calc(100% - 80px);
		background-color: #eee;
	}
	.icon-mall .top-area .tit {
		margin-top: 26px;
		font-size: 18px;
	}
	.icon-mall .top-area .num {
		font-size: 24px;
		margin: 4px 0 11px;
	}
	.icon-mall .top-area .link {
		color: #999;
		font-size: 14px;
		border-bottom: 1px solid #aaa;
	}
	.icon-mall .my-area .desc {
		margin-bottom: 20px;
		padding: 40px 24px 30px;
		background: #fbfbfb;
		border-radius: 20px;
	}
	.icon-mall .desc .tit {
		margin-bottom: 18px;
		font-size: 18px;
		font-weight: 500;
	}
	.icon-mall .desc .tit img {
		width: 20px;
		transform: translateY(4px);
	}
	.icon-mall .desc ul{
		list-style: disc;
		padding-left: 18px;
	}
	.icon-mall .desc li{
		margin-bottom: 10px;
	}
	.icon-mall .btn03-s{
		cursor: default;
	}
	.icon-mall .login-needs {
		width: 100%;
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
		-webkit-box-orient: vertical; -ms-flex-direction: column; flex-direction: column;
	}
	.icon-mall .login-needs .btn01-s {
	    margin-top: 20px;
	}
	.c-777 {
		color: #777;
	} 
	.mb-5 {
		margin-bottom: 5px !important;
	}
	.mb-10 {
		margin-bottom: 10px;
	}
	.mt-10 {
		margin-top : 10px;
	}
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../header.jsp"/> 

	<div class="inner icon-mall">
		<div class="title-area">
			<p class="title1">아이콘몰</p>
			<p class="txt">활동을 통해 포인트를 모으고<br/>모은 포인트로 아이콘을 구매해 프로필을 꾸밀 수 있어요!</p>
		</div>
		<div class="cont-area">
			<div class="icon-list">
				<c:forEach items="${iconList}" var="item">
					<div class="icon-item">
						<div class="profile-area">
							<input type="hidden" name="icon-idx" value="${item.icon_idx}"/>
							<div class="profile-img" style="background: url(/photo/${userInfoList.image}) center center / cover no-repeat;"></div>
							<c:if test="${empty sessionScope.loginId}">
								<div class="profile-img" style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div>						
							</c:if>
							<div class="profile-box" style="background: url(/photo/${item.image}) center center / 100% 100% no-repeat;"></div>
						</div>
						<p class="name">${item.icon_name}</p>
						<span class="price">${item.cost}</span><span>p</span><br/>
						<c:if test="${item.bought eq 'Y'}">						
							<div class="btn03-s">보유</div>
						</c:if>
						<c:if test="${item.bought eq 'N'}">						
							<div class="btn-buy btn02-s">구매</div>
						</c:if>
					</div>
				</c:forEach>	
			</div>
			
			<div class="my-area">
				<div class="top-area">
					<c:if test="${not empty sessionScope.loginId}">
						<div class="point-area">
							<img src="/resources/img/iconMall/ico_point.png" alt="포인트"/>
							<p class="tit">보유 포인트</p>
							<p class="num">${userInfoList.point}p</p>
							<a class="link" href="">상세내역</a>
						</div>
					
						<div class="icon-area">
							<img src="/resources/img/iconMall/ico_emoji.png" alt="아이콘"/>
							<p class="tit">보유 아이콘</p>
							<p class="num">${userInfoList.icon_quantity}개</p>
							<a class="link" href="">상세내역</a>
						</div>
					</c:if>
					<c:if test="${empty sessionScope.loginId}">
						<div class="login-needs">
							로그인이 필요한 서비스입니다.
							<a href="/loginView" class="btn01-s">로그인</a>
						</div>
					</c:if>
				</div>

			
				<div class="desc">
					<p class="tit">포인트는 어떻게 얻나요? <img src="/resources/img/iconMall/ico_point.png" alt="포인트"></p>
					<ul>
						<li>프로필 최초 작성시 10포인트</li>
						<li>게시글 작성시 5포인트</li>
						<li>댓글 작성시 2포인트</li>
						<li>작성한 러닝코스 게시글이 월별 추천 수 1~3등시 100포인트</li>
					</ul>
				</div>
			
			</div>
		</div>
	
	</div>
	
	<!-- 푸터 -->
<jsp:include page="../footer.jsp"/>
</body>
	




<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>

<script>
	console.log('${userInfoList}');
	console.log('${userInfoList.image}');

	// 구매버튼 클릭시	
	$('.btn-buy').on('click',function(){
		if('${sessionScope.loginId}' == ''){
			alert('로그인이 필요한 서비스입니다.');
		}else{

			var profile = $(this).closest('.icon-item').find('.profile-area').prop('outerHTML');
			var iconName = $(this).closest('.icon-item').find('.name').text();
			var iconPrice = $(this).closest('.icon-item').find('.price').text();
			var iconIdx = $(this).closest('.icon-item').find('input[name="icon-idx"]').val();
			console.log(profile);
			
			
			$.ajax({
				type: 'GET',
		        url: '/checkPoint/'+iconPrice,
		        datatype: 'JSON',
		        success: function(data) {
					if(data.purchase){
						var cont = '<p class="c-777">'+iconName+'</p>'+'<p>'+iconPrice+'p</p>';
						imgLayerPopup('해당 아이콘을 구매하시겠습니까?',profile,cont,'구매','취소' ,btn1Act , btn2Act, iconIdx);
					}else{
						var cont = '<p class="mt-10 mb-5"><span class="c-777">보유 포인트 : </span><span>'+data.userPoint+'p</span></p>'+'<p class="mb-10"><span class="c-777">아이콘 가격 : </span><span>'+iconPrice+'p</span></p>';
						imgLayerPopup('포인트가 부족합니다.','<img class="mb-10" src="/resources/img/iconMall/ico_point.png" alt="포인트"/>', cont, '확인', false, btn2Act, btn2Act, iconIdx);
					}
		        },
		        error: function(e) {
	
		        }
			});
			
			// 닫기 버튼 클릭 시 팝업 닫기
			$(document).on('click','.confirm-box .btn-close',function(){
				location.reload(true);
			});
			
		}
		
	});

	// 아이콘 구매 레이어 팝업
	function imgLayerPopup(message, img, cont, btn1, btn2, btn1Callback = btn1Act, btn2Callback = btn2Act, iconIdx) {		
		
		// 대화 상자를 HTML 요소로 생성
	    var confirmBox = document.createElement('div');
	    confirmBox.setAttribute('class', 'confirm-box');
	    var confirmBoxCont = '<p style="margin-bottom: 20px;">' + message + '</p><a class="btn-close">닫기</a>';
	    confirmBoxCont += img; 
	    confirmBoxCont += cont;
	    confirmBoxCont += '<div class="btn-box"><button class="confirm btn01-m">' + btn1 + '</button></div>';
	    confirmBox.innerHTML = confirmBoxCont;
	    
	    popUpCommon(btn2, confirmBox, btn1Callback, btn2Callback, iconIdx);
	}
	
	function btn1Act(iconIdx) {	
	    console.log('iconIdx',iconIdx);
		// 팝업 연달아 필요할 경우 (secondBtn1Act:1번 버튼 클릭시 수행할 내용/ secondBtn2Act: 2번 버튼 클릭시 수행할 내용)
	    $.ajax({
	    	type: 'POST',
	        url: '/buyIcon/'+iconIdx,
	        datatype: 'JSON',
	        success: function(result) {
				if(result){
					removeAlert();
				    layerPopup("아이콘 구매가 완료 되었습니다.", "확인", "적용하러 가기", secondBtn1Act, secondBtn2Act);
				}else{
					removeAlert();
				    layerPopup("아이콘 구매에 실패하였습니다.", "확인",false, secondBtn1Act, secondBtn1Act);					
				}
	        },
	        error: function(e) {
				removeAlert();
			    layerPopup("아이콘 구매에 실패하였습니다.", "확인",false, secondBtn1Act, secondBtn1Act);					
	        }
	    });
	}
	
	function btn2Act() {
	    removeAlert();
	    console.log('2번 버튼 동작');
	}
	
	function secondBtn1Act() {
		removeAlert();
		location.reload(true);
	}
	
	function secondBtn2Act() {
		location.href="/";
		removeAlert();
	}
	

	
</script>
</html>