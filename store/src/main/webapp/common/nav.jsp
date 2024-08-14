<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="container-fluid">
		<ul class="navbar-nav me-auto mb-2 mb-lg-0">
			<li class="nav-item">
				<a class="nav-link <%="홈".equals(menu) ? "active" : "" %>" href="/store/index.jsp">홈</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <%="상품관리".equals(menu) ? "active" : "" %>" href="/store/admin/product/home.jsp">상품관리</a>
			</li>
		</ul>
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link <%="로그인".equals(menu) ? "active" : "" %>" href="/store/user/login-form.jsp">로그인</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="/store/user/logout.jsp">로그아웃</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <%="회원가입".equals(menu) ? "active" : "" %>" href="/store/user/form.jsp">회원가입</a>
			</li>
		</ul>
	</div>
</nav>