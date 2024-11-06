<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>내 게시글/댓글</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f0f0f0;
}

aside {
	width: 250px;
	padding: 20px;
	background: #fff;
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
}

.main-container {
	display: flex;
	width: 80%;
	max-width: 1100px;
	margin: 120px auto;
}

.username {
	font-weight: bold; /* 사용자 이름을 강조 */
	font-size: 20px; /* 글자 크기 조정 */
	color: #333; /* 글자 색상 */
	margin-left: 25px; /* 기존과 동일한 여백 */
	margin-top: 10px;
}

.container {
	flex: 1;
	padding: 20px;
	background: white;
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
}

.image {
	text-align: center;
}

.title2 {
	font-weight: bold; /* 제목 강조 */
	font-size: 20px;
	margin-left: -6px;
	text-align: left;
}

.title3 {
	cursor: pointer; /* 클릭 가능 표시 */
	color: black; /* 링크 색상 */
	margin: 10px 24; /* 여백 추가 */
	margin-top: 10px;
	position: relative; /* 상대 위치 설정 */
	top: 30px;
}

.username {
	font-weight: bold;
	font-size: 20px;
	color: #333;
	margin-left: 25px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin: 0;  /* 여백 없애기 */
	
}

th, td {
	padding: 10px;
	border: none;
	text-align: left;
}

th {
	background-color: #f8f8f8;
}

tr {
	border-bottom: 1px solid #f8f8f8;
}

tbody {
	background-color: #ffffff;
}

tbody tr {
	border-bottom: 1px solid #ccc; /* 검은색 하단 선 추가 */
}


tfoot tr {
    border-bottom: none; /* tfoot의 하단 선 없애기 */
}


.pagination-container {
	background-color: #ffffff;
	padding: 10px 0;
}

.title1 {
	font-size: 24px;
	margin-bottom: 20px;
}

.alert {
	margin-top: 20px;
}

.profile-img1 {
	max-width: 100px; /* 원하는 최대 너비 */
	max-height: 100px; /* 원하는 최대 높이 */
	border-radius: 4px; /* 모서리 둥글게 */
	margin-left: -60px;
}

.divider {
	width: 2px; /* 선의 두께 */
	background-color: #ccc; /* 선의 색상 */
	margin: 10px 0; /* 위아래 여백 */
}

h3 {
	text-align: left;
	margin-bottom: 20px;
	color: dark; /* 주황색 */
	font-size: 40px;
}

.title3.active {
    color: #black; /* 활성화된 메뉴 항목의 색상 */
    font-weight: bold; /* 강조 효과 */
    background-color: #f0f0f0; /* 배경 색상 (선택 사항) */
}

.board-options {
	display: flex; /* Flexbox 사용 */
	justify-content: flex-start; /* 왼쪽 정렬 */
	margin-bottom: 50px; /* 카드와의 간격 조정 */
}

.board-options .title3 {
	margin-right: 5px; /* 항목 간 여백 */
	cursor: pointer; /* 클릭 가능 표시 */
	color: black; /* 링크 색상 */
	text-decoration: underline; /* 밑줄 */
	margin-left: 0; /* 왼쪽 여백을 0으로 설정하여 왼쪽으로 이동 */
}

.board-options .title3:hover {
	color: #0056b3; /* 호버 시 색상 변경 */
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="main-container">
		<aside>
			<div class="image">
				<img class="profile-img1" src="resources/img/common/profile.png" alt="프로필 이미지" />
			</div>
			<p class="username" id="name">${member.id}</p>
			<p class="title3 ${pageName == 'profileDetail' ? 'active' : ''}" onclick="location.href='profileDetail'">회원정보</p>
			<p class="title3 ${pageName == 'createExerciseProfile' || pageName == 'ExerciseProfile' ? 'active' : ''}" onclick="location.href='createExerciseProfile'">운동프로필</p>
			<p class="title3 ${pageName == 'pointHistoryListView' ? 'active' : ''}" onclick="location.href='pointHistoryListView'">포인트 내역</p>
			<p class="title3 ${pageName == 'memberCrewListView' ? 'active' : ''}" onclick="location.href='memberCrewListView'">크루 리스트</p>
			<p class="title3 ${pageName == 'myMateListView' ? 'active' : ''}" onclick="location.href='myMateListView'">내 운동 메이트</p>
			<p class="title3 ${pageName == 'likedMemberListView' ? 'active' : ''}" onclick="location.href='likedMemberListView'">내 관심/차단 회원</p>
			<p class="title3 ${pageName == 'messageListView' ? 'active' : ''}" onclick="location.href='messageListView'">쪽지</p>
			<p class="title3 ${pageName == 'myIconListView' ? 'active' : ''}" onclick="location.href='myIconListView'">아이콘</p>
			<p class="title3 ${pageName == 'myBoardListView' ? 'active' : ''}" onclick="location.href='myBoardListView'">내 게시글/댓글</p>
			<p class="title3 ${pageName == 'likedBoardListView' ? 'active' : ''}" onclick="location.href='likedBoardListView'">좋아요 게시글</p>
		</aside>
		<div class="divider"></div>	
		<div class="container">
			<h3>내 게시글/댓글</h3>
			<div class="board-options">
				<p class="title3"
					onclick="location.href='myBoardListView'">(내 게시글)</p>
				<p class="title3 ${pageName == 'myBoardListView' ? 'active' : ''}" onclick="location.href='myCommentListView'">(내 댓글)</p>
				</div>
			<table>
				<thead>
					<tr>
						<th>글번호</th>
						<th>댓글 내용</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody id="list">
					<!-- 리스트가 여기에 동적으로 추가됩니다. -->
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" class="pagination-container">
							<nav aria-label="Page navigation">
								<ul class="pagination" id="pagination"></ul>
							</nav>
						</td>
					</tr>
				</tfoot>
			</table>

			<c:if test="${not empty msg}">
				<div class="alert alert-warning">${msg}</div>
			</c:if>
		</div>
	</div>
</body>
<jsp:include page="../footer.jsp" />

<script>
    var show = 1;
    const itemsPerPage = 15;

    pageCall(show);

    function pageCall(page) {
        $.ajax({
            type: 'GET',
            url: 'myCommentList.ajax',
            data: {
                'page': page,
                'cnt': itemsPerPage
            },
            dataType: 'JSON',
            success: function(data) {
                console.log(data); // 서버에서 받은 데이터 확인
                if (data.error) {
                    alert(data.error);
                    window.location.href = 'member/login';
                } else {
                    drawList(data.list);
                    setupPagination(data.totalpages, page);
                }
            },
            error: function(e) {
                console.error("AJAX call failed: ", e);
            }
        });
    }

    function drawList(list) {
        var content = '';
        if (list.length === 0) {
            // 데이터가 없을 경우 메시지 추가
            content = '<tr><td colspan="3" style="text-align: center;">작성한 댓글이 없습니다.</td></tr>';
        } else {
            list.forEach(function(view) {
                if (view) {
                    content += '<tr>';
                    content += '<td>' + view.comment_idx + '</td>'; // 댓글 번호
                    // 댓글 내용에 링크 추가
                    // 링크에 board_idx와 comment_idx를 포함시켜 해당 게시글로 이동하도록
                    content += '<td><a href="/boardDetail/' + view.code_name + '/' + view.board_idx + '#comment-' + view.comment_idx + '">' + view.content + '</a></td>'; 
                    content += '<td>' + new Date(view.create_date).toLocaleString('ko-KR') + '</td>'; // 작성일
                    content += '</tr>';
                }
            });
        }
        $('#list').html(content);
    }

    function setupPagination(totalPages, currentPage) {
        $('#pagination').twbsPagination({
            startPage: currentPage,
            totalPages: totalPages > 0 ? totalPages : 1, // 항상 1페이지로 설정
            visiblePages: 5,
            onPageClick: function(evt, page) {
                pageCall(page);
            }
        });
    }
</script>
</html>
