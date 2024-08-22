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
	String menu = "로그인";
%>
<%@ include file="../common/nav.jsp" %>
<div class="container mt-4 mb-5">
	<h1>로그인폼</h1>
<%
	String message = null;

	if (request.getParameter("invalid") != null) {
		message = "아이디 혹은 비밀번호가 올바르지 않습니다.";
	}

	if (request.getParameter("disabled") != null) {
		message = "사용이 정지된 사용자는 로그인 할 수 없습니다.";
	}
	
	if (request.getParameter("deny") != null) {
		message = "로그인이 필요한 서비스입니다.";
	}
%>

<%
	if (message != null) {
%>
	<div class="alert alert-danger">
		<%=message %>
	</div>
<%
	}
%>
	<p>아이디와 비밀번호를 입력하고 로그인하세요</p>
	<form class="border bg-light p-3" method="post" action="login.jsp">
		<div class="mb-3">
			<label class="form-label">아이디</label>
			<input class="form-control" type="text" name="id" value="12" />
		</div>
		<div class="mb-3">
			<label class="form-label">비밀번호</label>
			<input class="form-control" type="password" name="password" value="zxcv1234" />
		</div>
		<div class="text-end">
			<button type="submit" class="btn btn-primary">로그인</button>
		</div>
	</form>
</div>
</body>
</html>