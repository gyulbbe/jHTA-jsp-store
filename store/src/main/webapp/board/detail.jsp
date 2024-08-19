<%@page import="vo.Board"%>
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
<%@ include file="../common/nav.jsp" %>
<div class="container mt-4 mb-5">
	<h1>게시글 상세정보</h1>
	<p>게시글 상세정보와 댓글을 확인해보세요.</p>
<%--
	요청 URL
		http://localhost/store/board/detail.jsp?no=12&page=2
	요청 URI
		/store/board/detail.jsp
	쿼리스트링
		no=12&page=2
 --%>
 
 <%
 	// 요청파라미터값을 조회한다.
 	int no = Utils.toInt(request.getParameter("no"));
 	int pageNo = Utils.toInt(request.getParameter("page"), 1);
 	
 	BoardDao boardDao = new BoardDao();
 	Board board = boardDao.getBoardByNo(no);
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
				<th>제목</th>
				<td><%=board.getNo() %></td>
				<th>작성자</th>
				<td><%=board.getUser().getName() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><%=board.getTitle() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=Utils.toCurrency(board.getViewCnt()) %></td>
				<th>추천수</th>
				<td><%=Utils.toCurrency(board.getLikeCnt()) %></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><%=board.getCreatedDate() %></td>
				<th>수정일</th>
				<td><%=Utils.nullToBlank(board.getUpdatedDate()) %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><%=board.getContent() %></td>
			</tr>
		</tbody>
	</table>
	
<%--
	추천
		+ 로그인 후 가능하다.
		+ 이 게시글을 추천하지 않은 사용자만 가능하다.
		+ 이 게시글을 이미 추천한 사용자는 추천을 취소한다.
		
	수정/삭제
		+ 로그인 후 가능하다.
		+ 이 게시글의 작성자만 가능하다.
 --%>
 <%
 	// 게시글에 대한 수정/삭제 가능여부를 판정한다.
 	boolean canModify = false;
 	if (loginedUserId != null) {
 		int loginedUserNo = (Integer) session.getAttribute("USERNO");
 		if (loginedUserNo == board.getUser().getNo()) {
 			canModify = true;
 		}
 	}
 %>
 	<p></p>
	<div class="text-end">
		<a href="like.jsp" class="btn btn-success">추천</a>
		<a href="modify-form.jsp" class="btn <%=canModify ? "btn-warning" : "btn-secondary disabled" %>">수정</a>
		<a href="delete.jsp" class="btn <%=canModify ? "btn-danger" : "btn-secondary disabled" %>">삭제</a>
		<a href="list.jsp?page=<%=pageNo %>" class="btn btn-primary">목록</a>
	</div>
</div>
</body>
</html>