<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이콘 선택</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
        }
        .icon-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .icon-card {
            display: flex;
            align-items: center;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fafafa;
            transition: background-color 0.3s;
            position: relative;
        }
        .icon-card:hover {
            background-color: #f1f1f1;
        }
        .icon-card img {
            width: 50px;
            height: 50px;
            margin-right: 15px;
        }
        .icon-name {
            font-size: 16px;
            color: #555;
            flex-grow: 1;
        }
        .apply-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #ff7f50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<h3>구매한 아이콘 리스트</h3>
<div class="icon-list">
    <!-- 아이콘 카드가 여기에 동적으로 추가됩니다 -->
</div>
<button class="apply-btn">적용</button>

<script>
$(document).ready(function() {
    // 아이콘 리스트 가져오기 (예시 데이터)
    const icons = [
        { id: 1, src: 'icon1.png', name: '아이콘 1' },
        { id: 2, src: 'icon2.png', name: '아이콘 2' },
        { id: 3, src: 'icon3.png', name: '아이콘 3' },
    ];

    // 아이콘 카드 생성
    $.each(icons, function(index, icon) {
        var iconCard = '<div class="icon-card" data-id="' + icon.id + '">' +
                       '<img src="' + icon.src + '" alt="' + icon.name + '">' +
                       '<p class="icon-name">' + icon.name + '</p>' +
                       '<input type="checkbox" value="' + icon.id + '">' +
                       '</div>';
        $('.icon-list').append(iconCard);
    });

    // 적용 버튼 클릭 이벤트
    $('.apply-btn').click(function() {
        var selectedIcons = [];
        $('.icon-card input:checked').each(function() {
            selectedIcons.push($(this).val());
        });
        alert('선택한 아이콘 ID: ' + selectedIcons.join(', '));
        // 여기에 서버에 선택한 아이콘을 적용하는 AJAX 요청을 추가할 수 있습니다.
    });
});

$.ajax({
    type: 'POST',
    url: '/applyIcon.ajax', // 아이콘 적용 요청 URL
    data: { iconIds: selectedIcons }, // 선택한 아이콘 ID 배열 전송
    success: function(response) {
        alert('아이콘이 적용되었습니다.');
        // 프로필 이미지를 업데이트하는 로직 추가 (예: 페이지 새로 고침)
    },
    error: function(e) {
        console.error('아이콘 적용 중 오류 발생:', e);
    }
});
});
</script>
</body>
</html>
