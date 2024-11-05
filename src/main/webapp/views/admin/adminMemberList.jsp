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
   body {
       display: flex;
       flex-direction: column;
       min-height: 100vh;
       margin: 0;
   }
   
   /* 헤더 스타일 */
   
   
   /* 콘텐츠와 사이드바 감싸는 래퍼 */
   .content-wrapper {
       display: flex;
       width: 90%;
       margin-top: 80px; /* 헤더 높이만큼 여백 */
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
   

   .btn02-l{
   margin-top: 0px;
   margin-bottom: 50px;
   }

</style>
</head>
<body>
    <!-- 헤더 -->
    <jsp:include page="../header.jsp"/>

    <!-- 콘텐츠 영역 (사이드바와 메인 콘텐츠를 감싸는 래퍼) -->
    <div class="content-wrapper">
        <!-- 사이드바 -->
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

        <!-- 메인 콘텐츠 -->
        <main class="main-content">
            <p class="title1">회원정보</p>
            <div class="btn02-l" onclick="location.href='/adminMember'">일반회원</div>
            <div class="btn03-l" onclick="location.href='/admin'">관리자</div>

            <form id="searchForm" onsubmit="return false;">
                <select id="searchOption">
                    <option value="id">아이디</option>
                    <option value="nickname">닉네임</option>
                    <option value="email">이메일</option>
                </select>
                <input class="input-txt-l" type="text" id="searchKeyword" placeholder="검색어를 입력하세요"/>
                <input class="btn-sch" type="button" onclick="pageCall(1)" value="검색"/>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>아이디</th>
                        <th>닉네임</th>
                        <th>이메일</th>
                        <th>권한</th>
                        <th onclick="sortby('report_count')"  style="cursor: pointer;">신고누적수</th>
                        <th onclick="sortby('join_date')"  style="cursor: pointer;">가입일시</th>
                    </tr>
                </thead>
                <tbody id="list"></tbody>
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
    <jsp:include page="../footer.jsp"/>
</body>
<script>
    var show = 1;
    pageCall(show);

    var currentSortField = '';
    var currentSortOrder = 'ASC';

    function sortby(field) {
        // 같은 필드를 클릭하면 정렬 순서를 반대로 변경
        if (currentSortField == field) {
            currentSortOrder = currentSortOrder == 'ASC' ? 'DESC' : 'ASC';
        } else {
            // 새로운 필드를 클릭하면 정렬 순서를 ASC로 초기화
            currentSortField = field;
            currentSortOrder = 'ASC';
        }

        // 정렬된 순서와 필드로 페이지 호출
        pageCall(1, currentSortField, currentSortOrder);
    }

    function pageCall(page, sortField = '', sortOrder = '') {
        var keyword = $('#searchKeyword').val();
        var opt = $('#searchOption').val();

        $.ajax({
            type: 'Get',
            url: 'adminMemberList',
            data: {
                page: page,
                cnt: 15,
                opt: opt,
                keyword: keyword,
                sortField: sortField,
                sortOrder: sortOrder
            },
            datatype: 'JSON',
            success: function (data) {
                console.log(data);
                drawList(data.list);
                $('#pagination').twbsPagination({
                    startPage: page,
                    totalPages: data.totalPages,
                    visiblePages: 10,
                    onPageClick: function (evt, page) {
                        pageCall(page, sortField, sortOrder);
                    }
                });
            },
            error: function (e) {
                console.log(e);
            }
        });
    }


    function drawList(list) {
        var content = '';
        for (var view of list) {
           content += '<tr>';
           content += '<td style="' + (view.report_status == 'Y' ? 'color: blue;' : '') + '">' + view.id + '</td>';
           content += '<td><a href="/adminMemberDetail/' + view.id + '">' + view.nickname + '</a></td>';
           content += '<td>' + view.email + '</td>';
           content += '<td><a href="/memberRight/'+ view.nickname + '" style="color: orange;">권한</a></td>';
           content += '<td>' + view.report_count + '</td>';
           content += '<td>' + view.join_date + '</td>';
           content += '</tr>';

        }
        $('#list').html(content);
    }
    
</script>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/layerPopup.js"></script>
</html>