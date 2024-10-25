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
            border-radius: 15px;
        }
        #title3{
        	font-size: 16;
        }
        .rectangle-250,
			.rectangle-250 * {
			  box-sizing: border-box;
			}
		.rectangle-250 {
		
			    display: flex;
    			justify-content: space-between;
			  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
		}
		.duri{
			margin: 15px;
		}
		.title1{
    		margin-top: 160px;
    	}
    	.dari{
    		margin-top: 45px;
    	}
    	.title2{
			transform: translateY(-35px);
    	}
    	.ori{

			  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
    	}
    	.btn03-s{
    		transform: translateY(-35px);
    	}
    	.repo{
    		  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;

    	}
    	#pre{
    		margin-left: 565px;
    		    margin-bottom: 30px;
    	}
    	#reo{
    		border-color: #AAAAAA;
    	}
    	.com{
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 1px 1px 1px 1px;
			  position: relative;
			  margin: 40px;
			  display: flex;
			  padding: 100px;
			  border-radius: 15px;
    	}
    	#title2-1{
    		margin-left: 0px;
    	}
    	.colist{
    		  background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;
    	}
		.sort{
			background: #ffffff;
			  border-style: solid;
			  border-color: #bdbdbd;
			  border-width: 0px 0px 1px 0px;
			  position: relative;
			  margin: 40px;
			  display: flex;
			  justify-content: space-between;
			  height: 120px;
			  
		}
		#con{
			width: 1200px;
			height: 400px;
			font-size: 16;
		}
		.dat {
			display: flex;
			justify-content: space-between;
		}
		/*
		.detail{
			transform: translate(700px, 20px);
		}
		#bih{
			transform: translate(740px, -25px);
		}
		.nick{
			transform: translate(-174px, 19px);
		}
		.coco{
			transform: translate(-217px, 57px);
		}
		.date{
			transform: translate(-273px, 92px);
		}
		*/
		.supa{
			margin-left: 60px;
   		 	margin-top: -20px;
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
				<div class="dari">
					<p class="title2">러닝코스 게시글 입니다.</p>
					<p class="title3-1"><img style="height: 30;" src="resources/img/run/running_8421565.png" alt="아이콘">  감유자나무</p>
				</div>
				<div style="text-align: right;" class="duri">
					<div class=btn03-s>비활성화</div>					
					<p class="title3-2">2024. 10. 25</p>
					<span class="title3-3">조회수 100</span>
					<span class="title3-4"><img src="resources/img/run/image 14.png" alt="댓글"> 댓글 2</span>
				</div>
			</div>
			<div class="ori">
				<div id="map" style="width:1200px; height:400px;"></div>
				<br>
				<div id="con">아~~~~~~~~~집에 가고싶다~~</div>
			</div>
	    	<div class="repo">
				<div id="pre" class="btn-like btn02-s"><img src="resources/img/common/ico_heart_act.png" alt="좋아요"></div>
		    	<div id="reo" class="btn-like btn02-s" ><img src="resources/img/run/신고.png" alt="신고"></div>	    	
	    	</div>
	    	<div class="supa">
		    	<span id="title2-1" class="title2">등록순</span>
	    		<span id="title2-2" class="title2">최신순</span>
	    	</div>
	    	<div class="sort">
 				<div>
		    		<div class="nick"><img style="height: 30;" src="resources/img/run/running_8421565.png" alt="아이콘">     작성자</div>
		    		<p class="coco">댓글내용</p>
		    		<div class="date">날짜</div>
	    		</div>
	    		<div>
		    		<div class="detail"><img style="height: 5;" src="resources/img/run/Group 308.png" alt="상세"></div>
		    		<div id ="bih" class=btn03-s>비활성화</div>
	    		</div>
    		</div>
    	
    

	    	<div class="com">
	    			<div class=btn03-s>등록</div>
	    	</div>
	    </div>
	    <button type="button" class="btn03-l" onclick="#">목록</button>
	    <button type="button" class="btn03-l" onclick="#">삭제</button>
        <button type="button" class="btn01-l" onclick="#">수정</button>
	
	</div>
    <jsp:include page="../footer.jsp" />

    
</body>
<script>
	var mapContainer = document.getElementById('map');
	var mapOption = { 
	    center: new kakao.maps.LatLng(37.566641, 126.978202), 
	    level: 3 
	};
	var map = new kakao.maps.Map(mapContainer, mapOption);	

</script>
</html>
