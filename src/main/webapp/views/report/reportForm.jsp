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
<style>
	#dori {
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
		display: flex;
		margin-bottom: 40px;    
	    margin-left: 0%;
	    transform: translateY(30px);
	    justify-content: space-evenly;
	}
	.title1{
		text-align: center;
    	transform: translateY(50px);
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
	
	
</style>
</head>
<body>
<form enctype="multipart/form-data">
<div class="rel">
	<p class="title1"><img style="height: 30;" src="/resources/img/run/진짜신고.png" alt="아이콘">
		신고하기
	<img style="height: 30;" src="/resources/img/run/진짜신고.png" alt="아이콘"></p>
	<div id="dori">
		<div class="reportTag">
			<span id="span1" class="title2">카테고리 </span><div class="tag-m-gray">게시글</div>
		</div>
		<div class="reportId">
			<span id="span1" class="title2">작성자 </span>
			<p class="user">${sessionScope.loginId}</p>
		</div>
		<div class="reportSub">
			<span id="span1" class="title2">제목 </span>
			<input type="text" class="sub" name="subject" placeholder="제목을 입력해 주세요." required />
		</div>
		<div class="reportFile">
			<span id="span1" class="title2">이미지 </span>
			<input type="file" name="report_img" id="file" />
		</div>
		<div class="reportCon">
			<span id="span1" class="title2">내용 </span>
			<textarea  class="con" name="content" placeholder="신고내용을 입력해 주세요." required></textarea>
		</div>
	</div>
	<div class="reportBtn">
		<button type="button" class="btn03-l">취소하기</button>
	    <button type="button" class="btn01-l" onclick="report()">신고하기</button>
	</div>
</div>	
</form>
</body>
<script>

	function report() {
		var formData = new FormData($('form')[0]);
	}












</script>
</html>