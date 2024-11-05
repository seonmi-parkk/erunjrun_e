<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	.input-container {
    display: flex;        /* Flexbox 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 20px;
    margin-top: 20px;
	}
	#searchForm{
	margin-top: 20px; 
	margin-bottom: 10px; 
	}
	
	#text{
   
    margin-right: 15px
	}
	body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    margin: 0;
	}
	/* 콘텐츠와 사이드바 감싸는 래퍼 */
	.content-wrapper {
	    display: flex;
	    width: 100%;
	    margin: 80px 10px; /* 헤더 높이만큼 여백 */
	    flex-grow: 1; /* 남은 공간 채우기 */
	}

	/* 사이드바 스타일 */
	.fixed-left {
	    width: 300px;
	    border-right: 1px solid #ccc;
	    padding: 20px;
	    position: sticky;
	    top: 80px; /* 헤더 아래에 고정 */
	    height: calc(100vh - 80px); /* 화면 높이에 맞추기 */
	    overflow-y: auto;
	}
	.fixed-left p{
	    margin: 15px 0;
	    line-height: 1.5;
	    font-size: 20px;
	}
	
	#admin_name{
	font-weight: 800;
	font-size: 23px;
	}
	
	.image img {
	    width: 35%;  /* 또는 원하는 픽셀 값 */
	    height: auto;
	    margin-bottom: 20px; /* 비율을 유지 */
		}
	/* 메인 콘텐츠 */
	.main-content {
	    flex: 1; /* 남은 공간 채우기 */
	    padding: 20px;
	    overflow: auto;
	}
	#content{
    	width: 750px; /* 너비를 250픽셀로 설정 */
        height: 350px;
        resize: vertical; /* 높이를 50픽셀로 설정 */
        font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
        padding: 10px; /* 내부 여백을 10픽셀로 설정 */
    
    }
	
	.btn01-l{
	margin-top: 10px;
	margin-left: 1450px;
	margin-bottom: 10px;
	}
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../header.jsp"/> 
	
	<!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
	
		<div class="content-wrapper">
		<aside class="fixed-left">
            <div class="image">
                <img class="profile-img" src="resources/img/common/admin_profile.png" alt="관리자 프로필 이미지"/>
            </div>
            <p class="title2" id="admin_name">관리자</p>
            <p class="title3" onclick="location.href='adminMember'">회원정보</p>
            <p class="title3" onclick="location.href='adminReport'">신고</p>
            <p class="title3" onclick="location.href='adminAsk'">문의하기</p>
            <p class="title3" onclick="location.href='adminTag'">태그</p>
            <p class="title3" onclick="location.href='adminIconListView'">아이콘</p>
            <p class="title3" onclick="location.href='adminPopup'">팝업</p>
            <p class="title3" onclick="location.href='adminCode'">구분코드</p>
            <p class="title3" onclick="location.href='adminJoin'">회원가입</p>
        </aside>
        
        <main class="main-content">
		<p class="title1" >태그</p>
	    <div class="btn01-l" onclick="location.href='adminTagWrite'" >등록</div>
	    
		 <table>
			<colgroup>
		 		<col width="40%"/>
		 		<col width="30%"/>
		 		<col width="30%"/> 		
		 	</colgroup>
		<thead>
			<tr>
				<th>태그 이름</th>
				<th>사용여부</th>
				<th>수정</th>
			</tr>
		</thead>
		 	<tbody id="list">
		 		

		 	</tbody>
		 	<tr>
	         <th colspan="6">
	            <div class="container">
	             <nav aria-label="Page navigation">
	              <ul class="pagination" id="pagination"></ul>
	             </nav>
	            </div>
	         </th>
	      </tr>
   </table>
        </main>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="../footer.jsp" />
</body>



<script>

	var show = 1;
	pageCall(show);

	function pageCall(page) {
		
		$.ajax({
			type:'GET',
			url:'adminTagList',
			data:{
				'page':page,
				'cnt':15
			
			},
			datatype:'JSON',
			success:function(data){
				console.log(data);
				drawList(data.list)
				$('#pagination').twbsPagination({ // 페이징 객체 만들기
				startPage:1, 
           		totalPages:data.totalPages, 
           		visiblePages:10,
           
           		onPageClick:function(evt,page){
           			console.log('evt',evt); 
           			console.log('page',page); 
           			pageCall(page);
           		}
				});
			},
			error:function(e){
				console.log(e);
			}
		});
	}

	function drawList(list) {
		var content ='';
		 for (var view of list) {
			content +='<tr>';
            content += '<td>'+view.tag_name+'</td>';
            if (view.use_yn == 'Y') {
                content += '<td style="color: green;">사용중</td>';
            } else {
            	content += '<td style="color: red;">미사용</td>';
            }
			content +='<td><a  href="adminTagUpdate?tag_idx='+view.tag_idx+'"style="color: orange;">수정</a></td>';
			content +='</tr>';
		  }
	      $('#list').html(content);
	   }
 

    
</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>