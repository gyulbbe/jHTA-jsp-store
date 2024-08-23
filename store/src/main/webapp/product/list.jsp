<%@page import="util.Pagination"%>
<%@page import="util.Utils"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
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
<%
	String menu = "상품";
%>
<%@ include file="../common/nav.jsp" %>
	<div class="container mt-4 mb-5">
		<h1>상품 목록</h1>
		<p>상품목록에서 상품을 확인해보세요</p>
		<p>상세보기를 클릭하면 더 자세한 상품정보를 확인할 수 있습니다.</p>
<%
	ProductDao productDao = new ProductDao();

	// 1. 요청한 페이지번호를 조회한다.
	int pageNo = Utils.toInt(request.getParameter("page"), 1);
	
	// 2. 총 데이터 갯수를 조회한다.
	int totalRows = productDao.getTotalRows();
	
	// 3. Pagination객체를 생성한다.
	Pagination pagination = new Pagination(pageNo, totalRows, 5);
	
	// 4. 요청한 페이지에 맞는 데이터를 조회한다.
	List<Product> products = productDao.getProducts(pagination.getBegin(), pagination.getEnd());

%>
		<table class="table">
			<colgroup>
				<col width="10%"><col>
				<col width="15%"><col>
				<col width="*"><col>
				<col width="18%"><col>
				<col width="10%"><col>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>종류</th>
					<th>상품명</th>
					<th>가격</th>
					<th>제조회사</th>
				</tr>
			</thead>
			<tbody>
<%
	for (Product p : products) {
%>
				<tr>
					<td><%=p.getNo() %></td>
					<td><%=p.getCategory().getName() %></td>
					<td><a href="detail.jsp?no=<%=p.getNo() %>&page=<%=pageNo %>&productNo=<%=p.getNo() %>"><%=p.getName() %></a></td>
					<td><%=p.getPrice() %>원</td>
					<td><%=p.getCompany().getName() %></td>
				</tr>
<%
	}
%>
			</tbody>
		</table>
		
		<%
	if (pagination.getTotalRows() > 0) {
%>
		<div>
			<ul class="pagination justify-content-center">
				<li class="page-item <%=pagination.isFirst() ? "disabled" : "" %>">
					<a class="page-link" href="list.jsp?page=<%=pagination.getPrev() %>">이전</a>
				</li>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
				<li class="page-item <%=pageNo == num ? "active" : ""%>"><a
					class="page-link" href="list.jsp?page=<%=num%>"><%=num%></a></li>
<%
	}
%>
				<li class="page-item"><a class="page-link <%=pagination.isLast() ? "disabled" : "" %>" href="list.jsp?page=<%=pagination.getNext() %>">다음</a></li>
			</ul>
		</div>
<%
	}
%>
	</div>
</body>
</html>