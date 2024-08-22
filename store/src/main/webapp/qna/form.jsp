<%@page import="java.util.List"%>
<%@page import="vo.QnaCategory"%>
<%@page import="dao.QnaDao"%>
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
	String menu = "문의";
%>
<%@ include file="../common/nav.jsp" %>

<div class="container mt-4 mb-5">
	<h1>1:1 문의 입력폼</h1>
	<p>1:1 문의 내용을 입력하고, 등록하세요</p>
	
<%
	QnaDao qnaDao = new QnaDao();
	List<QnaCategory> qnaCategories = qnaDao.getAllQnaCategories();
%>
	<form class="border bg-light p-3" method="post" action="insert.jsp">
		<div class="mb-3">
			<label class="form-label">구분</label>
			<select class="form-select" name="catNo">
				<option value="" selected disabled> 질문 종류를 선택하세요</option>
				<!-- 
					store_qna_categories 테이블의 정보를 활용해서
					아래의 option태그를 생성하세요.
				 -->
<%
	for (QnaCategory qnaCategory : qnaCategories) {
%>
				<option value="<%=qnaCategory.getNo() %>"> <%=qnaCategory.getName() %></option>
<%
	}
%>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">제목</label>
			<input type="text" class="form-control" name="title" >
		</div>
		<div class="mb-3">
			<label class="form-label">질문내용</label>
			<textarea class="form-control" name="question" rows="5"></textarea>
		</div>
		<div class="text-end">
			<button type="submit" class="btn btn-primary">등록</button>
		</div>
	</form>
</div>
</body>
</html>