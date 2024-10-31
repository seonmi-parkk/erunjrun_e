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
            background-color: #f9f9f9;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h3 {
            text-align: center;
            margin-bottom: 20px;
            color: #ff7f50;
        }
        .friend-requests {
            margin-top: 20px;
            max-height: 300px;
            overflow-y: auto;
        }
        .card {
            display: flex;
            align-items: center;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fafafa;
            transition: background-color 0.3s;
            cursor: pointer;
        }
        .card:hover {
            background-color: #f1f1f1;
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
            flex-grow: 1;
        }
        .action-buttons {
            margin-left: auto;
        }
        .action-buttons button {
            margin-left: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            background-color: #ff7f50;
            color: white;
            cursor: pointer;
        }
        .action-buttons button:hover {
            background-color: #e76f51;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>친구 요청</h3>
        <div class="friend-requests">
            <!-- 친구 요청 카드가 여기에 동적으로 추가됩니다 -->
        </div>
    </div>

    <!-- 모달 구조 -->
    <div id="profilePopup" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="PopupBody">
                <!-- 프로필 내용이 여기에 동적으로 추가됩니다 -->
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // 페이지 로드 시 친구 요청 데이터를 불러오는 AJAX 호출
            $.ajax({
                type: 'GET',
                url: '/friendRequests.ajax',
                data: { page: 1, cnt: 8 },
                dataType: 'json',
                success: function(data) {
                    console.log(data);
                    if (data.error) {
                        alert(data.error);
                    } else {
                        $.each(data.list, function(index, friend) {
                            var imageSrc = (friend.image && friend.image.trim()) ? '/photo/' + friend.image : 'resources/img/common/profile.png';

                            var friendCard = '<div class="card" data-id="' + friend.unlike_id + '">' +
                                             '<img class="friend-image" src="' + imageSrc + '" alt="친구 이미지" />' +
                                             '<p class="friend-name user" style="cursor:pointer;">' + (friend.unlike_id ? friend.unlike_id : '이름 없음') + '</p>' +
                                             '<div class="action-buttons">' +
                                             '<button class="accept-btn">수락</button>' +
                                             '<button class="reject-btn">거절</button>' +
                                             '</div>' +
                                             '</div>';

                            $('.friend-requests').append(friendCard);
                        });
                        console.log("총 친구 요청 수:", data.totalCount);
                    }
                },
                error: function(e) {
                    console.error('친구 요청을 불러오는 중 오류 발생:', e);
                }
            });

            // 수락 및 거절 버튼 이벤트 처리
            $(document).on('click', '.accept-btn', function() {
                var unlikeId = $(this).closest('.card').data('id');
                handleFriendRequest(unlikeId, 'accept');
            });

            $(document).on('click', '.reject-btn', function() {
                var unlikeId = $(this).closest('.card').data('id');
                handleFriendRequest(unlikeId, 'reject');
            });

            // 친구 이름 클릭 시 프로필 열기
            $(document).on('click', '.friend-name', function() {
                var toUserId = $(this).closest('.card').data('id');
                openProfile(toUserId);
            });

            // 프로필 레이어 팝업 열기
            function openProfile(toUserId) {
                var modal = document.getElementById("profilePopup");
                var PopupBody = document.getElementById("PopupBody");

                $.ajax({
                    type: 'GET',
                    url: '/mypage/' + toUserId,
                    success: function(response) {
                        PopupBody.innerHTML = response; // 응답을 모달에 넣기
                        modal.style.display = "block"; // 모달 열기
                    },
                    error: function(e) {
                        console.error('프로필을 불러오는 중 오류 발생:', e);
                    }
                });
            }

            // 팝업 닫기
            $(document).on('click', '.close', function() {
                document.getElementById("profilePopup").style.display = "none";
            });

            // 모달 외부 클릭 시 닫기
            $(window).on('click', function(event) {
                var modal = document.getElementById("profilePopup");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            });

            // 수락/거절 처리 함수
            function handleFriendRequest(unlikeId, action) {
                $.ajax({
                    type: 'POST',
                    url: '/handleFriendRequest.ajax',
                    data: { unlikeId: unlikeId, action: action },
                    success: function(response) {
                        if (response.success) {
                            alert(action === 'accept' ? '친구 요청을 수락했습니다.' : '친구 요청을 거절했습니다.');
                            $('.card[data-id="' + unlikeId + '"]').remove(); // 카드 제거
                        } else {
                            alert('처리 중 오류가 발생했습니다.');
                        }
                    },
                    error: function(e) {
                        console.error('오류 발생:', e);
                    }
                });
            }
        });
    </script>
</body>
</html>
