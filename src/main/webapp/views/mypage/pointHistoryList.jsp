<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
/* 추가적인 CSS 스타일을 여기에 작성하세요 */
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />

	<p class="title1">--------리스트--------</p>
	<select id="pagePerNum">
		<option value="5">5</option>
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20" selected>20</option>
	</select> 개 씩 보기

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
		<tr>
			<th colspan="4">
				<div class="container">
					<nav aria-label="Page navigation">
						<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
			</th>
		</tr>
	</table>

	<!-- 로그인 상태 확인 메시지 -->
	<c:if test="${not empty msg}">
		<div class="alert alert-warning">${msg}</div>
	</c:if>

	<script>
		var show = 1;

		// 초기 리스트 불러오기
		pageCall(show);

		// 페이지당 항목 수 변경 시
		$('#pagePerNum').change(function() {
			$('#pagination').twbsPagination('destroy'); // 기존 페이징 파괴
			pageCall(show);
		});

		// 페이지 호출 함수
		function pageCall(page) {
			$.ajax({
				type : 'GET',
				url : 'pointHistoryList.ajax',
				data : {
					'page' : page,
					'cnt' : $('#pagePerNum').val()
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
								console.log('evt', evt);
								console.log('page', page);
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
		function drawList(list) {
			var content = '';
			list.forEach(function(view) {
				if (view) {
					// 타임스탬프를 Date 객체로 변환 후 포맷팅
					var date = new Date(view.create_date);
					var formattedDate = date.toLocaleString('ko-KR', {
						year : 'numeric',
						month : '2-digit',
						day : '2-digit',
						hour : '2-digit',
						minute : '2-digit',
						second : '2-digit',
						hour12 : false
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
			$('#list').html(content);
		}
	</script>
</body>
</html>
