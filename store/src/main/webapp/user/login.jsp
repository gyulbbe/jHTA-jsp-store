<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%--
	요청 URL
		http://localhost/store/user/login.jsp
	요청 URI
		/store/user/login.jsp
	쿼리스트링
		없음
	폼데이터
		id=hong
		&password=zxcv1234
		
	요청파라미터 정보
		name		value
		-------------------------------
		"id"		"hong"
		"password"	"zxcv1234"
		
	처리내용
		1. 요청파라미터 값을 조회한다.
		2. 아이디로 사용자 정보를 조회한다.
			+ 사용자정보가 존재하지 않으면 login-form.jsp를 재요청
			+ 사용자가 비활성화상태면 login-form.jsp를 재요청
		3. 비밀번호를 sha256으로 변환해서 2번에서 조회한 비밀번호와 비교한다.
			+ 비밀번호가 일치하지 않으면 login-form.jsp 재요청
		4. HttpSesseion 객체에 인증이 완료된 사용자 정보를 저장한다.
		5. index.jsp를 재요청한다.
--%>

<%
	// 1. 요청파라미터값을 조회한다.
	String id = request.getParameter("id");
	String rawPassword = request.getParameter("password");
	
	// 2. 아이디로 사용자정보를 조회한다.
	UserDao userDao = new UserDao();
	User user = userDao.getUserById(id);
	
	if (user == null) {
		response.sendRedirect("login-form.jsp?invalid");
		return;
	}
	
	if ("Y".equals(user.getDisabled())) { // 조회된 사용자가 비활성화 상태인 경우
		response.sendRedirect("login-form.jsp?disabled");
		return;
	}
	
	// 3. 비밀번호를 비교한다.
	String sha256Password = DigestUtils.sha256Hex(rawPassword);
	if (!sha256Password.equals(user.getPassword())) {
		response.sendRedirect("login-form.jsp?invalid");
		return;
	}
	
	// 4. HttpSession객체에 인증된 사용자정보를 저장한다.
	session.setAttribute("USERNO", user.getNo());
	session.setAttribute("USERID", user.getId());
	session.setAttribute("USERNAME", user.getName());
	
	//LoginUser loginUser = new LoginUser(user.getNo(), user.getId(), user.getName());
	//session.setAttribute("LOGIN-USER", loginUser);
	
	// 5. index.jsp를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("../index.jsp");
%>