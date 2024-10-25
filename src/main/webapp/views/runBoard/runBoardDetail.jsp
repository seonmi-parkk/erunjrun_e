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
        #title3{
        	font-size: 16;
        }
        .rectangle-250,
			.rectangle-250 * {
			  box-sizing: border-box;
			}
		.rectangle-250 {
			  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  height: 140px;
			  position: relative;
			  margin: 40px;
		}
		.btn03-s{
			  margin-left: 1115px;
    		  margin-top: -185px;
    		  position: relative;
		}
		.title3-4{
			position: relative;
		    left: 1108px;
		    bottom: 33px;
		}
		.title3-3{
			position: relative;
		    left: 1015px;
		    bottom: -1px;
		}
		.title1{
			margin-top: 160px;
		}
		
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    <input type="hidden" name="board_idx" value="50"/>
	<div class="inner">
		<p class="title1">러닝코스 게시글</p>
		
		<div id="dori">
			<div class="rectangle-250">
				<p class="title2-1">러닝코스 게시글 입니다.</p>
				<p class="title3-1">감유자나무</p>
				<p class="title3-2">날짜</p>
				<p class="title3-3">조회수 100</p>
				<p class="title3-4"><img src="resources/img/run/image 14.png" alt="댓글"> 댓글 2</p>
				<div class=btn03-s>비활성화</div>
			</div>
			<div class="btn-like btn02-s"><img src="resources/img/common/ico_heart_no_act.png" alt="안좋아요"></div>
	    	<div class="btn-like btn02-s"><img src="resources/img/common/ico_heart_act.png" alt="좋아요"></div>
	    </div>
	    <button type="button" class="btn03-l" onclick="#">목록</button>
	    <button type="button" class="btn03-l" onclick="#">삭제</button>
        <button type="button" class="btn01-l" onclick="#">수정</button>
	
	</div>
    <jsp:include page="../footer.jsp" />

    
</body>
<script>
        
</script>
</html>
