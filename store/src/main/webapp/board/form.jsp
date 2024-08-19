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
	String menu = "게시판";
%>
<%@ include file="../common/nav.jsp" %>
<%
	if (loginedUserId == null) {
		response.sendRedirect("../user/login-form.jsp?deny");
		return;
	}
%>
<div class="container mt-4 mb-5">
	<h1>게시글 작성폼</h1>
	<p>제목, 내용을 입력하고 게시글을 등록해보세요.</p>
	
	<form class="border bg-light p-3" method="post" action="insert.jsp">
		<div class="mb-3">
			<label class="form-label">제목</label>
			<input type="text" class="form-control" name="title" />
		</div>
		<div class="mb-3">
			<label class="form-label">내용</label>
			<input type="text" class="form-control" name="content" />
		</div>
		<div class="text-end">
			<button type="submit" class="btb btn-primary">등록</button>
		</div>
	</form>
</div>
</body>
</html>