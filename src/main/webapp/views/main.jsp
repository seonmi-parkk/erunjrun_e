<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="/resources/js/popup.js"></script>
<style>
	
	 	.sec {
 		    max-width: 1300px;
   			margin: 0 auto;
            padding: 90px 0;
        }
        .sec_inner {
 		    max-width: 1300px;
        }
        .sec .tit-tag {
            font-size: 22px;
            font-weight: 600;
            color: var(--main-color);
        }
        .sec .tit-tag img {
            transform: translateY(4px);
		    margin-right: 2px;          
        }
        .sec > .tit , .sec4 .txt_area .tit {
            margin: 22px 44px 40px;
            font-size: 38px;
		  	line-height: 160%;
	  	    font-family: "GmarketSans", sans-serif;
    		font-weight: 700;
        }
        .sec1 {
            position: relative;
            margin-top: 60px;
            padding-top: 50px;
        }
        .sec1 .img {
            width: 100%;
            height: 530px;
            border-radius: 20px;
            background: url('/resources/img/main/main_image.jpg') no-repeat center/cover;
        }
        .sec1 .quick li a{
            background: #ffffff;
            border-radius: 10px;
            display: flex; display: -moz-box; display: -ms-flexbox;
            padding: 20px;
            width: 247px;
            height: 110px;
            box-shadow: 0px 3px 12px 0px rgba(0, 0, 0, 0.08);
        }
        .sec1 .quick {
            position: absolute;
            bottom: 35px; 
            left: 50%;
            transform: translateX(-50%);
            
        }
        .sec1 .quick ul{
        	display: flex; display: -moz-box; display: -ms-flexbox;
            gap: 20px;
        }
        .sec1 .quick img{
            margin-right: 12px;
        }
        .sec1 .quick .tit {
            margin-bottom: 6px;
            font-size: 20px;
            font-weight: 600;
            background: url(/resources/img/main/arrow_r.png) right center no-repeat;
        }
        .sec1 .quick .txt p{
            color: #757983;
            font-size: 14px;
            word-break: keep-all;
        }
        .sec2 .tit-tag, .sec2 .tit {
       	    text-align: center;
        }
        .view-more {
        	margin-top: 80px;
        	text-align: center;
        }
        .view-more img {
        	transform: translate(2px,1px);
        }
		.sec3 {
		    padding-top: 60px;
			text-align: center;
		}
		.sec3 .tit {
		    margin-bottom: 20px;
		}
		.sec3 .arrow {
			display: flex; display: -moz-box; display: -ms-flexbox;
	    	-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
	    	-webkit-box-align: center; -ms-flex-align: center; align-items: center;			
			width: 32px;
			height: 32px;
			margin: 0 auto;
			border-radius: 50%;
			background: #000;
			animation: move_arrow .8s ease-in infinite;
		}
		@keyframes move_arrow {
		  	0% {transform: translateY(0px);}
		  	50% {transform: translateY(12px);}
		  	100% {transform: translateY(0px);}
		}
		.sec4 {
			position: relative;
			max-width: none;
			background: #FAFAFA;
		}
		.sec4 .sec_inner{
			height: 770px;
			margin: 0 auto;
		}
		.sec4 .txt_area .tit  {
			margin-left: 0;
		}
		.sec4 .txt {
			line-height: 1.8;
    		font-size: 20px;
		}
		.sec4 .bg{
			width: 62%;
		    height: 100%;
			position: absolute;
			top: 0; right: 0;
			background: url('/resources/img/main/sec4_bg.png') no-repeat center/cover;
		}
		.sec4 .bg img {
			position: absolute;
			top: 50%;
			right: 22%;
			transform: translate(-50%, -50%);
		}
		.sec4 .txt_area {
			position: absolute;
			top: 50%;
			transform: translateY(-50%);
		}
		.sec5 {
			margin-bottom: 120px;
			text-align: center;
		}
		.sec5 .tit-tag {
			color: var(--blue);
		}
		

		/* sec2 크루 */
		.tagBox {
		    background: #ffffff; /* 배경색을 흰색으로 설정 */
		    height: 158px; /* 상자의 높이를 158px로 설정 */
		    position: relative; /* 위치를 상대적으로 설정 */
		    display: flex; /* 내부 요소들을 수평으로 배치 */
		    align-items: center; /* 내부 요소를 수직 중앙 정렬 */
		    justify-content: center; /* 내부 요소를 수평 중앙 정렬 */
		}
		#tagFilter {
		    display: flex; /* 체크박스 필터 요소들을 수평으로 배치 */
		    flex-wrap: wrap; /* 화면이 부족할 경우 줄 바꿈을 허용 */
		    justify-content: center; /* 중앙 정렬하여 배치 */
		}
		#tagFilter label {
		    display: flex; /* 체크박스와 텍스트를 수평으로 배치 */
		    justify-content: space-between; /* 내부 요소의 공간을 균등하게 분배 */
		    align-items: center; /* 수직 중앙 정렬 */
		    padding: 5px 14px; /* 상하 5px, 좌우 14px의 패딩 추가 */
		    width: fit-content; /* 내용에 맞게 너비를 자동으로 조정 */
		    height: 38px; /* 요소의 높이를 38px로 설정 */
		    line-height: 38px; /* 줄 높이를 38px로 설정 */
		    position: relative; /* 위치를 상대적으로 설정 */
		    border-radius: 100px; /* 모서리를 둥글게 설정 */
		    border: 1px solid rgba(0,0,0,0.07); /* 연한 회색 테두리 설정 */
		    margin-right: 20px; /* 오른쪽 여백 20px 추가 */
		    font-size: 16px; /* 텍스트 크기를 16px로 설정 */
		    cursor: pointer; /* 마우스 포인터를 손가락 모양으로 변경 */
		    margin: 15px 4px 4px 25px; /* 상단, 좌우, 하단 여백 설정 */
		}
		#tagFilter input[type="checkbox"] {
		    position: absolute; /* 체크박스의 위치를 절대 위치로 설정 */
		    width: 0px; /* 체크박스 너비를 0으로 설정해 숨김 */
		    height: 0px; /* 체크박스 높이를 0으로 설정해 숨김 */
		    margin-right: 5px; /* 오른쪽에 5px 간격을 추가 */
		    appearance: none; /* 기본 스타일 제거 */
		    visibility: hidden; /* 화면에서 체크박스를 숨김 */
		}
		#tagFilter label.checked {
		    background-color: rgba(253,111,34,0.22); /* 선택된 상태의 배경색 설정 */
		}
		#tagFilter input[type="checkbox"]:after, #tagFilters input[type="checkbox"]:checked::after {
		    display: none; /* 체크박스가 선택된 상태에서도 after 요소를 숨김 */
		    visibility: hidden; /* 화면에서 after 요소를 숨김 */
		}
		.layoutbox-bt {
		    height: 90px; /* 하단 배너 영역의 높이를 90px로 설정 */
		    background-color: white; /* 배경색을 흰색으로 설정 */
		}
		.crewListBox {
		    display: flex; /* 크루 박스를 가로로 나열 */
		    flex-wrap: wrap; /* 화면이 좁을 경우 줄 바꿈 허용 */
		    gap: 40px; /* 크루 박스 간의 간격을 40px로 설정 */
		    justify-content: center; /* 중앙 정렬하여 배치 */
		}
		.crewBox {
	        width: calc((100% - 40px) / 2);
		    background-color: #fff; /* 크루 박스 배경을 흰색으로 설정 */
		    border-radius: 12px; /* 모서리를 둥글게 설정 */
		    padding: 20px; /* 내부 여백을 20px로 설정 */
		    display: flex; /* 내부 요소를 수평으로 배치 */
		    gap: 22px; /* 내부 요소 간의 간격을 22px로 설정 */
	     	box-shadow: var(--shadow1-box-shadow, 0px 4px 13px 0px rgba(0, 0, 0, 0.12));
		}
		
		.crewImg {
		    position: relative; /* 하트 아이콘이 이미지 위에 배치될 수 있도록 상대 위치 설정 */
		    width: 160px; /* 이미지의 너비를 140px로 설정 */
		    height: 160px; /* 이미지의 높이를 140px로 설정 */
		    border-radius: 12px; /* 이미지 모서리를 둥글게 설정 */
		    overflow: hidden; /* 이미지가 영역을 넘칠 경우 숨김 */
		}
		
		.crew-img {
		    width: 100%; /* 이미지 너비를 부모 요소에 맞춤 */
		    height: 100%; /* 이미지 높이를 부모 요소에 맞춤 */
		    object-fit: cover; /* 이미지 비율을 유지하면서 넘치는 부분을 잘라냄 */
		}
		
		.crew-like {
		    position: absolute; /* 하트 아이콘을 이미지 위에 절대 위치로 설정 */
		    bottom: 10px; /* 이미지 아래에서 10px 위로 배치 */
		    right: 10px; /* 이미지 오른쪽에서 10px 왼쪽으로 배치 */
		    width: 15px; /* 하트 아이콘의 너비를 15px로 설정 */
		    height: 15px; /* 하트 아이콘의 높이를 15px로 설정 */
		}
		
		.crewContentBox {
		    flex: 1; /* 남은 공간을 모두 차지 */
		    display: flex; /* 내부 요소를 수평으로 배치 */
		    flex-direction: column; /* 내부 요소를 수직으로 배치 */
		    justify-content: space-between; /* 내부 요소 사이의 공간을 균등하게 분배 */
		}
		
		.tagBox2 {
		    display: flex; /* 태그를 수평으로 나열 */
		    gap: 8px; /* 태그 사이의 간격을 8px로 설정 */
		    flex-wrap: wrap; /* 태그가 부족할 경우 줄 바꿈 허용 */
		    justify-content: flex-start; /* 태그를 왼쪽 정렬 */
		    height: auto; /* 자동으로 높이를 설정 */
		    margin-bottom: 6px;
		}
		
		.tag {
		    background-color: #f0f0f0; /* 태그 배경색을 연한 회색으로 설정 */
		    border-radius: 12px; /* 태그의 모서리를 둥글게 설정 */
		    padding: 4px 17px; /* 상하 4px, 좌우 17px의 여백 */
		    font-size: 14px; /* 태그의 글자 크기를 14px로 설정 */
		    font-weight: 600; /* 태그의 글자를 두껍게 설정 */
		}
		
		.highlight-tag {
	    	background-color: #FFDDC1; /* 두 번째 태그 배경색 */
		}
			
		.crewName {
		    font-weight: bold; /* 크루 이름을 굵게 설정 */
		   	font-size: 20px;
  			margin-top: 5px;
		}
		
		.crewInfo-01, .crewInfo-02 {
		    color: #333; /* 텍스트 색상을 회색으로 설정 */
		    font-size: 16px; /* 글자 크기를 14px로 설정 */
		    margin-top: 7px; /* 위쪽 여백을 7px 추가 */
		}
		.crewInfo-01 span, .crewInfo-02 span {
			color: #777;
		}
		.crewInfo-01 img, .crewInfo-02 img {
		    margin-right: 2px;
		    transform: translateY(1px);
		}
		.crewInfo-02 .current_member {
			color: var(--main-color);
		}
		.crewBox .crewStatus01 {
		    margin-top: -30px; /* 위쪽 여백을 -30px로 설정해 위치 조정 */
		    padding: 8px 16px; /* 상하 8px, 좌우 16px의 패딩 */
		    background-color: var(--main-color);; /* 배경색을 주황색으로 설정 */
		    color: white; /* 텍스트 색상을 흰색으로 설정 */
		    border-radius: 14px; /* 모서리를 둥글게 설정 */
		    text-align: center; /* 텍스트를 중앙 정렬 */
		    font-weight: bold; /* 텍스트를 굵게 설정 */
		    width: fit-content; /* 내용에 맞는 너비로 설정 */
		    margin-left: 170px; /* 왼쪽에 170px의 여백 */
		}
	
		.crewBox .crewStatus02 {
		    margin-top: -30px; /* 위쪽 여백을 -30px로 설정해 위치 조정 */
		    padding: 8px 16px; /* 상하 8px, 좌우 16px의 패딩 */
		    background-color: var(--btn-bd-g); /* 배경색을 주황색으로 설정 */
		    color: white; /* 텍스트 색상을 흰색으로 설정 */
		    border-radius: 14px; /* 모서리를 둥글게 설정 */
		    text-align: center; /* 텍스트를 중앙 정렬 */
		    font-weight: bold; /* 텍스트를 굵게 설정 */
		    width: fit-content; /* 내용에 맞는 너비로 설정 */
		    margin-left: 170px; /* 왼쪽에 170px의 여백 */
		}
	
		#is_recruit {
			color: #fff;
		}		
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="header.jsp"/> 
	
 	<c:forEach var="popup" items="${popups}">
        <div id="popup_${popup.popup_idx}" 
             style="position:fixed; top:${popup.y}px; left:${popup.x}px; 
                    width:${popup.width}px; height:${popup.height}px; 
                    z-index:${popup.priority}; background-color:white;">
             <img alt="${file.img_ori}" src="/photo/${file.img_new}">	
             <h1>${popup.subject}</h1>       
            <p>${popup.content}</p>
            <button class="btn01-m" onclick="closePopup(${popup.popup_idx})">오늘 하루 그만 보기</button>
        </div>
    </c:forEach> 
	
	
	   <div class="sec sec1">
	        <div class="img"></div>
	        <div class="quick">
	            <ul>
	                <li>
	                    <a href="/crewList">
	                        <img src="/resources/img/main/quick1.png" alt="러닝크루">
	                        <div class="txt">
	                            <div class="tit">러닝크루</div>
	                            <p>나의 성향, 지역에 맞는 크루 찾기</p>
	                        </div>
	                    </a>
	                </li>
	                <li>
	                    <a href="/mateList">
	                        <img src="/resources/img/main/quick2.png" alt="러닝메이트">
	                        <div class="txt">
	                            <div class="tit">러닝메이트</div>
	                            <p>1대1로 함께 달릴 근처 메이트 찾기</p>
	                        </div>
	                    </a>
	                </li>
	                <li>
	                    <a href="/runBoard">
	                        <img src="/resources/img/main/quick3.png" alt="게시판">
	                        <div class="txt">
	                            <div class="tit">게시판</div>
	                            <p>러닝코스 추천부터 다양한 정보 공유까지</p>
	                        </div>
	                    </a>
	                </li>
	                <li>
	                    <a href="/icon">
	                        <img src="/resources/img/main/quick4.png" alt="아이콘몰">
	                        <div class="txt">
	                            <div class="tit">아이콘몰</div>
	                            <p>개성있는 아이콘으로 프로필 이미지 꾸미기</p>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	        </div>
	    </div>
	
	    
	    <div class="sec sec2">
	        <div class="tit-tag"><img src="/resources/img/main/star_og.png" alt="아이콘">러닝크루</div>
	        <div class="tit">나의 취향에 딱 맞는<br/>러닝크루와 함께 달려요</div>
	        <div class="crewListBox"> </div>
			<div class="view-more">	       
		        <a href="/crewList">더보기<img src="/resources/img/main/arrow_r.png"/ alt="바로가기"></a>
	        </div>
	    </div>
	    
	    <div class="sec sec3">
	        <div class="tit">러닝성향이 통하는<br/>친구들을 만나요</div>
	        <div class="arrow"><img src="/resources/img/main/arrow_w.png" alt="아래로"></div>
	    </div>
	
	    <div class="sec sec4">
	        <div class="bg"><img src="/resources/img/main/sec4_chat.png" alt="채팅"></div>
	    	<div class="sec_inner">
	    		<div class="txt_area">
			        <div class="tit-tag"><img src="/resources/img/main/star_og.png" alt="아이콘">프로필</div>
			        <div class="tit">함께 할 멤버들의<br/>성향 미리 알아보기</div>
			       	<p class="txt">멤버들의 운동 프로필을 통해<br/>나와 취향이 통하는지 사전에 확인하고<br/>나와 맞는 멤버에게 채팅을 보낼 수 있어요.</p>
		       	</div>
	    	</div>
	    </div>
	
	    <div class="sec sec5">
	        <div class="tit-tag"><img src="/resources/img/main/star_bl.png" alt="아이콘">러닝메이트</div>
	        <div class="tit">근처 유저 중 성향이 맞는 친구들과<br/>러닝메이트를 맺어요</div>
	        <img src="/resources/img/main/sec5.png" alt="아이콘">
	        <div class="view-more">	       
		        <a href="/mateList">바로가기<img src="/resources/img/main/arrow_r.png"/ alt="바로가기"></a>
	        </div>
	    </div>
		

	
	<!-- 푸터 -->
	<jsp:include page="footer.jsp"/>
</body>


<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>


<script>



/* 레이어팝업 */
function btn1Act() {
    // 1번버튼 클릭시 수행할 내용
    console.log('1번 버튼 동작');

    // 팝업 연달아 필요할 경우 (secondBtn1Act:1번 버튼 클릭시 수행할 내용/ secondBtn2Act: 2번 버튼 클릭시 수행할 내용)
    layerPopup("두번째", "체크", false ,secondBtn1Act , secondBtn2Act);
}

function btn2Act() {
    // 2번버튼 클릭시 수행할 내용
    console.log('2번 버튼 동작');
}

function secondBtn1Act() {
    // 두번째팝업 1번버튼 클릭시 수행할 내용
    console.log('두번째팝업 1번 버튼 동작');
}

function secondBtn2Act() {
    // 두번째팝업 2번버튼 클릭시 수행할 내용
    console.log('두번째팝업 2번 버튼 동작');
}

$('.btn-popup').on('click',function(){
	layerPopup('~~~하시겠습니까?222','다음으로2','취소2' ,secondBtn1Act , secondBtn2Act);
});


	
	
/* 	<div class="crewListBox" style="justify-content: center;">
		<div class="crewBox" onclick="crewDetail(74)">
			<div class="crewImg">
				<img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(74)">
				<img id="crewLikes-74" class="crew-like" src="/resources/img/common/ico_heart_no_act.png">
			</div>
		</div>
		<div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">남성만 가능</span><span class="tag highlight-tag">소규모 크루</span><span class="tag normal-tag">친목도 중요</span></div><div class="crewName" id="crew-name">최종 등록 테스트</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;종로구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">화,수</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">5</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(73)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(73)"><img id="crewLikes-73" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">러닝 고수만</span></div><div class="crewName" id="crew-name">테스트테스트</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;금천구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">수</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">50</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(71)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(71)"><img id="crewLikes-71" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">대회 목적</span><span class="tag highlight-tag">러닝 고수만</span></div><div class="crewName" id="crew-name">테스트를 위한 크루 생성입니다.</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;강남구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">금</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">5</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(64)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(64)"><img id="crewLikes-64" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">러닝 고수만</span><span class="tag highlight-tag">초보도 환영</span></div><div class="crewName" id="crew-name">크루 테스트 2 (이동 여부 테스트)</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;강남구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">일</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">5</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(63)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(63)"><img id="crewLikes-63" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">대회 목적</span><span class="tag highlight-tag">소규모 크루</span></div><div class="crewName" id="crew-name">크루 테스트 2 (이동 여부 테스트)</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;강남구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">금,일</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">10</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(61)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(61)"><img id="crewLikes-61" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">남성만 가능</span><span class="tag highlight-tag">초보도 환영</span><span class="tag normal-tag">친목도 중요</span></div><div class="crewName" id="crew-name">테스트를 위한 크루 생성입니다. </div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;금천구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">목,금</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">10</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(60)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(60)"><img id="crewLikes-60" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">대회 목적</span></div><div class="crewName" id="crew-name">테스트 하겠습니다...222</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">경기&nbsp;성남시 분당구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월,화</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">8</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(59)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(59)"><img id="crewLikes-59" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">대회 목적</span><span class="tag highlight-tag">러닝에 집중</span><span class="tag normal-tag">소규모 크루</span></div><div class="crewName" id="crew-name">테스트 하겠습니다...</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;강서구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월,화</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">3</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(57)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(57)"><img id="crewLikes-57" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">러닝에 집중</span><span class="tag highlight-tag">친목도 중요</span></div><div class="crewName" id="crew-name">크루크루</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;강서구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월,화</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">3</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(54)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(54)"><img id="crewLikes-54" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">I 환영해요</span><span class="tag highlight-tag">러닝에 집중</span></div><div class="crewName" id="crew-name">테스트쿠루22222</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;강서구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">화,수</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">4</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(52)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(52)"><img id="crewLikes-52" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">여성만 가능</span></div><div class="crewName" id="crew-name">용산 러닝크루🏃&zwj;♀️</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;마포구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">토,일</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">6</span> / <span class="member" id="member">30</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(50)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(50)"><img id="crewLikes-50" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">대회 목적</span><span class="tag highlight-tag">러닝 고수만</span><span class="tag normal-tag">초보도 환영</span></div><div class="crewName" id="crew-name">수정 테스트 1차</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;금천구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">수,목</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">16</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(48)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(48)"><img id="crewLikes-48" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">남성만 가능</span><span class="tag highlight-tag">러닝에 집중</span><span class="tag normal-tag">친목도 중요</span></div><div class="crewName" id="crew-name">수정 테스트 1차</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">충북&nbsp;제천시</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">수,목</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">16</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(46)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(46)"><img id="crewLikes-46" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">남성만 가능</span><span class="tag highlight-tag">러닝에 집중</span><span class="tag normal-tag">친목도 중요</span></div><div class="crewName" id="crew-name">진짜 이동..</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;강남구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월,화</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">12</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(45)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(45)"><img id="crewLikes-45" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">남성만 가능</span><span class="tag highlight-tag">러닝에 집중</span><span class="tag normal-tag">친목도 중요</span></div><div class="crewName" id="crew-name">최종 이동 테스트</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;송파구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월,화</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">12</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(44)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(44)"><img id="crewLikes-44" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">남성만 가능</span><span class="tag highlight-tag">러닝에 집중</span><span class="tag normal-tag">친목도 중요</span></div><div class="crewName" id="crew-name">이동 테스트 등록</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;송파구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월,화</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">12</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(43)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(43)"><img id="crewLikes-43" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">대회 목적</span><span class="tag highlight-tag">여성만 가능</span></div><div class="crewName" id="crew-name">ㅇㅇ태스트</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;서초구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">금,토</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">2</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(42)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(42)"><img id="crewLikes-42" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">러닝에 집중</span><span class="tag highlight-tag">친목도 중요</span></div><div class="crewName" id="crew-name">이동test</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">부산&nbsp;동래구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월,화</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">2</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(41)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(41)"><img id="crewLikes-41" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">대회 목적</span><span class="tag highlight-tag">친목도 중요</span></div><div class="crewName" id="crew-name">10.23 이런저런 크루 등록</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">서울&nbsp;동작구</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">목,금</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">10</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div><div class="crewBox" onclick="crewDetail(40)"><div class="crewImg"><img class="crew-img" id="crew-image" src="/resources/img/crew/crewImg300.png" onerror="this.src='/resources/img/crew/crewImg300.png'"><div onclick="crewLikeCheck(40)"><img id="crewLikes-40" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"></div></div><div class="crewContentBox"><div class="tagBox2"><span class="tag normal-tag">러닝에 집중</span></div><div class="crewName" id="crew-name">ㅁㅁ</div><div class="crewInfo-01"><img src="/resources/img/crew/img01.png" width="10px" class="imglayout"><span id="crew-location">경남&nbsp;사천시</span>  &nbsp; &nbsp; &nbsp;<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"><span id="crew-days">월</span></div><div class="crewInfo-02"><div class="inone"><img src="/resources/img/crew/img02.png" width="13px" class="imglayout"><span class="current_member" id="current_member">1</span> / <span class="member" id="member">3</span></div><div class="crewStatus01"><span id="is_recruit">모집중</span></div></div></div></div></div>
    
		
		 */
		
		
	 	var likeCrew = [];
	 	crewList(1);
	 	var crewLikeStatus = {}; // 각 크루별 idx 와 y/n 정보를 담음 ex) 1 : Y, 2 : N ...
		 
		// 크루리스트 불러오기
		function crewList(page){
			$('#loading').css('opacity', '1');
		    isLoading = true;
			// 필터링된 값을 배열로 업데이트하는 함수
			 //updateFiltering();
		
			//console.log("filtering > ", filtering)
		  	$.ajax({
				type: 'GET',
				async: true, // 비동기 방식이지만 데이터를 동기로 기다렸다가 다음 요청 보내기
				url: '/crew/list',
				data: $.param({'page': page, 'pageSize': 4 }, true),
				dataType: 'JSON',
				success: function(response){
					var result = response.result;
					console.log('오는값 => ',result);
					
					crewListPrint(result);
					if (loginId) updateHeartIcons(result);  // 로그인한 경우 좋아요 아이콘 업데이트
					
					
				},error: function(e){
					console.log('에러 => ', e);
					$('#loading').hide();
	                isLoading = false;
				}
			}); 
			
		}
		
		
		function fetchLikedCrews(){
			$.ajax({
				type: 'POST',
				url: 'crew/likeCrew',
				data: {'id' : loginId},
				dataType: 'JSON',
				success: function(response){
					console.log(response);
					var result = response.result;
					result.forEach(function(item){
						/* likeCrew = item.crew_idx; */
						likeCrew.push(item.crew_idx);
						console.log('idx값 => ',likeCrew);
					});
					
					
					
				},error: function(e){
					console.log('관심 크루 에러 => ', e);
				}
			});
		}
		
		
		function crewListPrint(result){
			
			var content = '';
			var btn_style = '';
			
			if(result.length > 0){
				result.forEach(function(item, idx){
					
					var day = item.days.replace(/mon|tue|wen|thu|fri|sat|sun/gi, function(match) {
	                    return { mon: '월', tue: '화', wen: '수', thu: '목', fri: '금', sat: '토', sun: '일' }[match.toLowerCase()];
	                });
						
					var is_recruit = '';
					
					if(item.is_recruit === 'Y'){
						is_recruit = '모집중';
						btn_style = '<div class="crewStatus01"><span id="is_recruit">'+is_recruit+'</span></div>';
					}else{
						is_recruit = '모집완료';
						btn_style = '<div class="crewStatus02"><span id="is_recruit">'+is_recruit+'</span></div>';
					}
					
					var imgElem = '';
					if(item.img_new === null || item.img_new === ''){
						imgElem = '/resources/img/crew/crewImg300.png';
					}else{
						imgElem = '/photo/'+item.img_new;
					}
					
	                // 태그 처리
	                var tagNamesArray = item.tag_names ? item.tag_names.split(',') : [];
	                var displayedTags = '';
	                
	                tagNamesArray.slice(0, 3).forEach(function(tag, index) {
	                    var styleClass = index === 1 ? 'highlight-tag' : 'normal-tag';
	                    displayedTags += '<span class="tag ' + styleClass + '">' + tag + '</span>';
	                });
	                
	                

					content += '<div class="crewBox" onclick="crewDetail('+item.crew_idx+')">';
					content += '<div class="crewImg"><img class="crew-img" id="crew-image" src="' + imgElem + '" onerror="this.src=\'/resources/img/crew/crewImg300.png\'"/>';
						// 좋아요 이미지
					content += '<div onclick="crewLikeCheck('+item.crew_idx+')"><img id="crewLikes-'+item.crew_idx+'" class="crew-like" src="/resources/img/common/ico_heart_no_act.png"/></div></div>';
					// 크루 tag
					content += '<div class="crewContentBox"><div class="tagBox2">' + displayedTags + '</div>';
					
					content += '<div class="crewName" id="crew-name">'+item.crew_name+'</div>';
					content += '<div class="crewInfo-01">';
					content += '<img src="/resources/img/crew/img01.png" width="10px" class="imglayout"/>';
					content += '<span id="crew-location">'+ item.shortsido + '&nbsp;' +item.sigungu +'</span>  &nbsp; &nbsp; &nbsp;';
					content += '<img src="/resources/img/crew/img03.png" width="14px" class="imglayout"/>';
					content += '<span id="crew-days">'+day+'</span>';
					content += '</div>';
					content += '<div class="crewInfo-02">';
					content += '<div class="inone">';
					content += '<img src="/resources/img/crew/img02.png" width="13px" class="imglayout"/>';
					content += '<span class="current_member" id="current_member">'+ item.current_member +'</span> / <span class="member" id="member">'+ item.member +'</span></div>';
					content += btn_style;
					content += '</div>';
					content += '</div>';
					content += '</div>';
					
					var is_recruit = item.is_recruit;
				});
				
				$('.crewListBox').append(content);
				$('#loading').css('opacity', '0'); // loading 요소를 투명하게 설정
	            isLoading = false; // 로딩 상태 해제
	            
	            
	    	    var crewBoxes = $('.crewListBox .crewBox');
	    	    var crewListBox = $('.crewListBox');
	    	    // crewBox가 홀수일 때 마지막 요소에 left-align-last 클래스를 추가하고, 전체 왼쪽 정렬
	    	    if (crewBoxes.length % 2 !== 0) {
	    	        crewBoxes.last().addClass('left-align-last');
	    	        crewListBox.css('justify-content', 'flex-start'); // 전체를 왼쪽 정렬
	    	    } else {
	    	        crewListBox.css('justify-content', 'center'); // 짝수일 때는 중앙 정렬 유지
	    	    }
				
			}else{
				hasMoreData = false;
				$('#loading').text('모든 크루 정보를 불러왔습니다.').css('opacity', '1');
			}
		}

		
		function crewDetail(crew_idx){
			console.log('이동 =>', crew_idx)
			location.href="/crewDetail/"+crew_idx; 
				
		}
		

		function updateHeartIcons(result) {
			
	/* 		likeCrew.forEach(function(item){
				console.log("crew_idx : ", item.crew_idx, "타입", typeof item.crew_idx);
			}); */

		    result.forEach(function(item) {
		        // crew_idx 타입 확인
		        console.log("item.crew_idx:", item.crew_idx, "타입:", typeof item.crew_idx);
				console.log("likeCrew 배열 확인:", likeCrew);

		         if (likeCrew.includes(item.crew_idx)) {
		        	 $('#crewLikes-'+item.crew_idx).attr('src', '/resources/img/common/ico_heart_act.png');
		        	 crewLikeStatus[item.crew_idx] = 'Y';
		            console.log('같은거 있음', item.crew_idx);
		        } else {
		        	crewLikeStatus[item.crew_idx] = 'N';
		            console.log('같은거 없음', item.crew_idx);
		        } 
		    });

		}	 	
		
		function crewLikeChange(crew_idx, currentStatus){ // 선택된 크루의 idx 와 상태값(y/n) 가져옴
			console.log('잘 실행? : crew_idx => ', crew_idx);
			console.log('해당 크루 좋아요 상태 값 => ', currentStatus);
			
			$.ajax({
				type: 'POST',
				url: 'crew/likeRequest',
				data: {'loginId' : loginId,
					'crew_idx' : crew_idx,
					'likeCrew' : currentStatus},
				dataType: 'JSON',
				success: function(response){
					var result = response.result;
					if(response.success){
						alert(response.msg);
						fetchLikedCrews();
						crewList(currentPage);
						console.log('좋아요 상태 변경 성공');
					}
				},error: function(e){
					console.log('좋아요 상태 변경 중 에러 => ', e);
				}
			});
			
		}
		
		function crewLikeCheck(crew_idx){
			console.log('좋아요 이벤트 실행됨?');
			event.stopPropagation(); // 이벤트 전파 방지
		    event.preventDefault(); // 상위 태그 이벤트 중지
		    
		    if(loginId){
		    	
		    	var currentStatus = crewLikeStatus[crew_idx] || 'N'; // crew_idx 별 값 가져오기
		    	
		    /* 	if()
		    	var currentStatus = crewLikeStatus[crew_idx] || 'N';  */// 현재 상태 없을 시 기본값
		    	
		    	if(currentStatus === 'Y'){
		    		console.log('좋아요 취소 신청');
		    		crewLikeChange(crew_idx, currentStatus);
		    	}else{
		    		console.log('좋아요 등록 신청');
		    		crewLikeChange(crew_idx, currentStatus);
		    	}
		    }else{
		    	layerPopup('로그인이 필요한 서비스입니다.', '로그인 하기', '취소', loginPageLocation, applBtn2Act);
		    }
		}
		
		
</script>
</html>