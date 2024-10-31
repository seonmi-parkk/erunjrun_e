<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>친구 요청</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9; /* 연한 배경색 */
        }

        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        }

        h3 {
            text-align: center;
            margin-bottom: 20px;
            color: #ff7f50; /* 주황색 */
        }

        .friend-requests {
            margin-top: 20px;
            max-height: 300px; /* 최대 높이 설정 */
            overflow-y: auto; /* 스크롤 가능하게 설정 */
        }

        .mate-card {
            display: flex;
            align-items: center;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fafafa;
            transition: background-color 0.3s; /* 배경색 변화 효과 */
        }

        .mate-card:hover {
            background-color: #f1f1f1; /* 호버 시 배경색 변화 */
        }

        .friend-image {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 15px;
        }

        .friend-name {
            font-size: 16px;
            color: #555;
            flex-grow: 1; /* 이름 영역을 확장 */
        }

        .action-buttons {
            margin-left: auto; /* 버튼을 오른쪽 끝으로 */
        }

        .action-buttons button {
            margin-left: 5px; /* 버튼 간격 */
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            background-color: #ff7f50; /* 주황색 배경 */
            color: white;
            cursor: pointer;
        }

        .action-buttons button:hover {
            background-color: #e76f51; /* 호버 시 색상 변화 */
        }
    </style>
</head>
<body>
<div class="container">
    <h3>신청한 운동 메이트</h3>
    <div class="mate-list">
        <!-- 목록이 여기에 동적으로 추가됩니다 -->
    </div>
</div>

<script>
$(document).ready(function() {
    // AJAX 호출로 신청한 운동 메이트 목록 가져오기
    $.ajax({
        type: 'GET',
        url: '/appliedMates.ajax', // 신청한 메이트 목록 URL
        data: { page: 1, cnt: 8 }, // 페이지와 항목 수
        dataType: 'json',
        success: function(data) {
            $.each(data.list, function(index, mate) {
                var mateCard = '<div class="mate-card" data-id="' + mate.id + '">' +
                               '<p>' + mate.id + ' (신청일: ' + mate.create_date + ')</p>' +
                               '<div class="action-buttons">' +
                               '<button class="cancel-btn">신청 취소</button>' +
                               '</div></div>';
                $('.mate-list').append(mateCard);
            });
        },
        error: function(e) {
            console.error('신청한 메이트 목록을 불러오는 중 오류 발생:', e);
        }
    });

    // 신청 취소 버튼 클릭 이벤트
    $(document).on('click', '.cancel-btn', function() {
        var unlikeId = $(this).closest('.mate-card').data('id');
        $.ajax({
            type: 'POST',
            url: '/cancelMateApplication.ajax', // 신청 취소 요청 URL
            data: { unlikeId: unlikeId },
            success: function(response) {
                if (response.success) {
                    alert('신청이 취소되었습니다.');
                    $('.mate-card[data-id="' + unlikeId + '"]').remove(); // 카드 제거

                } else {
                    alert('취소 중 오류가 발생했습니다.');
                }
            },
            error: function(e) {
                console.error('오류 발생:', e);
            }
        });
    });
});
</script>
</body>
</html>
