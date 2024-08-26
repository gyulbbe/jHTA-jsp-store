<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.Benefit"%>
<%@page import="dao.BenefitDao"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.Utils"%>
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
	String menu = "상품관리";
%>
<%@ include file="../../common/nav.jsp" %>
<div class="container mt-4 mt-5">
	<h1>상품 상세정보</h1>
	
<%--
	요청 URL
		http://localhost/store/admin/product/detail.jsp?no=xxx
	요청 URI
		/store/admin/product/detail.jsp
	쿼리스트링
		no=xxx
		
	요청파라미터 정보
		name		value		
		---------------------------------
		"no"		"xxx"		상품번호
--%>

<%
	int productNo = Utils.toInt(request.getParameter("no"));
	// 요청파라미터로 전달받은 상품번호가 유효하지 않으면 home.jsp를 재욧청하는 URL을 응답으로 보낸다.
	if (productNo == 0) {
		response.sendRedirect("home.jsp?error");
		return;
	}
	
	// 2. 요청파라미터로 전달받은 상품번호에 해당하는 상품상세정보를 조회한다.
	ProductDao productDao = new ProductDao();
	Product product = productDao.getProductByNo(productNo);
	
	// 3. 요청파라미터로 전달받은 상품의 추가혜택정보를 조회한다.
	List<Benefit> benefits = productDao.getBenefitByProductNo(productNo);
%>
	
	<table class="table table-bordered">
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="15%">
			<col width="35%">
		</colgroup>
		<thead class="table-dark">
			<tr>
				<th>항목</th>
				<th>값</th>
				<th>항목</th>
				<th>값</th>
			</tr>
		</thead>
		<tbody>
<%
	if (product == null){
%>
			<tr>
				<td class="text-center" colspan="4">
					상품정보가 존재하지 않습니다.
				</td>
			</tr>
<%
	} else {
%>
			<tr>
				<th>상품사진</th>
				<td colspan="3">
					<img src="/store/resources/photo/<%=product.getFilename() %>" />
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=StringEscapeUtils.escapeHtml4(product.getName()) %></td>
				<th>번호</th>
				<td><%=product.getNo() %></td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td><%=product.getCategory().getName() %></td>
				<th>제조회사</th>
				<td><%=product.getCompany().getName() %></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><%=Utils.toCurrency(product.getPrice()) %> 원</td>
				<th>할인가격</th>
				<td><%=Utils.toCurrency(product.getDiscountPrice()) %> 원</td>
			</tr>
			<tr>
				<th>재고수량</th>
				<td><%=product.getStock() %></td>
				<th>상태</th>
				<td><%=product.getStatus().getName() %></td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td><%=product.getCreatedDate() %></td>
				<th>수정일자</th>
				<td><%=Utils.nullToBlank(product.getUpdatedDate()) %></td>
			</tr>
			<tr>
				<th>설명</th>
				<td colspan="3"><%=product.getHtmlDescription() %></td>
			</tr>
			<tr>
				<th>추가혜택</th>
				<td colspan="3">
<%
		for(Benefit b : benefits) {
%>
					<span class="badge bg-success"><%=b.getName() %></span>				
<%
		}
%>
				</td>
			</tr>
<%
	}
%>
		</tbody>
	</table>
	<div class="text-end">
		<a href="modify-form.jsp?no=<%=product.getNo() %>" class="btn btn-warning">수정</a>
		<a href="delete.jsp?no<%=product.getNo() %>" class="btn btn-danger">삭제</a>
		<a href="home.jsp" class="btn btn-primary">목록</a>
	</div>
</div>
</body>
</html>