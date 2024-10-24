<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>러닝코스 게시글 등록</title>
    <link rel="stylesheet" href="/resources/css/common.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26c56d5b3e89329f848d1188b85f2e3d"></script>
    <script src="/resources/js/common.js"></script>
    <style>
        #dori {
            width: 1280px;          /* 박스의 너비 설정 */
            /* 박스의 높이 설정 */
            border: 1px solid #EAEAEA;  /* 연한 회색(#d3d3d3) 선 설정 */
            background-color: transparent;
            margin: 80px auto 0;
        }
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
	<div class="inner">
		<p class="title1">러닝코스 게시글</p>
		<div id="dori">
			<p class="title2">러닝코스 게시글 입니다.</p>
			<div class="btn-like btn02-s"><img src="resources/img/common/ico_heart_no_act.png" alt="좋아요"></div>
	    	<div class="btn-like btn02-s"><img src="resources/img/common/ico_heart_act.png" alt="좋아요"></div>
	    </div>
	</div>
    <jsp:include page="../footer.jsp" />

    
</body>
<script>
        
</script>
</html>
