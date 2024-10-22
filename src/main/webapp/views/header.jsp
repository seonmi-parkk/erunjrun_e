<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
	<div class="header-inner">
		<a href="/">
			<img src="resources/img/common/logo.png" alt="이런저런"/>
		</a>
		
		<c:choose>
			<c:when test="${sessionScope.adminYn eq 'N'}">
				<ul class="menu">
					<li>
						<a href="#">러닝크루</a>
						<ul class="depth2">
							<li>
								<a href="#">러닝크루</a>			
							</li>
							<li>
								<a href="#">러닝크루 개설</a>			
							</li>
						</ul>
					</li>
					<li>
						<a href="#">러닝메이트</a>
					</li>
					<li>
						<a href="#">게시판</a>
						<ul class="depth2">
							<li>
								<a href="#">러닝코스 게시판</a>			
							</li>
							<li>
								<a href="#">자유주제 게시판</a>			
							</li>
						</ul>
					</li>
					<li>
						<a href="#">아이콘몰</a>
					</li>
					<li>
						<a href="#">문의하기</a>
					</li>
				</ul>

				
				<div class="login-box">
					<c:choose>
						<c:when test="${not empty sessionScope.loginId}">
							<a class="profile-box" href="#">
								<c:choose>
									<c:when test="${not empty sessionScope.profileImg}">  
										<!-- 이부분 주소 변경 --><img class="profile-img" src="${sessionScope.profileImg}" alt="프로필 이미지"/>
									</c:when>
									<c:otherwise>
										<img class="profile-img" src="resources/img/common/profile.png" alt="프로필 이미지"/>
									</c:otherwise>
								</c:choose>
							</a>	
							<div class="notice">
								<div class="num-box">
									<span>3</span>
								</div>
								<img class="profile-img" src="resources/img/common/ico_notice.png" alt="알림"/>
							</div>
						</c:when>
						<c:otherwise>
							<a class="login" href="#">로그인</a>
							<a href="#">회원가입</a>
						</c:otherwise>
					</c:choose>
				</div>
			</c:when>
		<c:otherwise>
			<div class="admin-menu"> <!-- 관리자일 경우에만 display: block -->
				<img class="profile-img" src="resources/img/common/admin_profile.png" alt="관리자 프로필 이미지"/>
				<div class="admin-mod on">
					<div class="toggle-slider"></div>
					<span>관리자</span>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	

			</li>
			<li>
				<a href="#">러닝메이트</a>
			</li>
			<li>
				<a href="#">게시판</a>
				<ul class="depth2">
					<li>
						<a href="#">러닝코스 게시판</a>			
					</li>
					<li>
						<a href="#">자유주제 게시판</a>			
					</li>
				</ul>
			</li>
			<li>
				<a href="#">아이콘몰</a>
			</li>
			<li>
				<a href="#">문의하기</a>
			</li>
		</ul>
		<div class="login-box">

			<a class="login" href="login">로그인</a>
			<a href="join">회원가입</a>
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
	
<script>
	// 아이콘 체크 
	if('${sessionScope.iconImg}' != ''){
		$('header .profile-box').css('background','url(${sessionScope.iconImg}) center center/100% no-repeat ');
	}
</script>

