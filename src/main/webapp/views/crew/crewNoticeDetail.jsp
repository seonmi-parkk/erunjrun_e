<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crew Notice Detail</title>   
    <link rel="stylesheet" href="/resources/css/common.css">
    <link rel="stylesheet" href="/resources/css/crew/crewNoticeDetail.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d&libraries=services"></script>
	<script src="/resources/js/common.js"></script>
	<script src="/resources/js/layerPopup.js"></script>

</head>
<body>
    <jsp:include page="../header.jsp" />
    <input type="hidden" name="notice_idx" value="${notice_idx}"/>
    <input type="hidden" name="loginId" value="${loginId}"> 
	<div class="inner">
		<p class="title1">크루 공지사항</p>
		
		<div id="dori">
			<div class="rectangle-250">
				<div class="dari">
					<p class="title2" id="subject"></p>
					<div class="title3-1" id="leader">
						<img alt="profileImg" src="/resources/img/common/profile.png" onerror="this.src='/resources/img/common/profile.png'" id="profileImg" width = 30px;>
						<div class="profile-box2"></div>
						<span id="leaderId"></span>
					</div>
				</div>
				<div style="text-align: right;" class="duri">
					<div id="butt" class="btn03-s" style='visibility : hidden' onclick="layerPopup('공지를 삭제하시겠습니까?', '삭제', '취소', crewNoticeDelete ,applBtn2Act)">비활성화</div>					
					<p class="title3-2" id="create_date"></p>
					<span class="title3-3" >조회수 </span><span id="hit"></span>
					<span class="title3-4" ><img src="/resources/img/run/image 14.png" id="comment" alt="댓글">댓글 <span id="commentNum"></span></span>
				</div>
			</div>
			<div class="ori">
				<div id="content"></div>
			</div>
			
	    	<div class="supa">
		    	<span id="title2-1" class="title21" onclick="commentCall('ASC')" style="cursor: pointer;">등록순</span>
	    		<span id="title2-2" class="title21" onclick="commentCall('DESC')" style="cursor: pointer;">최신순</span>
	    	</div>
	    	
	    	<!-- 댓글 리스트 -->
	    	<div id="list"> </div>
	   		
	    	<div class="com">
	    		<div>
	    			<input type="hidden" name="unlike_id" value="${sessionScope.loginId}"/>
	    			<input type="hidden" name="userName" value="${nickname.nickname}"/>
	    			<input type="hidden" name="icon_image" value="${nickname.icon_image}"/>
	    			<input type="hidden" name="admin" value="${sessionScope.adminYn}"/>
	    			<div class="nick" id="name"></div>
		    		<input type="text" class="tex">
	    		</div>
	    		<div>
	    			<div id="ins" class=btn01-s onclick="comment()">등록</div>	    		
	    		</div>
	    	</div>
	    </div>
	    <div class="bubu">
	    	<div class="bbs"> <!-- -->
			    <button type="button" class="btn01-m"  style='visibility : hidden' onclick="location.href='/crewNoticeUpdate/${notice_idx}'">수정</button>
			    <button type="button" class="btn03-m"  style='visibility : hidden' id="btn-popup"  onclick="layerPopup('공지를 삭제하시겠습니까?', '삭제', '취소', crewNoticeDelete ,applBtn2Act)">삭제</button>	
	    	</div>
		    <button type="button" class="btn02-m"  onclick="crewNoticeListView()" >목록</button>
	    </div>
	    
	    
		<!-- 모달 -->
		<div id="profilePopup" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div id="PopupBody"></div>
		    </div>
		</div>
		
		<!-- 신고페이지 모달 -->
		<div id="reportPopup" class="modal">
		    <div class="modal-content">
		        <span class="dis">&times;</span>
		        <div id="reportPopupBody"></div>
		    </div>
		</div>
		
		
		
		
	</div>
	<div class="layoutbox-bt"></div>
	
    <jsp:include page="../footer.jsp" />

    
</body>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/crew/crewNoticeDetail.js" type="text/javascript"></script>
<script>

commentCall('ASC');

function commentCall(order='DESC') {
	
	var notice_idx = $('input[name="notice_idx"]').val();
	console.log("공지사항 no :",notice_idx);
	
	$.ajax({
    	type: "POST",
        url: "/crewComment/" + notice_idx ,
        data: { 'notice_idx': notice_idx, 'order': order },
        datatype: 'JSON',
        success: function(data) {
            var commentCount = data.list.length;
			$('#commentNum').text(commentCount);                
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
		var nickName = $('#name').text();
		var addName = view.nickname;
		var id = view.id
		console.log('아이디나오냐',id);
		var comment_idx = view.comment_idx;
		var admin = '${sessionScope.adminYn}';
		
		content +='<div id="sort-area">';
		content +='<input type="hidden" name="user_id" value="'+id+'"/>';
		content +='<div class="sort" id="sort-update'+comment_idx+'">';
		content +='<div>';
		content +='<div class="nick"><div class="profile-area"><div class="profile-img" style="background: url(/resources/img/common/profile.png) center center / cover no-repeat;"></div><div class="profile-box" style="background: url(/resources/img/icon/'+view.icon_image+') center center / 100% 100% no-repeat;"></div></div>'+view.nickname+'</div>';
		if(view.use_yn == 'N'){
			content +='<p class="coco" style="color: #999;" >(삭제된 댓글 입니다.)</p>';
		}else{
			content +='<p class="coco">'+view.content+'</p>';
		}
		content +='<div class="date">'+view.create_date+'</div>';
		content +='</div>';
		if(view.use_yn == 'Y'){
			content +='<div class="ard" id="dis">';					
			content +='<div class="detail" style=" cursor: pointer;" onclick="toggleActions(' + comment_idx + ')"><img style="height: 5; margin-top: 25px;" src="/resources/img/run/Group 308.png" alt="상세"></div>';
			
			if(admin == 'Y'){
				content +='<div id ="bih" class=btn03-s  onclick="del('+comment_idx+')">비활성화</div>';
			}
			
			content += '<div class="action-buttons" style="display:none; cursor: pointer;" id="actions-' + comment_idx + '">';
			if(nickName == addName){
				content +='<div class="suj1 btn-popup" style=" cursor: pointer;" onclick="update('+comment_idx+')"  >수정</div>';
				content +='<div class="suj2 btn-popup" style=" cursor: pointer;" onclick="del('+comment_idx+')">삭제</div>';
			}else{
				content +='<div id="sin" style="margin-top: 5px;" data-comment_idx="'+comment_idx+'" onclick="report('+comment_idx+')" style=" cursor: pointer;" class="suj2 btn-popup"  >신고</div>';
			}
			
		}
		content += '</div>';
		content +='</div>';
		content +='</div>';
		content +='</div>';
	});
	$('#list').html(content);
}








	//관리자 세션 체크! 
	var authority = '${sessionScope.adminYn}';
	if(authority === 'Y'){
		$('#butt').css('visibility', 'visible');
	}

</script>
</html>
