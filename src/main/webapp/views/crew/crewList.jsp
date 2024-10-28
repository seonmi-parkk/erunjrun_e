<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crew List</title>
<link rel="stylesheet" href="/resources/css/crew.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
	
	.innerr {
	    max-width: 1300px; /* 전체 페이지의 최대 너비를 1300px로 제한 */
	    margin: 80px auto 0; /* 상단에 80px의 여백을 주고, 중앙에 배치 */
	    display: block; /* 요소를 블록 레벨 요소로 설정 */
	    justify-content: space-between; /* 자식 요소 사이의 공간을 균등하게 분배 */
	    align-items: flex-start; /* 자식 요소를 위쪽 정렬 */
	    gap: 20px; /* 자식 요소 사이의 간격을 20px로 설정 */
	}
	
	.div,
	.div * {
	    box-sizing: border-box; /* 모든 요소의 패딩과 보더를 요소의 너비와 높이에 포함 */
	}
	
	.layoutbox {
	    height: 290px; /* 상단 배너 영역의 높이를 290px로 설정 */
	    background-color: white; /* 배경색을 흰색으로 설정 */
	    flex: auto; /* 남은 공간을 자동으로 채움 */
	    display: flex; /* 내부 요소를 수평으로 배치 */
	    align-items: center; /* 내부 요소들을 수직 중앙 정렬 */
	    justify-content: center; /* 내부 요소들을 수평 중앙 정렬 */
	}
	
	.mainText {
	    color: #333; /* 텍스트 색상을 짙은 회색으로 설정 */
	    text-align: center; /* 텍스트를 중앙 정렬 */
	    font-family: "GmarketSansTtf-Bold", sans-serif; /* 텍스트의 폰트를 설정 */
	    font-size: 34px; /* 텍스트 크기를 34px로 설정 */
	    line-height: 60px; /* 줄 간격을 60px로 설정 */
	    letter-spacing: -0.4px; /* 텍스트 간격을 좁게 조정 */
	    font-weight: 1000; /* 텍스트의 두께를 굵게 설정 */
	    position: relative; /* 위치를 상대적으로 설정 */
	    height: 113px; /* 요소의 높이를 113px로 설정 */
	    display: flex; /* 내부 요소를 수평으로 배치 */
	    align-items: center; /* 내부 요소를 수직 중앙 정렬 */
	    justify-content: center; /* 내부 요소를 수평 중앙 정렬 */
	}
	
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
	    gap: 20px; /* 크루 박스 간의 간격을 20px로 설정 */
	    justify-content: center; /* 중앙 정렬하여 배치 */
	}
	
	.crewBox {
	    margin: 40px 50px 0px 50px; /* 상단 20px, 좌우 50px의 여백 */
	    background-color: #fff; /* 크루 박스 배경을 흰색으로 설정 */
	    border-radius: 12px; /* 모서리를 둥글게 설정 */
	    width: 40%; /* 박스 너비를 40%로 설정 */
	    padding: 20px; /* 내부 여백을 20px로 설정 */
	    box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25); /* 그림자 효과 추가 */
	    display: flex; /* 내부 요소를 수평으로 배치 */
	    gap: 22px; /* 내부 요소 간의 간격을 22px로 설정 */
	}
	
	.crewImg {
	    position: relative; /* 하트 아이콘이 이미지 위에 배치될 수 있도록 상대 위치 설정 */
	    width: 140px; /* 이미지의 너비를 140px로 설정 */
	    height: 140px; /* 이미지의 높이를 140px로 설정 */
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
	    font-size: 18px; /* 글자 크기를 18px로 설정 */
	    margin-top: 8px; /* 위쪽 여백을 8px 추가 */
	}
	
	.crewInfo-01, .crewInfo-02 {
	    color: #333; /* 텍스트 색상을 회색으로 설정 */
	    font-size: 16px; /* 글자 크기를 14px로 설정 */
	    margin-top: 7px; /* 위쪽 여백을 7px 추가 */
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
	
	
	
	
	.inone {
	    display: flex; /* 요소를 수평으로 나열 */
	    align-items: center; /* 수직 중앙 정렬 */
	    margin-top: 5px; /* 위쪽 여백을 5px 추가 */
	}
	
	.imglayout {
	    margin-right: 10px; /* 오른쪽에 10px 간격 */
	    margin-bottom: -1px; /* 아래쪽 여백을 -1px로 설정 */
	}
	
	.tagImg-01{
		margin-right: 5px;
	}


	.left-align-last {
	    margin-left: 50px; /* 왼쪽으로 정렬 */
	}
	
	.current_member{
		color: #FD6F22;
	}
	
	.member{
		color: #333;
	}
	
	#is_recruit{
		color: white;
	}

    
</style>

</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<div class="innerr">
	
		<div class="layoutbox">
			<div class="mainText">
 				나의 취향에 딱 맞는<br/>
				러닝크루와 함께 달려요
			</div>
		</div> <!-- layoutbox -->
		
		<div class="tagBox">
			<span id="tagFilter">
				<label><input type="checkbox" name="tag_idx_list" value="is_recruit"/>🔔 모집중</label>
                <label><input type="checkbox" name="tag_idx_list" value="1">🏃‍♂️러닝에 집중</label>
                <label><input type="checkbox" name="tag_idx_list" value="2">🙋‍♀️ 친목도 중요</label>
                <label><input type="checkbox" name="tag_idx_list" value="3"><img src="resources/img/common/ico_male.png" width="9px" class="tagImg-01"/> 남성만 가능</label>
                <label><input type="checkbox" name="tag_idx_list" value="4"><img src="resources/img/common/ico_female.png" width="9px" class="tagImg-01"/> 여성만 가능</label>
                <label><input type="checkbox" name="tag_idx_list" value="5"><img src="resources/img/common/ico_male.png" width="9px" class="tagImg-01"/><img src="resources/img/common/ico_female.png" width="9px" class="tagImg-01"/> 혼성</label>
                <label><input type="checkbox" name="tag_idx_list" value="6"> <b style='color: #FD6F22' class="tagImg-01">E</b> 환영해요</label>
                <label><input type="checkbox" name="tag_idx_list" value="7"> <b style='color: #116DCA' class="tagImg-01">I</b> 환영해요</label>
                <label><input type="checkbox" name="tag_idx_list" value="8">🐂 소규모 크루</label>
                <label><input type="checkbox" name="tag_idx_list" value="9">🏆 대회 목적</label>
                <label><input type="checkbox" name="tag_idx_list" value="10">💦 러닝 고수만</label>
                <label><input type="checkbox" name="tag_idx_list" value="11">🥳 초보도 환영</label>
                <label><input type="checkbox" name="tag_idx_list" value="shortsido_area"/>🗽 수도권(서울,경기,인천)</label>
                <label><input type="checkbox" name="tag_idx_list" value="shortsido_etc"/><b style='color: gray' class="tagImg-01">#</b>수도권 외</label>
                <label><input type="checkbox" name="tag_idx_list" value="weekdays"/><b style='color: #116DCA' class="tagImg-01">W</b>평일 포함</label>
                <label><input type="checkbox" name="tag_idx_list" value="weekend"/><b style='color: #FD6F22' class="tagImg-01">S</b>주말 포함</label>
                
            </span> <br>
		</div> <!-- tagBox -->
		
		<div class="crewListBox"> </div> <!-- crewListBox -->
		
		<div class="layoutbox-bt"></div>
		
	</div> <!-- inner -->
	
	<div id="loading" style="text-align: center; padding: 20px;">Loading...</div>
	
	<jsp:include page="../footer.jsp"/>
</body>
<script src="/resources/js/common.js"></script>
<script>

	var currentPage = 1;
	var isLoading = false;
	var hasMoreData = true;
	var filtering = [];
	// 크루가 홀수일 때 마지막 crowBox 왼쪽 정렬
	$(document).ready(function() {
		
		

		
		crewList(currentPage); // 1 전달 (현재 페이지)
		
        // IntersectionObserver 설정
        var observer = new IntersectionObserver(function(entries) {
            if (entries[0].isIntersecting && !isLoading) {
            	console.log('loading 에 도착');
                currentPage++; // 다음 페이지 요청
                crewList(currentPage); // 페이지 호출
            }
        });
		
        observer.observe(document.getElementById('loading')); // 감시할 요소 지정
		

	    
	    
	    $('input[name="tag_idx_list"]').on('click', function() {
            currentPage = 1; // 페이지 초기화
            hasMoreData = true;
            $('.crewListBox').empty(); // 기존 목록 초기화
            updateFiltering(); // 필터링 배열 업데이트
            crewList(currentPage); // 필터링된 리스트 요청
        });

	});

	// 필터 배열
	function updateFiltering() {
	    filtering = $('input[name="tag_idx_list"]:checked').map(function() {
	        return $(this).val();
	    }).get(); // 체크된 값만 배열로 가져옴
	    console.log('필터 =>', filtering);
	}
	
	
	function crewList(page){
		$('#loading').css('opacity', '1');
	    isLoading = true;
		// 필터링된 값을 배열로 업데이트하는 함수
		 updateFiltering();
	
	  	$.ajax({
			type: 'GET',
			url: '/crew/list',
			data: $.param({'filtering': filtering, 'page': page, 'pageSize': 10 }, true),
			dataType: 'JSON',
			success: function(response){
				var result = response.result;
				console.log('오는값 => ',result);
				
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
	
						content += '<div class="crewBox" onclick="crewDetail()">';
						content += '<div class="crewImg"><img class="crew-img" id="crew-image" src="' + imgElem + '" onerror="this.src=\'/resources/img/crew/crewImg300.png\'"/>';
	 					// 좋아요 이미지
						content += '<div onclick="crew_like()"><img class="crew-like" src="resources/img/common/ico_heart_no_act.png"/></div></div>';
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
				
				
			},error: function(e){
				console.log('에러 => ', e);
				$('#loading').hide();
                isLoading = false;
			}
		}); 
		
	}
	
	function crew_like(){
		console.log('크루좋아요 누름');
	}
	
	function crewDetail(){
		console.log('크루 이동');
		location.href='#'; // 해당 크루의 idx 를 통해 이동
			
	}
	
	var checkboxes = document.querySelectorAll('#tagFilter input[type="checkbox"]');

	checkboxes.forEach(function(checkbox){
	  checkbox.addEventListener('click', function() {
	    if (this.checked) {
	      this.parentElement.classList.add('checked');
	    } else {
	      this.parentElement.classList.remove('checked');
	    }
	  });
	});

	 
	
</script>
</html>