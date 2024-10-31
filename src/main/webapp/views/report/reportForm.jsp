<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <script src="/resources/js/layerPopup.js"></script>
    <script src="/resources/js/report.js"></script>
    <script src="/resources/js/reportSummernote.js"></script>
    
<style>
	#duri {
   	   position: relative;
   	   width: 760px;
       padding: 34px 50px 10px;
       height: fit-content;
   	   overflow-y: auto;
   	   border: 1px solid #EAEAEA;
   	   margin: 80px auto 0;
   	   
    }
    .con{
	   width: 500px;
	   height: 300px;
	   resize: none;
	   border-radius: 6px;
       border: 1px solid var(--input-bd);
    }	
	.reportTag{
		display: flex;
	    margin-bottom: 25px;
	}
	.reportId{
		display: flex;
		margin-bottom: 25px;
	}
	.reportSub{
		display: flex;
		margin-bottom: 25px;
	}
	.reportFile{
		display: flex;
		margin-bottom: 25px;
	}
	.reportCon{
		display: flex;
		margin-bottom: 25px;
	}
	.reportBtn{
		
		margin-bottom: 40px;    
	    margin-left: 34%;
	    transform: translateY(30px);
	    
	}
	#dari{
		text-align: center;
    	transform: translateY(50px);
    	margin-top: -60px;
	}
	.tag-m-gray{
		margin-left: 25px;
	}
	.user{
		margin-left: 25px;
		transform: translateY(2px);
	}
	.sub{
		margin-left: 40px;
   		transform: translateY(-7px);
   		width: 500px !important;
	}
	#file{
		margin-left: 25px;
	}
	.con{
		margin-left: 40px;
	}
	a{
    	color: #333;
    }
    .rel{
	    position: relative;
	    width: 890px;
	    padding: 34px 50px 10px;
	    height: calc(86vh - 130px);
	    overflow-y: auto;
    }
    .rel::-webkit-scrollbar {
	    width: 10px;
	}
	.rel::-webkit-scrollbar-track {
	    background-color: #eaeaea;
	}
	.rel::-webkit-scrollbar-thumb { 
	    background-color: #d0d0d0;
	    border-radius: 10px;
	}
	.rel::-webkit-scrollbar-button {
	
	    display: none;
	}
	
	
</style>
</head>
<body>
<form enctype="multipart/form-data">
<div class="rel">
	
	<input type="hidden" value="${report.board_idx}" name="board_idx" readonly="readonly">
	<input type="hidden" value="${report.id}" name="reput" readonly="readonly">
	<input type="hidden" value="${report.code_name}" name="code_name" readonly="readonly">
	 
	<input type="hidden" value="${comment.comment_idx}" name="comment_idx" readonly="readonly">
	<input type="hidden" value="${comment.id}" name="nick" readonly="readonly">
	<input type="hidden" value="${comment.code_name}" name="code_comment" readonly="readonly">
	<p class="title1" id="dari"><img style="height: 30;" src="/resources/img/run/진짜신고.png" alt="아이콘">
		신고하기
	<img style="height: 30;" src="/resources/img/run/진짜신고.png" alt="아이콘"></p>
	<div id="duri">
		<div class="reportTag">
			<span id="span1" class="title2" style=" margin-left: 10;">카테고리 </span>
			<c:choose>
				<c:when test="${report.code_name != null}">
					<div class="tag-m-gray">게시글</div>
			    </c:when>
			    <c:otherwise>
			    	<div class="tag-m-gray">댓글</div>  			
				</c:otherwise>
		    </c:choose>
		</div>
		<div class="reportId">
			<span id="span1" class="title2" style=" margin-left: 10;">작성자 </span>
			<p class="user">${sessionScope.loginId}</p>
		</div>
		<div class="reportSub">
			<span id="span1" class="title2" style=" margin-left: 10;">제목 </span>
			<input type="text" class="sub" name="subject" placeholder="제목을 입력해 주세요." required />
		</div>
		<div class="reportFile">
			<span id="span1" class="title2" style=" margin-left: 10;">이미지 </span>
			<input type="file" name="report_img" id="file" />
		</div>
		<div class="reportCon">
			<span id="span1" class="title2" style=" margin-left: 10;">내용 </span>
			<textarea  class="con" name="content" placeholder="신고내용을 입력해 주세요." required></textarea>
		</div>
	</div>
	<div class="reportBtn">
		<button type="button" class="btn03-l" id="cancle">취소하기</button>
			<c:choose>
				<c:when test="${report.code_name != null}">
					<button type="button" class="btn01-l" id="reportBoard" >신고하기</button>
			    </c:when>
			    <c:otherwise>
			    	<button type="button" class="btn01-l" id="reportComment" >신고하기</button>  			
				</c:otherwise>
		    </c:choose>
		   
	</div>
</div>	
</form>


</body>
<script>
	
</script>
<script src="/resources/js/reportComment.js"></script>
</html>