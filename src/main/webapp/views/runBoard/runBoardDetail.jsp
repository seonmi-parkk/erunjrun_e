<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>러닝코스 게시글 상세보기</title>
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
    	#butt{
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
			  padding: 20px;
			  border-radius: 15px;
			  justify-content: space-between;
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
			  min-height: 120px;
			  
		}
		#con{
			width: 1200px;
			height: 250px;
			font-size: 16;
		}
		.dat {
			display: flex;
			justify-content: space-between;
		}
		
		.detail{
			    margin-left: 35px;
		}
		#bih{
			margin-top: -50px;
		}
		
		.nick{
			margin-left: 18;
   		 	margin-bottom: 7px;
		}

		.date{
			margin-left: 50;
			margin-top: 10px;
		}
		
		.supa{
			margin-left: 60px;
   		 	margin-top: -20px;
		}
		.coco{
			width: 1000;
   		 	margin-left: 50px;
		}
		#ins{
			margin-left: -28px;
			margin-top: 34px;
		}
		input[type="text"].tex{
    		margin-left: 30px;
    		width: 1000px;
		}
		.bubu{
			display: flex;
			justify-content: space-between;
			margin: 17px;
		}
		.suj1{
			  background: #eeeeee;
			  border: solid 1px;
			  border-color: AEAEAE;
			  text-align: center;
			  margin-top: 5px;
		}
		.suj2{
			  background: #eeeeee;
			  border: solid 1px;
			  border-color: AEAEAE;
			  text-align: center;
			  
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
					<p class="title2">${info.subject}</p>
					<p class="title3-1"><img style="height: 30;" src="resources/img/run/running_8421565.png" alt="아이콘">  ${info.nickname}</p>
				</div>
				<div style="text-align: right;" class="duri">
					<div id="butt"class=btn03-s>비활성화</div>					
					<p class="title3-2">${info.create_date}</p>
					<span class="title3-3">조회수 ${info.bHit}</span>
					<span class="title3-4"><img src="resources/img/run/image 14.png" alt="댓글"> 댓글 2</span>
				</div>
			</div>
			<div class="ori">
				<div id="map" style="width:1200px; height:400px;"></div>
				<br>
				<div id="con">${info.content}</div>
			</div>
	    	<div class="repo">
				<div id="pre" class="btn-like btn02-s" style="padding: 20px;"><img src="resources/img/common/ico_heart_act.png" alt="좋아요" style="height: 17px;"></div>
		    	<div id="reo" class="btn-like btn02-s" style="padding: 20px;"><img src="resources/img/run/신고.png" alt="신고"></div>	    	
	    	</div>
	    	<div class="supa">
		    	<span id="title2-1" class="title2">등록순</span>
	    		<span id="title2-2" class="title2">최신순</span>
	    	</div>
	    	<div class="sort">
 				<div>
		    		<div class="nick"><img style="height: 30;" src="resources/img/run/running_8421565.png" alt="아이콘">     김진형</div>
		    		<p class="coco">댓글내용</p>
		    		<div class="date">2024-10-25</div>
	    		</div>
	    		<div class="ard">
		    		<div class="detail"><img style="height: 5; margin-top: 25px;" src="resources/img/run/Group 308.png" alt="상세"></div>
		    		<div id ="bih" class=btn03-s>비활성화</div>
		    		<div class="suj1">수정</div>
		    		<div class="suj2">삭제</div>
	    		</div>
    		</div>
	    	<div class="com">
	    		<div>
	    			<div class="nick"><img style="height: 30;" src="resources/img/run/running_8421565.png" alt="아이콘">     김진형</div>
		    		<input type="text" class="tex">
	    		</div>
	    		<div>
	    			<div id="ins" class=btn03-s>등록</div>	    		
	    		</div>
	    	</div>
	    </div>
	    <div class="bubu">
	    	<div class="bbs">
		        <button type="button" class="btn01-l" onclick="#">수정</button>
			    <button type="button" class="btn03-l" onclick="#">삭제</button>	    	    	
	    	</div>
		    <button type="button" class="btn02-l" onclick="#">목록</button>
	    </div>
	
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
