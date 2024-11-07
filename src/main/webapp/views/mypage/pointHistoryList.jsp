<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>이런저런</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/common.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"
	type="text/javascript"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f0f0f0; /* 회색 배경 */
}

aside {
	width: 250px; /* 사이드바 너비 조정 */
	padding: 20px;
	background: #fff; /* 필요에 따라 배경색 추가 */
	border-top-left-radius: 8px; /* 왼쪽 위 모서리 둥글게 */
	border-bottom-left-radius: 8px; /* 왼쪽 아래 모서리 둥글게 */
}

.main-container {
	display: flex; /* 사이드바와 컨테이너를 가로로 배치 */
	width: 80%; /* 전체 너비의 80%로 조정 */
	max-width: 1100px; /* 최대 너비 설정 */
	margin: 120px auto; /* 상하 여백 추가, 중앙 정렬 */
	
}

.container {
	flex: 1; /* 남은 공간을 차지 */
	padding: 20px; /* 여백 추가 */
	background: white; /* 흰색 배경 */
	border-top-right-radius: 8px; /* 오른쪽 위 모서리 둥글게 */
	border-bottom-right-radius: 8px; /* 오른쪽 아래 모서리 둥글게 */
	
}

.image {
	text-align: center; /* 이미지 중앙 정렬 */
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
	font-weight: bold; /* 사용자 이름을 강조 */
	font-size: 20px; /* 글자 크기 조정 */
	color: #333; /* 글자 색상 */
	margin-left: 25px; /* 기존과 동일한 여백 */
	margin-top: 10px;
}

table {
	width: 100%; /* 테이블 너비를 100%로 설정 */
	border-collapse: collapse; /* 테두리 중첩을 제거 */
	border-spacing: 0; /* 셀 간격을 0으로 설정 */
}

th, td {
	padding: 10px; /* 패딩 추가 */
	border: none; /* 테두리 제거 */
	text-align: left; /* 텍스트 왼쪽 정렬 */
}

th {
	background-color: #f8f8f8; /* 헤더 배경색 */
}

tr {
	border-bottom: 1px solid #f8f8f8; /* 하단 테두리 추가 */
}

tbody {
	background-color: #ffffff; /* 하얀색 배경 */
}

tbody tr {
	border-bottom: 1px solid #ccc; /* 검은색 하단 선 추가 */
}


tfoot tr {
    border-bottom: none; /* tfoot의 하단 선 없애기 */
}

.pagination-container {
	background-color: #ffffff; /* 페이징 부분의 배경색을 하얀색으로 설정 */
	padding: 10px 0; /* 위아래 패딩 추가 */
}

.title1 {
	font-size: 24px; /* 제목 크기 */
	margin-bottom: 20px; /* 아래 여백 */
}

.profile-img1 {
	max-width: 100px; /* 원하는 최대 너비 */
	max-height: 100px; /* 원하는 최대 높이 */
	border-radius: 4px; /* 모서리 둥글게 */
	margin-left: -60px;
}

.icon-image1 {
	margin-top: -123px;
	margin-left: 2px;
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
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="main-container">
		<aside>
			<div class="image">
				<!-- 프로필 이미지 -->
				<c:choose>
					<c:when test="${not empty profile.image}">
						<img class="profile-img1" src="/photo/${profile.image}" alt="" />
					</c:when>
					<c:otherwise>
						<img class="profile-img1" src="resources/img/common/profile.png" alt="" />
					</c:otherwise>
				</c:choose>
			</div>
			<div class="icon">
				<!-- 아이콘 이미지 -->
				<c:choose>
					<c:when test="${not empty member.icon_image}">
						<img class="icon-image1" src="/resources/img/icon/${member.icon_image}" alt="" />
					</c:when>
					<c:otherwise>
						<img class="icon-image1" src="resources/img/icon/default-icon.png" alt="" />
					</c:otherwise>
				</c:choose>
			</div>
			<p class="username" id="name">${member.id}</p>
			<p class="title3 ${pageName == 'profileDetail' ? 'active' : ''}"
				onclick="location.href='profileDetail'">회원정보</p>
			<p
				class="title3 ${pageName == 'createExerciseProfile' || pageName == 'ExerciseProfile' ? 'active' : ''}"
				onclick="location.href='createExerciseProfile'">운동프로필</p>
			<p
				class="title3 ${pageName == 'pointHistoryListView' ? 'active' : ''}"
				onclick="location.href='pointHistoryListView'">포인트 내역</p>
			<p class="title3 ${pageName == 'memberCrewListView' ? 'active' : ''}"
				onclick="location.href='memberCrewListView'">크루 리스트</p>
			<p class="title3 ${pageName == 'myMateListView' ? 'active' : ''}"
				onclick="location.href='myMateListView'">내 운동 메이트</p>
			<p class="title3 ${pageName == 'likedMemberListView' ? 'active' : ''}"
				onclick="location.href='likedMemberListView'">내 관심/차단 회원</p>
			<p class="title3 ${pageName == 'messageListView' ? 'active' : ''}"
				onclick="location.href='messageListView'">쪽지</p>
			<p class="title3 ${pageName == 'myIconListView' ? 'active' : ''}"
				onclick="location.href='myIconListView'">아이콘</p>
			<p class="title3 ${pageName == 'myBoardListView' ? 'active' : ''}"
				onclick="location.href='myBoardListView'">내 게시글/댓글</p>
			<p class="title3 ${pageName == 'likedBoardListView' ? 'active' : ''}"
				onclick="location.href='likedBoardListView'">좋아요 게시글</p>
		</aside>
		<div class="divider"></div>
		<div class="container">
			<h3>포인트 내역</h3>

			<table>
				<thead>
					<tr>
						<th>구분</th>
						<th>내용</th>
						<th>적립일</th>
						<th>적립 포인트</th>
					</tr>
				</thead>
				<tbody id="list">
					<!-- 리스트가 여기에 동적으로 추가됩니다. -->
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="pagination-container">
							<div class="container">
								<nav aria-label="Page navigation">
									<ul class="pagination" id="pagination"></ul>
								</nav>
							</div>
						</td>
					</tr>
				</tfoot>
			</table>

			<!-- 로그인 상태 확인 메시지 -->
			<c:if test="${not empty msg}">
				<div class="alert alert-warning">${msg}</div>
			</c:if>
		</div>
	</div>
</body>
<jsp:include page="../footer.jsp" />

<script>
	var show = 1;
	const itemsPerPage = 15; // 페이지당 항목 수 고정

	// 초기 리스트 불러오기
	pageCall(show);

	// 페이지 호출 함수
	function pageCall(page) {
		$.ajax({
			type : 'GET',
			url : 'pointHistoryList.ajax',
			data : {
				'page' : page,
				'cnt' : itemsPerPage
			// 고정된 값 사용
			},
			dataType : 'JSON',
			success : function(data) {
				console.log("AJAX call successful: ", data);

				if (data.error) {
					alert(data.error); // 로그인 필요 메시지 표시
					window.location.href = 'member/login'; // 로그인 페이지로 리다이렉트
				} else {
					drawList(data.list);
					$('#pagination').twbsPagination({ // 페이징 객체 만들기
						startPage : 1,
						totalPages : data.totalpages,
						visiblePages : 5,
						onPageClick : function(evt, page) {
							pageCall(page);
						}
					});
				}
			},
			error : function(e) {
				console.error("AJAX call failed: ", e);
			}
		});
	}

	// 리스트 그리기 함수
	// 리스트 그리기 함수
function drawList(list) {
    var content = '';
    
    // Check if the list is empty
    if (list.length === 0) {
        content = '<tr><td colspan="4" style="text-align: center;">포인트 내역이 없습니다.</td></tr>';
    } else {
        list.forEach(function(view) {
            if (view) {
                // 타임스탬프를 Date 객체로 변환 후 포맷팅
                var date = new Date(view.create_date);
                var formattedDate = date.toLocaleString('ko-KR', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: false
                });

                // 구분 설정
                var category = view.point >= 0 ? '적립' : '소모';
                // 내용 설정
                var contentDescription = '';
                switch (view.code_name) {
                    case 'P100':
                        contentDescription = '최초 프로필 등록 + 10';
                        break;
                    case 'P101':
                        contentDescription = '게시판 작성 + 5';
                        break;
                    case 'P102':
                        contentDescription = '댓글 작성 + 2';
                        break;
                    case 'P103':
                        contentDescription = '좋아요 +2 ';
                        break;
                    case 'P104':
                        contentDescription = '아이콘 구매 - 100';
                        break;
                    default:
                        contentDescription = view.code_name; // 기본적으로 코드 그대로 출력
                }

                content += '<tr>';
                content += '<td>' + category + '</td>'; // 구분 추가
                content += '<td>' + contentDescription + '</td>'; // 내용 추가
                content += '<td>' + formattedDate + '</td>'; // 포맷된 날짜 사용
                content += '<td>' + view.point + '</td>'; // 포인트 추가
                content += '</tr>';
            } else {
                console.warn('View is null or undefined', view);
            }
        });
    }
    
    $('#list').html(content);
}
</script>
</html>
