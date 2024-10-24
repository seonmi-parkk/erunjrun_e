<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CrewDetail</title>
<link rel="stylesheet" href="/resources/css/crew.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
	.innerr {
	    max-width: 1300px;
	    margin: 80px auto 0;
	    display: flex;                  
	    justify-content: space-between; 
	    align-items: flex-start;        
	    gap: 20px;                      
	}
	
	.one {
	    width: 70%;                     
	    padding: 20px;                  
	    box-sizing: border-box;          
	    background-color: #D5D5D5;
	    position: relative;              /* 기본 요소 배치를 유지 */
	    z-index: 1;                      /* 다른 요소들 위에 놓기 */
	}
	
    .two {
        width: 30%;
        padding: 20px;
        box-sizing: border-box;
        background-color: #FFD9EC;
        position: relative;
        max-height: 500px;
        overflow-y: hidden;
        position: sticky;
        top: 100px;
        z-index: 80;
        display: flex;
        flex-direction: column;
        justify-content: space-between; /* 자식 요소들이 위아래로 배치되도록 설정 */
    }
	
	.layoutbox {
	    height: 130px;                  /* 이 높이와 동일한 값을 .two의 top에 설정 */
	    background-color: white;        /* 헤더 영역이 배경과 겹치지 않도록 배경색 추가 */
	}
	
	#imgbox{
		width : 100%;
		height: 400px;
		background-color: #FFD8D8;
		border-radius: 10px;
	}
	
	.btn03-s1{
		display: inline-block;
	    height: 32px;
	    padding: 6px 11px;
	    margin: 10px 4px;
	    border-radius: 10px;
	    border: 1px solid var(--btn-bd-g);
	    color: var(--btn-bd-g);
	    background: #fff;
	    cursor: pointer;
	    font-size: 14px;
	    float: inline-end; /* 오른쪽 끝으로 배치 */
	    
	}
	
	.btn03-s2{
		display: inline-block;
	    height: 32px;
	    padding: 0px 11px;
	    margin: 0px 4px;
	    border-radius: 10px;
	    border: 1px solid var(--btn-bd-g);
	    color: var(--btn-bd-g);
	    background: #fff;
	    cursor: pointer;
	    font-size: 14px;
	    float: inline-end; /* 오른쪽 끝으로 배치 */
	    margin-right: 10px;
	}

    .title2-1 {
        color: var(--main-color);
        font-family: "Pretendard Variable", sans-serif;
        font-size: 20px;
        font-weight: 500;
        display: inline-block;
   		width: 200px;
   		padding: 16px 11px 6px 3px;
    }
    
    .contentbox{
    	width: 100%;
   		padding: 6px 18px;
    }
    
    .right-x{
    	float: inline-end;
    	margin: 15px 3px;
    }
    
    .title1-1 {
        color: var(--font-color);
        font-family: "GmarketSans", sans-serif;
        font-size: 34px;
        font-weight: 700;
        padding: 10px 0px 10px;
    }
    
    .fixbox {
	    position: sticky;                /* 이 부분은 고정 */
	    top: 0;                          /* 상단에 고정 */
	    background-color: #FFD9EC;       /* 스크롤 시 배경이 덮이지 않도록 설정 */
    	z-index: 10;
	}
	
	.scrollable-content {
	    max-height: 300px;               /* 스크롤할 영역의 최대 높이 설정 */
	    overflow-y: auto;                /* 이 부분만 스크롤 가능하게 설정 */
	    margin-top: 20px;                /* 위쪽 고정 영역과의 간격 */
	}

    .btn-box {
        background-color: #FFD9EC;
        padding: 10px;
        text-align: center;
    }
    
    .profilebox{
    	border: 1px solid var(--btn-bd-g);
    	border-radius: 7px;
    	height: 55px;
    	width: 98%;
    	display: flex;   
    	align-items: center;
    	justify-content: space-between;
    }
    
    .frofile-text{
    	margin-left: 10px; 
    }
    
	.crew-box {
		padding: 12px 0px 0px 12px;
	    height: 40px;
	    width: 100%; /* 가로 100%로 설정 */
	    display: flex;
	    align-items: center;
	    justify-content: space-between; /* 버튼은 왼쪽, 하트는 오른쪽 끝에 위치 */
	}
	
	.btn01-l2 {
	    margin: 0 auto; /* 버튼을 중앙에 배치 */
	    padding: 10px 20px;
	    cursor: pointer;
	    
	    display: inline-block;
        padding: 12px 30px 30px;
        height: 48px;
        border: 1px solid var(--main-color);
        border-radius: 10px;
        background: var(--main-color);
        color: #fff;
        cursor: pointer;
        justify-content: center;
        
	}
 
 
  
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	<div class="layoutbox"></div>
	
	<div class="innerr">
		
		<div class="one">
			<div id="imgbox">
				<img src=""/>
			</div>
			
			<button class="btn03-s1">수정하기</button>
			<button class="btn03-s1">크루삭제</button>
			
			<div class="title2-1">크루소개 </div>
			
			<div class="contentbox">
				<p>크루소개 내용 들어가는 위치</p>
				<p>1</p>
				<p>2</p>
				<p>3</p>
				<p>4</p>
				<p>5</p>
				<p>6</p>
				<p>7</p>
				<p>8</p>
				<p>9</p>
				<p>10</p>
				<p>11</p>
				<p>12</p>
				<p>13</p>
				<p>14</p>
				<p>15</p>
				<p>16</p>
				<p>17</p>
				<p>18</p>
				<p>19</p>
				<p>20</p>
			</div>
			
			<div class="title2-1">안내사항</div>
			
			<div class="contentbox">
				<p>[이미지] 주소</p>
				<p>[이미지] 000 명</p>
				<p>[이미지] 매주 x</p>
				<p>[이미지] xx 분 / xx km</p>
			</div>
			
			<div class="title2-1">크루 공지사항</div>
			<span class="right-x">[->이미지] 바로가기(링크)</span>
			<div class="contentbox">
				[이미지] 최근 공지사항 yyyy.mm.dd
			</div>
			
			<div class="title2-1">크루 채팅방</div>
			<span class="right-x">[->이미지] 바로가기(링크)</span>
			<div class="contentbox">
				<span>[이미지] 마지막 대화 n 분 전</span>
				
			</div>
		</div>
		
		<div class="two">
			<div class="fixbox">
				<div>
					[이미지] shortsido + sigungu
				</div>
				
				<div class="title1-1">크루 이름</div>
				
				<div class="profilebox">
					<span class="frofile-text">[프로필] 닉네임 / 성별 / 크루장</span>
					<button class="btn03-s2">크루관리</button>
				</div>
			</div>
			
		    <div class="scrollable-content">
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		        <p>크루원 정보 들어가는 곳</p>
		    </div>
		    
		    <div class="btn-box">
		    
		    	<div class="crew-box">
			    	<button class="btn01-l2">러닝크루 신청하기</button>
			    	<div>❤</div>
		    	</div>
		    </div>

		</div>
	
	</div>
	
	<div class="layoutbox"></div>
	
	<jsp:include page="../footer.jsp"/>
</body>
<script>

</script>
</html>