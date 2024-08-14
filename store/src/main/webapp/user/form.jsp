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
	<h1>회원가입 폼</h1>
	
<%
	String error = request.getParameter("error");
	if (error != null) {
%>
		<div class="alert alert-danger">
			아이디 혹은 이메일이 이미 사용중입니다.
		</div>
<%
	}
%>
	<form class="border bg-light p-3" method="post" action="insert.jsp">
		<div class="mb-3">
			<label class="form-label">아이디</label>
			<input class="form-control" type="text" name="id" />
		</div>
		<div class="mb-3">
			<label class="form-label">비밀번호</label>
			<input class="form-control" type="password" name="password" />
		</div>
		<div class="mb-3">
			<label class="form-label">이름</label>
			<input class="form-control" type="text" name="name" />
		</div>
		<div class="mb-3">
			<label class="form-label">이메일</label>
			<input class="form-control" type="text" name="email" />
		</div>
		<div class="text-end">
			<button class="btn btn-primary" type="submit">회원가입</button>
		</div>
	</form>
</body>
</html>