<%@page import="vo.Benefit"%>
<%@page import="java.util.List"%>
<%@page import="util.Utils"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
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
<div class="container mt-5 mb-5">
	<h1>상품 상세정보</h1>
	<p>상품의 상세정보를 확인하고, 장바구니에 담아보세요</p>
<%
	int productNo = Utils.toInt(request.getParameter("no"));
	ProductDao productDao = new ProductDao();
	Product product = productDao.getProductByNo(productNo);
%>
	<table class="table">
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="15%">
			<col width="35%">
		</colgroup>
		<tbody>
			<tr>
				<th>상품명</th>
				<td><%=product.getName() %></td>
				<th>번호</th>
				<td><%=product.getNo() %></td>
			</tr>
			<tr>
				<th>종류</th>
				<td><%=product.getCategory().getName() %></td>
				<th>제조회사</th>
				<td><%=product.getCompany().getName() %></td>
			</tr>
			<tr>
				<th>할인가격</th>
				<td><%=product.getDiscountPrice() %> 원</td>
				<th>가격</th>
				<td><%=product.getPrice() %> 원</td>
			</tr>
			<tr>
				<th>재고수량</th>
				<td><%=product.getStock() %> 개</td>
				<th>상태</th>
				<td><%=product.getStatus().getName() %></td>
			</tr>
			<tr>
				<th>설명</th>
				<td colspan="3"><%=product.getDescription() %></td>
			</tr>
			<tr>
<%
	List<Benefit> benefits = productDao.getBenefitByProductNo(productNo);
%>
				<th>추가혜택</th>
				<td colspan="3">
<%
	for (Benefit b : benefits) {
%>
					<span class="badge text-bg-success"><%=b.getName() %></span>
<%
	}
%>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="d-flex justify-content-end">
		<form class="border bg-light w-100 p-3 mt-3 row  row-cols-md-auto g-3 align-items-center"
			method="post" action="../cart/add.jsp">
			<input type="hidden" name="productNo" value="<%=productNo %>" />
				<div class="col-12">
					 <label class="form-label">수량</label>
				</div>
				<div class="col-12">
					 <input type="number" class="form-control"  name="amount" value="1" >
				</div>
				<div class="col-12">
					 <button type="submit" class="btn btn-primary">장바구니</button>
				</div>
		</form>
	</div>
</div>
</body>
</html>