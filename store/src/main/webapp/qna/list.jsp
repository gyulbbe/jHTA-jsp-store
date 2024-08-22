<%@page import="java.util.List"%>
<%@page import="util.Pagination"%>
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
	<h1>내 문의 내역</h1>
	<p>내 문의 내역을 확인하세요. 새 1:1 문의를 등록해보세요.</p>
	
<%
	int userNo = (Integer) session.getAttribute("USERNO");
	QnaDao qnaDao = new QnaDao();
	int pageNo = Utils.toInt(request.getParameter("page"), 1);
	int totalRows = qnaDao.getTotalRowsByUserNo(userNo);
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	List<Qna> qnas = qnaDao.getQnasByUserNo(userNo, pagination.getBegin(), pagination.getEnd());
%>

	<table class="table">
		<colgroup>
			<col width="10%">
			<col width="*">
			<col width="15%">
			<col width="15%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>상태</th>
				<th>등록일자</th>
				<th>답변일자</th>
			</tr>
		</thead>
		<tbody>
			<!-- 
				등록된 질문이 하나도 없으면 아래의 내용이 출력된다.
			 -->
<%
	if (totalRows == 0) {
%>
			<tr>
				<td colspan="5" class="text-center">등록된 질문이 없습니다.</td>
			</tr>
<%
	} else {
%>
			<!-- 
				등록된 질문이 하나 이상 있으면 아래와 같이 출력된다.
			 -->
<%
	for (Qna qna : qnas) {
%>
			<tr>
				<td><%=qna.getQnaNo() %></td>
				<td><a href="detail.jsp?qnaNo=<%=qna.getQnaNo() %>&pageNo=<%=pageNo %>"><%=qna.getTitle() %></a></td>
				<td><span class="badge text-bg-secondary"><%=qna.getStatus() %></span></td>
				<td><%=qna.getCreatedDate() %></td>
				<td><%=qna.getAnsweredDate() %></td>
			</tr>
<%
		}
	}
%>
		</tbody>
	</table>
	
<%
	if (pagination.getTotalRows() > 0) {
		int beginPage = pagination.getBeginPage();
		int endPage = pagination.getEndPage();
%>
	<div>
		<ul class="pagination justify-content-center">
			<li class="page-item <%=pagination.isFirst() ? "disabled" : "" %>">
				<a href="list.jsp?page=<%=pagination.getPrev() %>" class="page-link">이전</a>
			</li>
<%
		for (int num = beginPage; num <= endPage; num++) {
%>
			<li class="page-item">
				<a href="list.jsp?=<%=num %>" class="page-link <%=pageNo == num ? "active" : "" %>">1</a>
			</li>
<%
		}
%>
			<li class="page-item <%=pagination.isLast() ? "disabled" : "" %>">
				<a href="list.jsp?pageNo=<%=pagination.getNext() %>" class="page-link">다음</a>
			</li>
		</ul>
	</div>
<%
	}
%>
	
	<div class="text-end">
		<a href="form.jsp" class="btn btn-primary">새 1:1문의</a>
	</div>
</div>
</body>
</html>