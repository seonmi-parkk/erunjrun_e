<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 회원가입</title>
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
            background-color: #ffffff;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
        }
        h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #ff7f50; /* 주황색으로 변경 */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #ff6347; /* 버튼 hover 색상 */
        }
        .result {
            margin-top: 5px;
            font-weight: bold;
            display: inline-block; /* 수평 정렬 */
            margin-left: 10px; /* 버튼과 결과 사이의 간격 */
        }
        
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
	    width: 100%;
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
    </style>
</head>
<body>
	<!-- 헤더 -->
    

    <!-- 콘텐츠 영역 (사이드바와 메인 콘텐츠를 감싸는 래퍼) -->
    
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
    <div class="container">
        <h3>관리자 회원가입</h3>
        <form id="adminJoinForm" action="adminJoin" method="post">
            <div class="form-group">
                <label for="id">아이디 *</label>
                <input type="text" name="id" required placeholder="예시) admin123" />
                <button type="button" id="idCheck">중복확인</button>
                <span id="idResult" class="result"></span>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호 *</label>
                <input type="password" name="pw" required placeholder="특수문자, 영문, 숫자 8~16자" />
            </div>
            <div class="form-group">
                <label for="pwConfirm">비밀번호 확인 *</label>
                <input type="password" name="pwConfirm" required />
            </div>
            <div class="form-group">
                <label for="adminName">관리자명 *</label>
                <input type="text" name="name" required placeholder="관리자명을 입력하세요" />
            </div>
            <div class="submit-group">
                <button type="submit">가입하기</button>
            </div>
        </form>
    </div>
	 </main>
    </div>
	
    <script>
        // ID 중복 체크
        $('#idCheck').click(function() {
            var id = $('input[name="id"]').val();
            $.ajax({
                type: 'get',
                url: 'idOverlay', // 중복 확인 API URL
                data: { 'id': id },
                dataType: 'JSON',
                success: function(data) {
                    if (data.overlay > 0) {
                        $('#idResult').html(id + ' 는 이미 사용중 입니다.').css('color', 'red');
                    } else {
                        $('#idResult').html(id + ' 는 사용 가능합니다.').css('color', 'green');
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        });
    </script>
</body>
</html>
