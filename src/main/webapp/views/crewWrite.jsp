<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>crewWrite</title>
	<link rel="stylesheet" href="resources/css/common.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="resources/js/summernote.js"></script>
	<script src="resources/js/daumapi.js"></script>
	

<style>
	
</style>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<div class="inner">
		<p class="title1">러닝크루 등록</p>
		
		<p class="title2">크루명 <input type="text" name="crew_name" required/></p>
		<p>수정</p>
	
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>