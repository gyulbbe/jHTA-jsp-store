<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="util.Utils"%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%--
	요청 URL
		http://localhost/store/hit.jsp?no=20&page=2
	요청 URI
		/store/board/hit/jsp
	쿼리스트링
		no=20&page=2
		
	요청파라미터 정보
		name		value
		--------------------------------
		"no"		"20"
		"page"		"2"
		--------------------------------
--%>
<%
	// 요청파라미터 값 조회하기
	int no = Utils.toInt(request.getParameter("no"));
	int pageNo = Utils.toInt(request.getParameter("page"));
	
	// 조회수 증가시키기
	BoardDao boardDao = new BoardDao();
	// 1. 현재 게시글 정보를 조회한다. (SELECT)
	Board board = boardDao.getBoardByNo(no);
	// 2. 값을 수정한다.
	board.setViewCnt(board.getViewCnt() + 1);
	// 3. 변경된 내용을 테이블에 반영시킨다. (UPDATE)
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo);
%>