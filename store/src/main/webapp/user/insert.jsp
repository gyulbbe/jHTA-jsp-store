<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%--
	요청 URL
		http://localhost/store/user/insert.jsp
	요청 URI
		store/user/insert.jsp
	쿼리스트링
		없음
	폼 데이터
		id=hong
		&password=zxcv1234
		&name=홍길동
		&email=hong@gmail.com
		
	요청파라미터 정보
		name		value
		---------------------------
		"id"		"hong"
		"password"	"zxcv1234"
		"name"		"홍길동"
		"email"		"hong@gmail.com"
		
	처리내용
		1. 요청파라미터값을 조회한다.
		2. 아이디 중복여부를 체크한다.
		3. 이메일 중복여부를 체크한다.
		4. 비밀번호를 암호화한다.
		5. User객체를 생성해서 요청파라미터로 조회된 값을 담는다.
		6. User객체를 UserDao로 insertUser(User user)메소드로 전달해서 데이터베이스에 저장시킨다.
		7. 회원가입 왼료 페이지를 재요청하는 URL을 응답으로 보낸다.
--%>
<%
	// 1. 요청파라미터 값을 조회한다.
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	// 2. 아이디 중복여부를 체크한다.
	UserDao userDao = new UserDao();
	User savedUser = userDao.getUserById(id);
	
	if (savedUser != null) {
		response.sendRedirect("form.jsp?error");
		return;
	}
	
	// 3. 비밀번호를 암호화한다
	String sha256Password = DigestUtils.sha256Hex(password);
	
	// 4. User객체를 생성해서 요청파라미터값을 저장한다.
	User user = new User();
	user.setId(id);
	user.setPassword(sha256Password);
	user.setName(name);
	user.setEmail(email);
	
	// 5. UserDao객체의 insertUser() 메소드를 실행해서 데이터베이스에 저장한다.
	userDao.insertUser(user);
	
	// 6. completed.jsp를 재요청하는URL을 응답으로 보내기
	response.sendRedirect("completed.jsp");
%>