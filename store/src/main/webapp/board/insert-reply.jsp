<%@page import="dao.BoardDao"%>
<%@page import="dao.ReplyDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="vo.Reply"%>
<%@page import="util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	요청 URL
		http://localhost/store/board/insertReply.jsp
	쿼리스트링
		없음
	폼 데이터
		bno=17&content=댓글내용입니다.
		
	요청파라미터 정보
		name		value
		-----------------------------
		"bno"		17
		"content"	"댓글내용입니다."
		
	요청처리절차
		1. 로그인여부를 체크한다.
		2. 필요한 정보를 수집한다.
			사용자번호: 세션에서 로그인된 사욪아 번호 수집
			게시글번호: 요청파라미터에서 수집
			댓글내용: 요청파라미터에서 수집
		3. Reply객체를 생성해서 수집한 값 저장
		4. ReplyDao의 insertReply(Reply reply)를 실행해서 신규 댓글정보 저장
		5. 수집된 게시글번호로 게시글정보 조회
		6. 게시글정보에서 댓글갯수 1증가
		7. 변경된 정보를 BoardDao의 updateBoard(Board board)를 실행해서 테이블에 반영
		8. 게사굴 상세정보를 요청하는 URL을 응답으로 보낸다.
--%>
<%
	// 로그인 여부를 체크한다.
	if(session.getAttribute("USERNO") == null) {
		response.sendRedirect("../user/login-form.jsp?deny");
		return;
	}

	// 요청처리에 필요한 정보수집
	int userNo = (Integer) session.getAttribute("USERNO");
	int boardNo = Utils.toInt(request.getParameter("bno"));
	String content = request.getParameter("content");
	
	// Reply객체에 수집된 정보담기
	Reply reply = new Reply();
	reply.setContent(content);
	
	Board board = new Board();
	board.setNo(boardNo);
	reply.setBoard(board);
	
	User user = new User();
	user.setNo(userNo);
	reply.setUser(user);
	
	// Reply객체를 DAO에 보내서 저장시키기
	ReplyDao replyDao = new ReplyDao();
	replyDao.insertReply(reply);
	
	// 댓글 수 증가
	BoardDao boardDao = new BoardDao();
	board = boardDao.getBoardByNo(boardNo);
	board.setReplyCnt(board.getReplyCnt() + 1);
	
	boardDao.updateBoard(board);
	
	// 게시글 상세정보를 요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("detail.jsp?no=" + boardNo);
%>