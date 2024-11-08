<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
       /* 콘텐츠와 사이드바 감싸는 래퍼 */
   .content-wrapper {
       display: flex;
       width: 100%;
       margin: 80px 10px; /* 헤더 높이만큼 여백 */
       flex-grow: 1; /* 남은 공간 채우기 */
   }
   h3{
    text-align: center;
    margin-bottom: 20px;
    text: 22px;
      
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
      text-align: right;
   }
   .btn01-l{
   margin-top: 10px;
   margin-bottom: 10px;
   }
        
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
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
        
  
   
   /* 헤더 스타일 */
   
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
   

   
</style>
</head>
<body>
   <!-- 헤더 -->
    <jsp:include page="../header.jsp"/> 

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
        <form id="adminJoinForm" action="/adminJoin" method="post">
            <div class="form-group">
                <label for="admin_id">아이디 *</label>
                <input type="text" name="admin_id" id="admin_id" required="required" placeholder="예시) admin123" />
                <button type="button" id="idCheck">중복확인</button>
                <span id="idResult" class="result"></span>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호 *</label>
                <input type="password" name="pw" required placeholder="특수문자, 영문, 숫자 8~16자" />
            </div>
            <div class="form-group">
                <label for="pwConfirm">비밀번호 확인 *</label>
                <input type="password" id="password"  name="pwConfirm" required />
            </div>
            <div class="form-group">
                <label for="adminName">관리자명 *</label>
                <input type="text" name="name" required placeholder="관리자명을 입력하세요" />
            </div>
            <div class="submit-group">
                <button id="joinsub" type="submit">가입하기</button>
            </div>
        </form>
    </div>
    </main>
    </div>
    <!-- 푸터 -->
      <jsp:include page="../footer.jsp" />
   </body>
    <script>
    
    var idChecked = false;
    
    
    $(document).ready(function() {
        $('#adminJoinForm').on('submit', function(event) {
            // 아이디와 비밀번호 필드를 가져옵니다.
            var pw = $('input[name="pw"]').val();
           var pwConfirm = $('input[name="pwConfirm"]').val();
            var admin_id = $('#admin_id').val().trim();
            var password = $('#password').val().trim();

            // 공백 확인 (아이디와 비밀번호에 공백이 있으면 경고창을 띄움)
            if (admin_id === '' || password === '') {
                alert('아이디와 비밀번호는 공백이 될 수 없습니다.');
                event.preventDefault(); // 폼 제출을 막습니다.
                return;
            }

            if (admin_id.includes(' ') || password.includes(' ')) {
                alert('아이디와 비밀번호에는 공백이 포함될 수 없습니다.');
                event.preventDefault(); // 폼 제출을 막습니다.
                return;
            }
            
            if (pw != pwConfirm) {
                alert("비밀번호가 다릅니다! 비밀번호를 확인하세요!");
                return false;  // 폼 제출을 막음
            }
            // 중복 체크 여부 확인
            if (!idChecked) {
                alert("아이디 중복 체크해주세요!");
                return false;  // 폼 제출을 막음
            }
            
        });
    });

   
    
    $('#idCheck').on('click', function() {
        var admin_id = $('input[name="admin_id"]').val();

        // 전체 공백 확인
        if (admin_id.trim() === '') {
            alert("아이디를 입력하세요.");
            return false;
        }

        // 앞뒤 공백이 있거나 중간에 공백이 포함된 경우 확인
        if (admin_id !== admin_id.trim() || /\s/.test(admin_id)) {
            alert("아이디에 앞뒤 공백이나 중간 공백이 포함될 수 없습니다.");
            return false;
        }
        
        idChecked = true;
        console.log(admin_id);
        $.ajax({
            type: 'GET',
            url: '/adminIdOverlay',
            data: {'admin_id': admin_id},
            dataType: 'JSON',
            success: function(data) {
                console.log(data);
                if (data.overlay > 0) {
                    $('#idResult').html('이미 사용중인 아이디 입니다.');
                    $('#idResult').css({'color': 'red'});
                } else {
                    $('#idResult').html('사용 가능한 아이디 입니다.');
                    $('#idResult').css({'color': 'green'});   
                }
            },
            error: function(e) {
                console.log(e);
            }
        });
    });
        
        var msg = '${msg}';
        if (msg != '') {
            alert(msg);
        }
        
        </script>
        <script src="resources/js/common.js" type="text/javascript"></script>
        <script src="resources/js/layerPopup.js"></script>
</html>
