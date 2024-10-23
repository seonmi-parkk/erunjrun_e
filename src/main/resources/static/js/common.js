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


// 태그 체크박스 클릭시 label에 클래스 추가

 