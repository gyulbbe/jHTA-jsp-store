<%@page import="vo.Board"%>
<%@page import="vo.Like"%>
<%@page import="dao.BoardDao"%>
<%@page import="util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	요청 URL
		http://local/store/board/like.jsp?no=21&page=1
	요청 URI
		/store/board/like.jsp
	쿼리스트링
		no=21&page=1
		
	요청파라미터 정보
		name		value
		-----------------------------
		"no"		"21"
		"page"		"1"
		
	처리절차
		1. 로그인 여부를 체크한다.
		2. 요청파라미터 정보를 조회한다.
		3. 게시글 번호, 사용자 번호로 좋아요 정보를 조회한다. (SELECT)
		4. 좋아요 정보가 존재하면 해당 정보를 삭제한다. (DELETE)
		   좋아요 정보가 존재하지 않으면 좋아요 정보를 추가한다. (INSERT)
		5. 게시글번호로 게시글 저옵를 조회한다. (SELECT)
		6. 게시글 정보의 좋아요 갯수를 변경한다. (변경)
		7. 변경된 게시글 정보를 반영시킨다. (UPDATE)
		8. 상세페이지를 재요청하는 URL을 응답으로 보낸다.
--%>
<%
	// 로그인여부를 체크한다.
	if (session.getAttribute("USERNO") == null) {
		response.sendRedirect("../user/login-form.jsp?deny");
		return;
	}
	int userNo = (Integer) session.getAttribute("USERNO");
	
	// 요청파라미터값을 조회한다.
	int boardNo = Utils.toInt(request.getParameter("no"));
	int pageNo = Utils.toInt(request.getParameter("page"), 1);
	
	BoardDao boardDao = new BoardDao();
	
	// 게시글 정보를 조회한다. <- 좋아요 갯수를 수정하기 위해서
	Board board = boardDao.getBoardByNo(boardNo);
	
	// 이미 등록된 좋아요 정보가 있는지 조회한다.
	Like savedLike = boardDao.getLikeByBoardNoAndUserNo(boardNo, userNo);
	if (savedLike == null) {
		// 없으면 새로 추가한다.
		boardDao.insertLike(boardNo, userNo);
		// 게시글정보의 좋아요 갯수를 증가
		board.setLikeCnt(board.getLikeCnt() + 1);
	} else {
		// 있으면 삭제한다.
		boardDao.deleteLike(boardNo, userNo);
		// 게시글정보의 좋아요 갯수를 감소
		board.setLikeCnt(board.getLikeCnt() + -1);
	}
	// 변경된 게시글정보를 테이블에 반영시킨다.
	boardDao.updateBoard(board);
	
	// detail.jsp를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("detail.jsp?no=" + boardNo + "&page=" + pageNo);
%>