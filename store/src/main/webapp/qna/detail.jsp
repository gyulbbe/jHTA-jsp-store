<%@page import="util.Utils"%>
<%@page import="vo.Qna"%>
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
	<h1>1:1 문의 상세</h1>
	<p>1:1 문의 상세 내용과 답변을 확인하세요.</p>
<%
	int qnaNo = Utils.toInt(request.getParameter("qnaNo"));
	int pageNo = Utils.toInt(request.getParameter("pageNo"));
	
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.getQnaByNo(qnaNo);
%>
	<table class="table">
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="15%">
			<col width="35%">
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td><%=qna.getQnaNo() %></td>
				<th>종류</th>
				<td><%=qna.getCategory().getName() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><%=qna.getTitle() %></td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td><%=qna.getCreatedDate() %></td>
				<th>수정일자</th>
				<td><%=qna.getUpdatedDate() %></td>
			</tr>
			<tr>
				<th>상태</th>
				<td><span class="badge text-bg-primary"><%=qna.getStatus() %></span></td>
				<th>답변일자</th>
				<td><%=qna.getAnsweredDate() %></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
<%
	if (qna.getFilename() != null) {
%>
		<span><%=qna.getOriginalFilename() %></span>
		<a href="download?no=<%=qna.getQnaNo() %>" class="btn btn-success">다운로드</a>
<%
	} else {
%>
		없음
<%
	}
%>
				</td>
			</tr>
			
			<tr>
				<th>질문내용</th>
				<td colspan="3"><%=qna.getQuestion() %></td>
			</tr>
			<!-- 
				답변이 있는 경우 아래의 내용을 표시합니다.
			 -->
			<tr>
				<th>답변내용</th>
				<td colspan="3"><%=qna.getAnswer() %></td>
			</tr>
		</tbody>
	</table>
	
	<div>
		<!-- 
			수정/삭제는 답변완료 상태일 때는 비활성화 된다.
		 -->
		<a href="modify-form.jsp?no=xxx" class="btn btn-warning">수정</a>
		<a href="delete.jsp?no=xxx" class="btn btn-danger">삭제</a>
		<a href="list.jsp?pageNo=<%=pageNo %>" class="btn btn-primary float-end">목록</a>
	</div>
</div>
</body>
</html>