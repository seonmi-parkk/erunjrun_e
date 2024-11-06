<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>crewWrite</title>
	<link rel="stylesheet" href="/resources/css/crew.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/resources/js/summernote.js"></script>
	<script src="/resources/js/layerPopup.js"></script>
</head>
<body>
    <jsp:include page="../header.jsp" />
    
    
    <div class="crewWriteView"> <!-- 체크박스 순위 올리기 위함 -->

        <div class="inner">
            <form enctype="multipart/form-data">
                <p class="title1">러닝크루 등록</p>
                <input type="hidden" name="loginId" value="${loginId}"> 

                <div id="dori22">
                    <div class="twobox">
                        <div id="img_miri"></div>
                        <span style='color:#d3d3d3'>※ 필수 : 권장 사이즈 800px / 400px</span>
                        <input type="file" name="crew_img" onchange="readFile(this)" id="file" />
                        <label for="file">
                            <div class="btn03-m">이미지 업로드</div>
                        </label>
                    </div>
                    <div class="firstbox"> <!-- 레이아웃 구성을 위한 div -->

                        <div class="boxheigth">
                            <span class="title2">크루명 <span class="requiredTextcw">※ 필수</span></span>
                            <input type="text" name="crew_name" required />
                        </div> <br>

                        <span class="title2">태그 <span class="requiredTextcw">※ 필수</span></span>
                        <span id="tagFilters">

                        </span> <br>

                        <div class="boxheigth">
                            <span class="title2">요일 <span class="requiredTextcw">※ 필수</span></span>
                            <input type="checkbox" name="days" value="mon" /><span class="basictex">월</span>
                            <input type="checkbox" name="days" value="tue" /><span class="basictex">화</span>
                            <input type="checkbox" name="days" value="wen" /><span class="basictex">수</span>
                            <input type="checkbox" name="days" value="thu" /><span class="basictex">목</span>
                            <input type="checkbox" name="days" value="fri" /><span class="basictex">금</span>
                            <input type="checkbox" name="days" value="sat" /><span class="basictex">토</span>
                            <input type="checkbox" name="days" value="sun" /><span class="basictex">일</span>
                        </div> <br>

                        <div class="boxheigth">
                            <span class="title2">인원 <span class="requiredTextcw">※ 필수</span></span> 
                            <input type="number" name="member" min="2" required />
                        </div> <br>

                        <div class="boxheigth">
                            <span class="title2">운동강도 <span class="requiredTextcw">※ 필수</span></span>
                            <input type="number" name="minute" min="1" required /><span class="basictex"> 분 / </span>
                            <input type="number" name="distance" min="1" required /><span class="basictex"> km </span>
                        </div> <br>

                        <div class="boxheigth">
                            <span class="title2">지역 <span class="requiredTextcw">※ 필수</span></span>
                            <input type="text" name="address" id="sample4_roadAddress" required disabled />
                            <input type="button" onclick="search()" class="btn02-m" value="검색">
                        </div>

                    </div> <!-- 레이아웃 구성을 위한 div --> <br>

                    <div class="content_layoutcw"> <!-- 레이아웃 구성을 위한 div -->
                        <p class="title2">크루 설명</p> <br><br>
                        <div class="post-form">
                            <textarea name="postContent" id="summernote" maxlength="10000"></textarea>
                        </div>
                    </div>

                </div>

                <div class="btn-parent">
                    <button type="button" class="btn03-l" onclick="location.href='/crewList'">등록 취소하기</button>
                    <!-- 등록 팝업 추가 필요 -->
                    <button type="button" class="btn01-l" onclick="writeCheck()">크루 등록하기</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="../footer.jsp" />
</body>

<script src="/resources/js/common.js"></script>
<script src="/resources/js/daumapi.js"></script>
<script src="/resources/js/crew/crewWrite.js"></script>

<script>


    
</script>

</html>