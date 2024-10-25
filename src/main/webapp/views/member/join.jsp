<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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

input[type="text"], input[type="password"], input[type="email"], input[type="number"]
	{
	width: calc(100% - 90px); /* 버튼을 위한 공간을 남겨둠 */
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	display: inline-block; /* 버튼과 함께 수평 정렬 */
}

button {
	background-color: #ff7f50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	padding: 10px;
	margin-left: 5px; /* 입력 칸과 버튼 사이의 간격 */
}

button:hover {
	background-color: #ff6347;
}

.result {
	margin-left: 10px; /* 버튼과 결과 사이의 간격 */
	font-weight: bold;
	display: inline-block; /* 수평 정렬 */
	vertical-align: middle; /* 버튼과 같은 높이로 맞춤 */
}

.submit-group {
	text-align: right; /* 버튼을 오른쪽으로 정렬 */
}
</style>
</head>
<body>
	<div class="container">
		<h3>회원가입</h3>
		<form id="joinForm" action="join" method="post">
			<div class="form-group">
				<label for="id">아이디 *</label> <input type="text" name="id" required
					placeholder="예시) runrunrun" />
				<button type="button" id="idCheck">중복확인</button>
				<span id="idResult" class="result"></span>
			</div>
			<div class="form-group">
				<label for="pw">비밀번호 *</label> <input type="password" name="pw"
					required placeholder="특수문자,영문,숫자 8~16자" />
			</div>
			<div class="form-group">
				<label for="pwConfirm">비밀번호 확인 *</label> <input type="password"
					name="pwConfirm" required />
			</div>
			<div class="form-group">
				<label for="name">이름 *</label> <input type="text"
					name="name" required />
			</div>
			<div class="form-group">
				<label for="nickName">닉네임 *</label> <input type="text"
					name="nickName" required placeholder="예시) 달려달려달려" />
				<button type="button" id="nickNameCheck">중복확인</button>
				<span id="nickNameResult" class="result"></span>
			</div>
			<div class="form-group">
				<label for="address">주소 *</label> <input type="text" name="address"
					required placeholder="예시) 서울시 금천구 가산동" />
			</div>
			<div class="form-group">
				<label>성별 *</label> <input type="radio" name="gender" value="남"
					required /> 남 <input type="radio" name="gender" value="여" required />
				여
			</div>
			<div class="form-group">
				<label for="birth">생년월일 *</label> <input type="number"
					name="birth" required placeholder="생년월일 8자리 입력" />
			</div>
			<div class="form-group">
				<label for="email">이메일 *</label> <input type="email" name="email"
					required placeholder="예시) run@naver.com" />
				<button type="button" id="emailCheck">중복확인</button>
				<span id="emailResult" class="result"></span>
			</div>
			<div class="form-group">
				<label for="phoneNumber">휴대전화번호</label> <input type="text"
					name="phoneNumber" placeholder="예시) 010-1234-5678" />
			</div>
			<div class="submit-group">
				<button type="submit">가입하기</button>
			</div>
		</form>
	</div>

	<script>
	var msg = '${msg}';
	if (msg != '') {
		alert(msg);
	}
	
        // ID 중복 체크
        $('#idCheck').click(function() {
            var id = $('input[name="id"]').val();
            $.ajax({
                type: 'get',
                url: 'idOverlay',
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

        // 닉네임 중복 체크
        $('#nickNameCheck').click(function() {
            var nickName = $('input[name="nickName"]').val();
            $.ajax({
                type: 'get',
                url: 'nickNameOverlay',
                data: { 'nickName': nickName },
                dataType: 'JSON',
                success: function(data) {
                    if (data.overlay > 0) {
                        $('#nickNameResult').html(nickName + ' 는 이미 사용중 입니다.').css('color', 'red');
                    } else {
                        $('#nickNameResult').html(nickName + ' 는 사용 가능합니다.').css('color', 'green');
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        });

        // 이메일 중복 체크
        $('#emailCheck').click(function() {
            var email = $('input[name="email"]').val();
            $.ajax({
                type: 'get',
                url: 'emailOverlay',
                data: { 'email': email },
                dataType: 'JSON',
                success: function(data) {
                    if (data.overlay > 0) {
                        $('#emailResult').html(email + ' 는 이미 사용중 입니다.').css('color', 'red');
                    } else {
                        $('#emailResult').html(email + ' 는 사용 가능합니다.').css('color', 'green');
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        });
        
     // 유효성 검사
		$('#joinForm').on('submit', function(event) {
			var valid = true;
			var id = $('input[name="id"]').val().trim();
			var pw = $('input[name="pw"]').val().trim();
			var pwConfirm = $('input[name="pwConfirm"]').val().trim();
			var nickName = $('input[name="nickName"]').val().trim();
			var address = $('input[name="address"]').val().trim();
			var birth = $('input[name="birth"]').val();
			var email = $('input[name="email"]').val().trim();
			var phoneNumber = $('input[name="phoneNumber"]').val().trim();

			// id유효성 검사 
			var idPattern = /^[a-zA-Z0-9]+$/;
			if (id.length < 4 || id.length > 20 || !idPattern.test(id)) {
    			if (id.length < 4 || id.length > 20) {
        			alert('ID는 4자리 이상 20자리 이하이어야 합니다.');
   				}
    			if (!idPattern.test(id)) {
        			alert('ID는 영어와 숫자만 포함할 수 있습니다.');
    			}
    			valid = false;
			}

			// pw유효성 검사
			var passwordPattern = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[\W_]).{8,16}$/;
			if (!passwordPattern.test(pw)) {
			    alert('비밀번호는 숫자, 영문, 특수문자를 포함하여 8자 이상 16자 이하이어야 합니다.');
			    valid = false;
			}
			
			// pw 확인
			if (pw !== pwConfirm) {
				alert('비밀번호가 일치하지 않습니다.');
				valid = false;
			}
			
			// 닉네임 영문, 숫자, 한글만 허용 특수문자 x!
			var nickNamePattern = /^[a-zA-Z0-9가-힣]+$/;
			if (!nickNamePattern.test(nickName)) {
			    alert('닉네임은 영문, 숫자, 한글만 포함할 수 있습니다.');
			    valid = false;
			}
			
			// 주소는 따로 만들 필요가 있을 듯..?
			
			// 생년월일 유효성 검사
			var birth = $('input[name="birth"]').val().trim();
			var birthPattern = /^\d{8}$/; // 숫자 8자리

			if (!birthPattern.test(birth)) {
    			alert('생년월일은 8자리 숫자로 입력해야 합니다.');
    			valid = false;
			}

			// 이메일 유효성 검사
			var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailPattern.test(email)) {
				alert('유효한 이메일 주소를 입력하세요.');
				valid = false;
			}
			
			 var phonePattern = /^\d{3}-\d{4}-\d{4}$/;
			    if (!phonePattern.test(phoneNumber)) {
			        alert('유효한 전화번호(010-1234-5678)을 입력하세요.');
			        valid = false;
			    }

			// 유효하지 않으면 폼 제출 중단
			if (!valid) {
				event.preventDefault();
			}
		});
		
    </script>
</body>
</html>
