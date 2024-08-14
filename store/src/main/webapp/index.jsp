<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>애플리케이션</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</head>
<body>
<%--
	<%@ include file="포함시킬 jsp페이지" %>
		include 지시어
		현재 jsp페이지에 다른 jsp페이지를 포함시킨다.
		여러 페이지에 공통으로 표현되는 HTML컨텐츠를 별도의 jsp로 작성하고, 다른 jsp에서 지시어로 포함시켜 사용한다.
			중복코드를 작성할 필요가 없다.
			공통 컨텐츠 부분에 변경 이슈가 발생했을 때 해당 jsp만 수정하면 된다.
			
		예시
			nav.jsp
				내비바
				
			index.jsp
				<%@ include file="common/nav.jsp" %>
				<h1>홈 화면</h1>
				<p>홈페이지 방문을 환영합니다.</p>
 --%>
<%
	String menu = "홈";
%>
<%@ include file="common/nav.jsp" %>
	<div class="container">
		<h1>쇼핑몰 홈</h1>
	</div>
</body>
</html>