// header 사용자에 맞춰 정보 변경
/*
$.ajax({
	type: 'GET',
	url: 'header.ajax',
	data:{},
	datatype: 'JSON',
	success:function(data){
	
	},
	error:function(e){
	}
});
*/

// 헤더 마우스오버 애니메이션
$('.menu > li ').on({
	'mouseover' : function(){
		$(this).find('.depth2').stop().slideDown(200);
	},
	'mouseleave' : function(){
		$(this).find('.depth2').stop().slideUp(200);
	},
});

// 관리자모드 헤더 토글
$('.toggle-slider').on('click',function(){
	$(this).parent().toggleClass('on');
	if($('.admin-mod').hasClass('on')){
		$(this).siblings('span').text('관리자');
	}else{
		$(this).siblings('span').text('일반');
	}
});

// loading 시 
function loading(){
	$('body').append('<div class="loading-bg"><div class="lds-spinner"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div></div>');
}
// loading 완료시
function loadingComplete(){
	$('.loading-bg').remove();
}


// 태그 체크박스 클릭시 label에 클래스 추가

 