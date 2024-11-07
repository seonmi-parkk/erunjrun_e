<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
   /* 전체 페이지 레이아웃 */
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
	    padding: 20px 100px 20px 40px;
	    overflow: auto;
	}
	#content{
    	width: 750px; /* 너비를 250픽셀로 설정 */
        height: 350px;
        resize: vertical; /* 높이를 50픽셀로 설정 */
        font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
        padding: 10px; /* 내부 여백을 10픽셀로 설정 */
    
    }
	.btn-area {
		text-align: left;
	}
	.btn02-l,.btn03-l{
		margin-top: 10px;
		margin-bottom: 10px;
	}
   
</style>
</head>
<body>
   <!-- 헤더 -->
   <jsp:include page="../header.jsp"/> 
   
   <!-- inner 클래스 하위에 모두 요소들을 넣어서 만들어주십시오. -->
   <div class="content-wrapper">
      <aside class="fixed-left">
            <div class="image">
                <img class="profile-img" src="/resources/img/common/admin_profile.png" alt="관리자 프로필 이미지"/>
            </div>
           <p class="title2" id="admin_name">관리자</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminMember'">회원정보</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminReport'">신고</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminAsk'">문의하기</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminTag'">태그</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminIconListView'">아이콘</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminPopup'">팝업</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminCode'">구분코드</p>
            <p class="title3" style="cursor: pointer;" onclick="location.href='/adminJoin'">회원가입</p>
        </aside>
   
       <main class="main-content">
      <p class="title1" >신고</p>
      
      <div class="btn-area">
      
	      <div class="btn02-l btn-category"  data-category="all">전체</div>
	      <div class="btn03-l btn-category"  data-category="게시글 신고">게시글</div>
	      <div class="btn03-l btn-category"  data-category="댓글 신고">댓글</div>
      </div>
       
          
       <table>
         <thead>
         <colgroup>
             <col width="20%"/>
             <col width="20%"/>
             <col width="20%"/>
             <col width="20%"/>
             <col width="20%"/>
          </colgroup>
         
         <tr>
            <th>카테고리</th>
            <th>작성자</th>
            <th>처리자</th>
            <th>
            <select>
               <option value="">전체</option>
               <option value="D100">처리전</option>
               <option value="D101">미확인</option>
               <option value="D102">처리중</option>
               <option value="D103">처리완료</option>
            </select>
            </th>
            <th>작성일자</th>
         </tr>
      
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
var currentCategory = 'all'; // 기본 카테고리 값
var currentStatus = 'all';   // 기본 상태 값
var show = 1;                // 기본 페이지 번호
var paginationInitialized = false;  // 페이지네이션 초기화 여부 확인 변수

// 카테고리 버튼 클릭 시 이벤트 처리
$('.btn-category').on('click', function () {
    // 모든 버튼에서 기존 스타일 제거하고 클릭한 버튼에 스타일 추가
    $('.btn-category').removeClass('btn02-l').addClass('btn03-l');
    $(this).removeClass('btn03-l').addClass('btn02-l');

    // 클릭한 버튼의 카테고리 값 가져오기
    currentCategory = $(this).data('category');
    show = 1; // 페이지를 항상 첫 페이지로 초기화

    // 페이지네이션 초기화
    if (paginationInitialized) {
        $('#pagination').twbsPagination('destroy');
    }
    paginationInitialized = false; // 페이지네이션 초기화 상태로 설정

    // 현재 상태 값을 가져와서 페이지 호출
    const selectedStatus = $('select').val();
    pageCall(show, currentCategory, selectedStatus); // 데이터 호출 및 페이지네이션 생성
});

// 상태 옵션 선택 시 이벤트 처리
$('select').on('change', function () {
    currentStatus = $(this).val() || 'all'; // 선택된 상태 값이 없을 때 기본값 'all' 사용
    show = 1; // 페이지를 첫 페이지로 초기화

    // 페이지네이션 초기화
    if (paginationInitialized) {
        $('#pagination').twbsPagination('destroy');
    }
    paginationInitialized = false; // 페이지네이션 초기화 상태로 설정

    // 페이지 호출
    pageCall(show, currentCategory, currentStatus);
});

// 페이지 호출 함수 수정
function pageCall(page, category, status) {
    const pageSize = 15;

    // 필터링 조건을 null로 설정하여 불필요한 "all" 값을 처리
    const filterCategory = category !== 'all' && category !== '' ? category : null;
    const filterStatus = status !== 'all' && status !== '' ? status : null;

    $.ajax({
        type: 'GET',
        url: 'adminReportList',
        data: {
            page: page,
            cnt: pageSize,
            category: filterCategory,
            status: filterStatus
        },
        dataType: 'JSON',
        success: function (data) {
            console.log(data);
            drawList(data.list);

            // 페이지네이션 초기화 및 재설정
            if (!paginationInitialized && data.totalPages > 0) { // 페이지네이션이 아직 초기화되지 않았을 때만 생성
                $('#pagination').twbsPagination({
                    totalPages: data.totalPages,
                    visiblePages: 10,
                    startPage: page,
                    initiateStartPageClick: false, // 페이지네이션 초기 클릭 방지
                    onPageClick: function (evt, page) {
                        // 페이지 변경 이벤트에서 현재 페이지 호출
                        show = page; // 현재 페이지 업데이트
                        pageCall(page, currentCategory, currentStatus);
                    }
                });
                paginationInitialized = true;
            }
        },
        error: function (e) {
            console.log(e);
        }
    });
}

// 페이지 로딩 시 호출
$(document).ready(function () {
    const selectedStatus = $('select').val(); // 페이지 로딩 시 기본 상태 값 가져오기
    pageCall(show, currentCategory, selectedStatus);
});

// 리스트를 화면에 그리는 함수
function drawList(list) {
    var content = '';
    for (var view of list) {
        content += '<tr>';
        content += '<td>' + view.category + '</td>';
        content += '<td><a href="/adminReportDetail/' + view.report_idx + ',' + view.code_name + '">' + view.unlike_id + '<a/></td>';
        var admin_name = view.name ? view.name : '관리자';
        content += '<td>' + admin_name + '</td>';

        var processValue = view.process ? view.process : '미확인';
        var colorStyle = ''; // 색상 스타일을 담을 변수

        // 상태에 따른 색상 스타일 설정
        if (processValue == '처리완료') {
            colorStyle = 'color: green;'; // 초록색
        } else if (processValue == '처리중') {
            colorStyle = 'color: black;'; // 검은색
        } else if (processValue == '미확인') {
            colorStyle = 'color: red;'; // 빨간색
        } else if (processValue == '처리전') {
            colorStyle = 'color: gray;'; // 회색
        }

        // 상태에 따른 색상을 갖은 텍스트 추가
        content += '<td style="' + colorStyle + '">' + processValue + '</td>';
        content += '<td>' + view.create_date + '</td>';
        content += '</tr>';
    }
    $('#list').html(content);
}

</script>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>
</html>
