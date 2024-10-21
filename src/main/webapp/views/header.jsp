<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
	header {
		padding : 15px 0 16px;
		max-width: 1300px;
		margin: 0 auto;
	}
	.header-inner {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: space-between; -ms-flex-pack: space-between; justify-content: space-between;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;  
	}
	
	header .menu {
		display : flex; display: -webkit-box; display: -moz-box; display: -ms-flexbox;
		
	}
	
	header .menu li a{
		padding: 10px 14px;
		margin: 0 9px;
		font-size: 18px;
	}
	
	header .login-box {
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;
	}
	
	header .login {
		margin-right : 20px;
	}
	
	header .profile-box {
		width : 46px;
		height : 46px;
		display : flex; display: -moz-box; display: -ms-flexbox;
		-webkit-box-pack: center; -ms-flex-pack: center; justify-content: center;
		-webkit-box-align: center; -ms-flex-align: center; align-items: center;  
	}
	
	header .profile-box .profile-img{
		width: 32px;
	}
	
	
	header .notice{
		position: relative;
	    padding: 6px;
		cursor: pointer;
	}
	
	header .notice .num-box{
		position: absolute;
		right: -1px;
   		top: 0px;
		right: 6px;
		width: 16px; 
		height: 16px;
		line-height: 16px;
		text-align: center;
		background: var(--main-color);
		border-radius: 50%;
	}
	header .notice .num-box span{
		color: #fff;
		font-size: 11px;
	}
</style>
</head>
<body>
	<header>
		<div class="header-inner">
			<a href="/">
				<img src="resources/img/common/logo.png" alt="이런저런"/>
			</a>
			<ul class="menu">
				<li>
					<a href="#">러닝크루</a>
				</li>
				<li>
					<a href="#">러닝메이트</a>
				</li>
				<li>
					<a href="#">게시판</a>
				</li>
				<li>
					<a href="#">아이콘몰</a>
				</li>
				<li>
					<a href="#">문의하기</a>
				</li>
			</ul>
			<div class="login-box">
				<a class="login" href="#">로그인</a>
				<a href="#">회원가입</a>
				<a class="profile-box" href="#">
					<img class="profile-img" src="resources/img/common/profile.png" alt="프로필 이미지"/>
				</a>
				<div class="notice">
					<div class="num-box">
						<span>3</span>
					</div>
					<img class="profile-img" src="resources/img/common/ico_notice.png" alt="알림"/>
				</div>
			</div>

		</div>
	</header>
</body>
<script>

</script>
</html>