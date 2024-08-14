<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>애플리케이션</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</head>
<body>
<%
	String menu = "회원가입";
%>
<%@ include file="../common/nav.jsp" %>
<div class="container mt-4 mb-5">
	<h1>회원가입 완료</h1>
	<p>회원가입이 완료되었습니다.</p>
	<p>
	<a href="login-form.jsp" class="btn btn-success btn-sm">로그인</a>
	</p>
</div>
</body>
</html>