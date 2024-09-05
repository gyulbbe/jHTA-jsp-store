<%@page import="vo.Board"%>
<%@page import="java.util.List"%>
<%@page import="util.Pagination"%>
<%@page import="dao.BoardDao"%>
<%@page import="util.Utils"%>
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
<%@include file="../common/nav.jsp" %>
<div class="container mt-4 mb-5">
	<h1>게시판 목록</h1>
	<p>게시글 목록을 확인하세요</p>
	
<%--
	요청 URL
		http://localhost/store/board/list.jsp
		http://localhost/store/board/list.jsp?page=2
	요청 URI
		/store/board/list.jsp
	쿼리스트링
		없음
		page=2
		
	요청파라미터정보
		name		value
		------------------------------------
		"page"		"2"
--%>
<%
	// 요청파라미터 값을 조회한다.
	// 요청한 페이지번호를 조회한다. 페이지번호가 없으면 1을 반환한다.
	int pageNo = Utils.toInt(request.getParameter("page"), 1);
	
	BoardDao boardDao = new BoardDao();
	// 총 게시글 갯수를 조회한다.
	int totalRows = boardDao.getTotalRows();
	
	// 페이징처리에 필요한 정보를 제공하는 Pagination객체를 생성한다.
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	// 요청한 페이지번호에 맞는 조회범위의 게시글 목록을 조회한다.
	List<Board> boards = boardDao.getBoards(pagination.getBegin(), pagination.getEnd());
	
	
%>
	<table class="table">
		<colgroup>
			<col width="10%">
			<col width="*%"> <!-- 나머지 퍼센트를 차지한다. -->
			<col width="15%">
			<col width="10%">
			<col width="10%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>추천수</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
<%
	int rowNumber = pagination.getBegin();
	for (Board board : boards) {
%>
			<tr>
				<td><%=rowNumber++ %></td>
				<td><a href="hit.jsp?no=<%=board.getNo() %>&page=<%=pageNo %>"><%=board.getTitle() %></a></td>
				<td><%=board.getUser().getName() %></td>
				<td><%=Utils.toCurrency(board.getViewCnt()) %></td>
				<td><%=Utils.toCurrency(board.getLikeCnt()) %></td>
				<td><%=board.getCreatedDate() %></td>
			</tr>
<%
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
				<a href="list.jsp?page=<%=num %>" class="page-link <%=pageNo == num ? "active" : "" %>"><%=num %></a>
			</li>
<%
		}
%>
			<li class="page-item <%=pagination.isLast() ? "disabled" : "" %>">
				<a href="list.jsp?page=<%=pagination.getNext() %>" class="page-link">다음</a>
			</li>
		</ul>
	</div>
<%
	}
%>
<%
	// loginedUserId 변수는 nav.jsp에 선언된 변수다.
	if (loginedUserId != null) {
%>
	<div class="text-end">
		<a href="form.jsp" class="btn btn-primary">새 글</a>
	</div>
<%
	}
%>
</div>
</body>
</html>