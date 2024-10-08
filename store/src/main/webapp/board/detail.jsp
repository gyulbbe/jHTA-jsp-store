<%@page import="util.Pagination"%>
<%@page import="java.util.ArrayDeque"%>
<%@page import="util.NestedReply"%>
<%@page import="vo.Reply"%>
<%@page import="java.util.List"%>
<%@page import="dao.ReplyDao"%>
<%@page import="vo.Like"%>
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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
		http://localhost/store/board/detail.jsp?no=12&error
	요청 URI
		/store/board/detail.jsp
	쿼리스트링
		no=12&page=2
		no=12&error
		
	요청파라미터정보
		name		value
		---------------------------------
		"no"		"12"		게시글번호
		"page"		"2"			되돌아갈 페이지번호
		---------------------------------
		---------------------------------
		"no"		"12"		게시글번호
		"error"		""			오류가 나서 detail로 되돌아왔다는 표시
		---------------------------------

--%>

<%
	if (request.getParameter("error") != null) {
%>
	<div class="alert alert-danger">
		수정/삭제는 게시글 작성자만 가능합니다.
	</div>
<%
	}
%>


<%
	// 요청파라미터값을 조회한다.
	int no = Utils.toInt(request.getParameter("no"));
	int pageNo = Utils.toInt(request.getParameter("page"), 1);
	
	// 전달받은 게시글번호에 해당하는 게시글 상세정보를 조회한다.
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
				<th>번호</th>
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
		+ 이 게시글을 이미 추천한 사용자는 추천을 취소한다.
	
	수정/삭제
		+ 로그인 후 가능하다.
		+ 이 게시글의 작성자만 가능하다.
 --%>
 <%
 	// 게시글에 대한 수정/삭제 가능여부를 판정한다.
 	// 로그인되어 있고, 로그인한 사용자번호와 게시글의 작성자번호가
 	// 같은 때 true로 판정한다.
 	boolean canLike = false;
 	boolean showMyLike = false;
 	boolean canModify = false;
 	if (loginedUserId != null) {
 		canLike = true; 		
 		int loginedUserNo = (Integer) session.getAttribute("USERNO");
 		// 로그인한 사용자가 이 게시글에 좋아요를 했는지 조회
 		Like savedLike = boardDao.getLikeByBoardNoAndUserNo(no, loginedUserNo);
 		if (savedLike != null) {
 			showMyLike = true;	// 이 게시글에 좋아요를 했다.
 		}
 		if (loginedUserNo == board.getUser().getNo()) {
 			canModify = true;
 		}
 	}
 	
 %>
	<div>
<%
	if (canLike) {
%>
		<a href="like.jsp?no=<%=no %>&page=<%=pageNo %>" 
			class="btn btn-outline-success position-relative">
			좋아요
			<i class="bi <%=showMyLike ? "bi-heart-fill" : "bi-heart" %>"></i>
			<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%=board.getLikeCnt() %></span>
		</a>
<%
	} else {
%>
		<a href="" class="btn btn-outline-secondary  position-relative disabled">			
			좋아요
			<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%=board.getLikeCnt() %></span>
		</a>
<%	
	}
%>
<%
	if (canModify) {
%>
	<div class="float-end">
		<a href="modify-form.jsp" class="btn btn-warning">수정</a>
		<a href="delete.jsp?no=<%=no %>" class="btn btn-danger">삭제</a>
		<a href="list.jsp?page=<%=pageNo %>" class="btn btn-primary">목록</a>
	</div>
<% 
	} else {
%>
	<div class="float-end">
		<a href="" class="btn btn-secondary disabled">수정</a>
		<a href="" class="btn btn-secondary disabled">삭제</a>
		<a href="list.jsp?page=<%=pageNo %>" class="btn btn-primary">목록</a>
	</div>
<%
	}
%>
	</div>
<%
	if (loginedUserId != null) {
%>
	<form class="border bg-light p-3 mt-3" method="post" action="insert-reply.jsp">
		<input type="hidden" name="bno" value="<%=board.getNo() %>" />
		<div class="mb-3">
			<label class="form-label">내용</label>
			<textarea rows="3" cols="form-control" name="content"></textarea>
		</div>
		<div class="text-end">
			<button type="submit" class="btn btn-primary btn-sm">등록</button>
		</div>
	</form>
<%
	}
%>
	
<%
	ReplyDao replyDao = new ReplyDao();
	// default 페이지
	int replyPageNo = Utils.toInt(request.getParameter("replyPage"), 1);
	// 총 루트 댓글 수
	int nestedReplyTotalRows = replyDao.getCountRootCommentByBoardNo(no);
	// 페이징 세팅
	Pagination replyPagination = new Pagination(replyPageNo, nestedReplyTotalRows);
	
	// 게시글의 댓글 조회하기
	List<Reply> replyList = replyDao.getReplyListByBoardNo(board.getNo(), replyPagination.getBegin(), replyPagination.getEnd());
%>
	<div class="mt-3">
<%
	int userNo = -1;	// 로그인하지 않았다면 userNo는 -1
	if (session.getAttribute("USERNO") != null) {
		userNo = (Integer) session.getAttribute("USERNO");
	}
	
	for (Reply reply : replyList) {
		boolean canReplyModify = userNo == reply.getUser().getNo();
%>
      <div class="border p-2 mb-2">
         <div class="small d-flex justify-content-between">
            <div>
               <span><%=reply.getUser().getName() %></span>
               <span><%=reply.getCreatedDate() %></span>
               <span>댓글 번호: <%=reply.getNo() %></span>
            </div>
            <div>
<%
		if (canReplyModify) {
%>
				<a href="modify-reply-form.jsp" class="btn btn-outline-dark btn-sm">수정</a>
				<a href="delete-reply.jsp?rno=<%=reply.getNo()%>&bno=<%=board.getNo()%>&page=<%=pageNo%>" class="btn btn-outline-dark btn-sm">삭제</a>
<%
		} else {
%>
				<a href="modify-reply-form.jsp" class="btn btn-outline-dark btn-sm disabled">수정</a>
				<a href="delete-reply.jsp" class="btn btn-outline-dark btn-sm disabled">삭제</a>
<%
		}
%>
            </div>
         </div>
         <p class="mb-0"><%=reply.getContent() %></p>
         
        <!-- 댓글의 답글 버튼 및 입력 폼 -->
        <%
        if (loginedUserId != null) {
        %>
        <div class="mt-2">
            <button class="btn btn-sm btn-outline-primary" onclick="toggleNestedReplyForm(<%=reply.getNo()%>)">답글</button>
            <form id="nestedReplyForm<%=reply.getNo()%>" class="mt-2" style="display:none;" method="post" action="insert-nested-reply.jsp">
                <input type="hidden" name="bno" value="<%=board.getNo() %>" />
                <input type="hidden" name="parentReplyNo" value="<%=reply.getNo() %>" />
                <textarea class="form-control" rows="2" name="content" placeholder="답글을 입력하세요"></textarea>
                <button type="submit" class="btn btn-primary btn-sm mt-1">답글 등록</button>
            </form>
        </div>
        <%
        }
        %>
        
        <!-- 대댓글 목록 -->
        <%
        NestedReply nestedReply = new NestedReply();
        ArrayDeque<Reply> stack = nestedReply.getNestedReplies(reply.getNo());
        while (!stack.isEmpty()) {
        	Reply nr = stack.pollFirst();
		%>
	    	<!-- 대댓글 조회 -->
	        <div class="nested-reply mt-2" style="margin-left: <%=nr.getDepth()*20%>px;">
	        	<div class="small d-flex justify-content-between">
	            	<div>
	                	<span><%=nr.getUser().getName() %></span>
	                    <span><%=nr.getCreatedDate() %></span>
	                    <span>부모 댓글 번호: <%=nr.getParentNo() %></span>
	                    <span>깊이: <%=nr.getDepth() %></span>
	                </div>
	                <div>
	                    <a href="#" class="btn btn-outline-dark btn-sm">수정</a>
	                    <a href="#" class="btn btn-outline-dark btn-sm">삭제</a>
	                </div>
	            </div>
	            <p class="mb-0"><%=nr.getContent() %></p>
	                
	            <!-- 대댓글의 답글 버튼 및 입력 폼 -->
	            <div class="mt-2">
	                <button class="btn btn-sm btn-outline-primary" onclick="toggleNestedReplyForm('<%=nr.getNo()%>')">답글</button>
	                <form id="nestedReplyForm<%=nr.getNo()%>" class="mt-2" style="display:none;" method="post" action="insert-nested-reply.jsp">
	                    <input type="hidden" name="bno" value="<%=board.getNo() %>" />
	                    <input type="hidden" name="parentReplyNo" value="<%=nr.getNo() %>" />
	                    <textarea class="form-control" rows="2" name="content" placeholder="답글을 입력하세요"></textarea>
	                    <button type="submit" class="btn btn-primary btn-sm mt-1">답글 등록</button>
	                </form>
	            </div>
	        </div>
	   <%
        }
        %>
	</div>
<%
	}
	if (replyPagination.getTotalRows() > 0) {
		int beginPage = replyPagination.getBeginPage();
		int endPage = replyPagination.getEndPage();
%>
	<div>
		<ul class="pagination justify-content-center">
			<li class="page-item <%=replyPagination.isFirst() ? "disabled" : "" %>">
				<a href="detail.jsp?no=<%=no %>&replyPage=<%=replyPagination.getPrev() %>" class="page-link">이전</a>
			</li>
<%
		for (int num = beginPage; num <= endPage; num++) {
%>
			<li class="page-item">
				<a href="detail.jsp?no=<%=no %>&replyPage=<%=num %>" class="page-link <%=replyPageNo == num ? "active" : "" %>"><%=num %></a>
			</li>
<%
		}
%>
			<li class="page-item <%=replyPagination.isLast() ? "disabled" : "" %>">
				<a href="detail.jsp?no=<%=no %>&replyPage=<%=replyPagination.getNext() %>" class="page-link">다음</a>
			</li>
		</ul>
	</div>
<%
	}
%>
</div>

<script>
function toggleNestedReplyForm(replyId) {
    var form = document.getElementById('nestedReplyForm' + replyId);
    form.style.display = form.style.display === 'none' ? 'block' : 'none';
}
</script>
</div>
</body>
</html>