<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%--
	요청 URL
		http://localhost/store/user/logout.jsp
	요청 URI
		/store/user/logout.jsp
	쿼리스트링
		없음
		
	요청파라미터 정보
		없음
	처리내용
		HttpSession 객체를 폐기시킨다.
--%>
<%
	// 1. HttpSession 객체를 폐기시킨다.
	session.invalidate();

	// 2. index.jsp를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("../index.jsp");
%>