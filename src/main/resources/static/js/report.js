
	/* 신고하기 버튼 이벤트 */
	$('#reportBoard').on('click',function(){
		console.log('신고하기 버튼');
		reportBoard();
	});
	
	function reportBoard(){
		
		var formData = new FormData($('form')[0]); 
		
		var userId = '${sessionScope.loginId}';
		console.log('로그인 유저 : ',userId);
		
		var codeName = 'B100';
		
		
		formData.append('unlike_id',userId);
		formData.append('code_name',codeName);
		formData.append('subject',subect);
		formData.append('content',content);
		
		$.ajax({
            type: 'POST',
            url: '/reportForm',             // 서버에 전송할 URL
            data: formData,               // formData 객체 전송
            contentType: false,          // formData 사용 시 false로 설정
            processData: false,         // formData 사용 시 false로 설정
            enctype: 'multipart/form-data',     // multipart/form-data 사용
            success: function (response) {
                console.log('글 전송 성공:', response);
              
            },
            error: function (e) {
                console.log('신고 전송 에러:', e);
            }
        });
		
	}
	
	
	

	
	
	
	
	
	
	/* 취소하기 버튼 이벤트 */
	$('#cancle').on('click',function(){
		console.log('취소하기 버튼');
		document.getElementById("reportPopup").style.display = "none";
	});
