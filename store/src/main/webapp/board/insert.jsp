<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	요청 URL
		http://localhost/store/board/insert.jsp
	요청 URI
		/store/board/list.jsp
	쿼리스트링
		없음
	폼 데이터
		title=연습
		&content=연습입니다.
		
	요청파라미터
		name		value
		------------------------------------------
		"title"		"연습"
		"content"	"연습입니다."
	
	처리절차
		1. 요청 파라미터값을 조회한다.
			게시글제목, 게시글내용이 조회된다.
			* 새 게시글 등록에 피룡한 정보
				게시글번호 - 시퀀스번호 사용
				제목, 내용 - 요청파라미터 정보 사용
				작성자번호 - 로그인한 사용자의 번호
				
		2. 세션에 저장한 로그인 사용자번호를 조회한다.
		3. User객체를 생성하고, 사용자번호를 담는다.
		4. Board객체를 생성하고, 제목, 내용, User객체를 담는다.
			class User {
				 int no;				- 0
				 String title;			- "연습"
				 String content;		- "연습입니다."
				 int viewCount;			- 0
				 int likeCount;			- 0
				 int replyCount;		- 0
				 String deleted;		- null
				 Date createdDate;		- null
				 Date updatedDate;		- null
				 User user				- class User {
				 							int no				- 3001
				 							String id			- null
				 							String password		- null
				 							String name			- null
				 							...
				 							}
			}
		* 4번이 수행되고 나면 위와 같은 객체가 생성된다.
				 
		5. BoardDao객체를 생성하고, insertBoard(Board board) 메소드에 4번에서 생성한 객체를 전달해서 테이블에 저장시킨다.
		6. list.jsp 를 재요청하는 URL을 응답으로 보낸다.
--%>
<%
	// 요청 파라미터값 조회하기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 세션에서 로그인한 사용자 번호를 조회한다.
	int userNo = (Integer) session.getAttribute("USERNO");
	User user = new User(userNo);
	
	// Board객체를 생성해서 제목, 내용, 작성자 정보를 저장한다.
	Board board = new Board();
	board.setTitle(title);
	board.setContent(content);
	board.setUser(user);
	
	// BoardDao객체를 생성하고, BoardDao객체의 insertBoard() 메소드를 실행해서
	// 새 게시글 정보를 테이블에 저장시킨다.
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(board);
	
	// list.jsp를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp");
%>