<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.Cart"%>
<%@page import="java.util.List"%>
<%@page import="dao.CartDao"%>
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
	String menu = "장바구니";
%>
<%@ include file="../common/nav.jsp" %>
<div class="container mt-4 mb-5">
	<h1>장바구니 목록</h1>
	<p>장바구니에 담기 상품을 확인해보세요</p>
<%
	if (session.getAttribute("USERNO") == null) {
		response.sendRedirect("../user/login-form.jsp?deny");
		return;
	}

	int userNo = (Integer) session.getAttribute("USERNO");

	CartDao cartDao = new CartDao();
	List<Cart> carts = cartDao.getAllCartByUserNo(userNo);

%>
	
	<form method="post" action="delete.jsp">
		<table class="table">
			<colgroup>
				<col width="5%">
				<col width="*">
				<col width="10%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>상품명</th>
					<th>수량</th>
					<th>할인가격</th>
					<th>구매금액</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
<%
	if (carts.isEmpty()) {
%>
		<tr>
			<td colspan="6" class="text-center">
				장바구니에 저장된 상품이 없습니다.
			</td>
		</tr>
<%
	}
%>
<%
	DecimalFormat df = new DecimalFormat("###,###");
	int allPrice = 0; // 총 주문 금액
	int allAmount = 0; // 총 주문 수량
	int allGap = 0; // 총 할인 금액
	int finalAmount = 0; // 최종 결재 금액
	
	for (Cart c : carts) {
		int amount = c.getAmount();
		int price = c.getProduct().getPrice() * amount;
		int discountPrice = c.getProduct().getDiscountPrice() * amount;
		int gap = price - discountPrice;
		
		allPrice += price;
		allAmount += amount;
		allGap += gap;
		finalAmount += discountPrice;
		
		String formatPrice = df.format(price);
		String formatGap = df.format(gap);
%>
				<tr>
					<td><input type="checkbox" name="itemNo" value="<%=c.getNo() %>"></td>
					<td><a href=""><%=c.getProduct().getName() %></a></td>
					<td><%=amount %> 개</td>
					<td><%=formatGap %> 원</td>
					<td><%=formatPrice %> 원</td>
					<td class="text-end"><a href="delete.jsp?itemNo=<%=c.getNo() %>" class="btn btn-outline-danger btn-sm">삭제</a></td>
				</tr>
<%
	}
%>
			</tbody>
		</table>
<%
	if (carts.isEmpty()) {
%>
		<div>
			<button type="submit" class="btn btn-outline-secondary btn-sm" disabled>선택삭제</button>
			<button type="submit" class="btn btn-outline-secondary btn-sm" disabled>전체삭제</button>
			<button type="submit" class="btn btn-primary btn-sm float-end" disabled>주문하기</button>
		</div>
<%
	} else {
%>
		<div>
			<button type="submit" class="btn btn-outline-secondary btn-sm">선택삭제</button>
			<button type="submit" class="btn btn-outline-secondary btn-sm">전체삭제</button>
			<button type="submit" class="btn btn-primary btn-sm float-end">주문하기</button>
		</div>
<%
	}
%>
	</form>
	
	<table class="table  mt-5 text-center">
		<colgroup>
			<col width="25%">
			<col width="25%">
			<col width="25%">
			<col width="25%">
		</colgroup>
		<tr>
			<th>총 주문금액</th>
			<th>총 주문수량</th>
			<th>총 할인금액</th>
			<th class="table-dark">최종 결재금액</th>
		</tr>
<%
	String formatAllPrice = df.format(allPrice);
	String formatAllGap = df.format(allGap);
	String formatFinalAmount = df.format(finalAmount);
%>
		<tr>
			<th><strong><%=formatAllPrice %></strong> 원</th>
			<th><strong><%=allAmount %></strong> 개</th>
			<th><strong><%=formatAllGap %></strong> 원</th>
			<th class="table-dark"><strong><%=formatFinalAmount %></strong> 원</th>
		</tr>
	</table>
	
</div>
</body>
</html>