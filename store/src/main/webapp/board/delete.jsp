<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	요청 URL
		http://localhost/store/board/delete.jsp?no=21
	요청 URI
		/store/board/delete.jsp
	쿼리스트링
		no=21
	요청파라미터 정보
		no			name
		-------------------------
		"no"		"21"
		-------------------------
		
	처리절차
		0. 로그인상태가 아니면 로그인폼으로 보내버린다.
	1. 요청 파라미터값을 조회한다.
	2. 게시글번호로 게시글 정보를 조회한다. (SELECT)
		3. 로그인한 사용자의 번호와 게시글 작성자의 번호가 같은지 확인한다.
		   번호가 서로 다르면 상세페이지를 재요청하게 한다.
	4. 게시글의 삭제여부를 'Y'로 변경한다. (변경하기)
	5. 변경된 게시글정보를 반영시킨다. (UPDATE)
	6. 목록을 재요청하는 URL을 응답으로 보낸다.
--%>
<%
	// 로그인여부를 체크한다.
	if (session.getAttribute("USERNO") == null) {
		response.sendRedirect("../user/login-form.jsp?deny");
		return; // 꼭 넣어줘야 아래 실행이 안된다.
	}
	
	// 요청파라미터 값을 조회한다.
	int no = Utils.toInt(request.getParameter("no"));

	// 삭제여부를 Y로 변경하기
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(no);
	
	// 작성자와 로그인한 사용자가 같은지 체크한다.
	int loginUserNo = (Integer) session.getAttribute("USERNO");
	if (loginUserNo != board.getUser().getNo()) {
		response.sendRedirect("detail.jsp?no=" + no + "&error");
		return;
	}
	
	board.setDeleted("Y");
	boardDao.updateBoard(board);
	
	// 재요청 RUL을 응답을 보내기
	response.sendRedirect("list.jsp");
%>