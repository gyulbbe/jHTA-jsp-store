<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginedUserId = (String) session.getAttribute("USERID");
	String loginedUserName = (String) session.getAttribute("USERNAME");
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="container-fluid">
		<ul class="navbar-nav me-auto mb-2 mb-lg-0">
			<li class="nav-item">
				<a class="nav-link <%="홈".equals(menu) ? "active" : "" %>" href="/store/index.jsp">홈</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <%="게시판".equals(menu) ? "active" : "" %>" href="/store/board/list.jsp">게시판</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <%="상품관리".equals(menu) ? "active" : "" %>" href="/store/admin/product/home.jsp">상품관리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <%="문의".equals(menu) ? "active" : "" %>" href="/store/qna/list.jsp">문의</a>
			</li>
		</ul>
<%
	if (loginedUserName != null) {
%>
	<span class="navbar-text">
		<strong class="fw-bold text-white"><%=loginedUserName %></strong>님 환영합니다.
	</span>
<%
	}
%>
		<ul class="navbar-nav">
<%
	if (loginedUserId == null) {
%>
			<li class="nav-item">
				<a class="nav-link <%="로그인".equals(menu) ? "active" : "" %>" href="/store/user/login-form.jsp">로그인</a>
			</li>

			<li class="nav-item">
				<a class="nav-link <%="회원가입".equals(menu) ? "active" : "" %>" href="/store/user/form.jsp">회원가입</a>
			</li>
<%
	} else {
%>
			<li class="nav-item">
				<a class="nav-link" href="/store/user/logout.jsp">로그아웃</a>
			</li>
<%
	}
%>
		</ul>
	</div>
</nav>