<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.Utils"%>
<%@page import="vo.Benefit"%>
<%@page import="vo.Status"%>
<%@page import="vo.Company"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.BenefitDao"%>
<%@page import="dao.StatusDao"%>
<%@page import="dao.CompanyDao"%>
<%@page import="dao.CategoryDao"%>
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
<div class="container mt-4 mb-5">
<%--
	요청 URL
		http://localhost/store/admin/product/modify-form.jsp?no=xxxx
	요청 URI
		/store/admin/product/modify-form.jsp
	쿼리스트링
		no=xxx
		
	요청파라미터 정보
		name		value
		--------------------------------
		"no"		"xxx"		상품정보
		--------------------------------
		
	구현내용
		1. 입력폼 생성에 필요한 정보를 전부 조회한다.
			* 카테고리정보, 제조회사정보, 상태정보, 혜택정보를 조회한다.
		2. 1번에서 조회한 정보로
			select박스의 option태그, radio, checkbox를 생성한다.
		3. 요청파라미터 정보에서 수정할 상품번호를 조회한다.
		4. 상품번호에 해당하는 상품정보를 조회한다.
			상품정보 = 상품정보 + (카테고리정보, 제조회사, 상태, 추가혜택)
		5. 4번에서 조회한 상품정보를 입력필드에 표현한다.
 --%>
 
	<h1>상품정보 수정폼</h1>
<%
	// 카테고리, 제조회사, 상품상태, 추가혜택정보를 조회한다.
	CategoryDao categoryDao = new CategoryDao();
	CompanyDao companyDao = new CompanyDao();
	StatusDao statusDao = new StatusDao();
	BenefitDao benefitDao = new BenefitDao();
	
	List<Category> categories = categoryDao.getAllCategories();
	List<Company> companies = companyDao.getAllCompanies();
	List<Status> statusList = statusDao.getAllStatus();
	List<Benefit> benefits = benefitDao.getAllBenefits();
	
	// 1. 요청파라미터정보를 조회한다.
	int productNo = Utils.toInt(request.getParameter("no"));
	
	// 2. 요청파라미터로 전달받은 상품번호에 해당하는 상품정보를 조회한다.
	ProductDao productDao = new ProductDao();
	Product product = productDao.getProductByNo(productNo);
	List<Benefit> productBenefits = productDao.getBenefitByProductNo(productNo);
	
	product.setBenefits(productBenefits);
%>
	
	<form class="border bg-light p-3" method="post" action="update.jsp?no=<%=productNo %>">
		<div class="mb-3">
			<label class="form-label">상품 카테고리</label>
			<select class="form-select" name="catNo">
				<option value="" selected disabled> 카테고리를 선택하세요</option>
<%
	for (Category c : categories) {
%>
				<option value="<%=c.getNo() %>"<%=product.hasCategory(c.getNo()) ? "selected" : "" %>> <%=c.getName() %></option>
<%
	}
%>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">상품 이름</label>
			<input type="text" class="form-control" name="name" value="<%=product.getName() %>" />
		</div>
		<div class="mb-3">
			<label class="form-label">상품 가격</label>
			<input type="text" class="form-control" name="price" value="<%=product.getPrice() %>" />
		</div>
		<div class="mb-3">
			<label class="form-label">상품 할인가격</label>
			<input type="text" class="form-control" name="discountPrice" value="<%=product.getDiscountPrice() %>" />
		</div>
		<div class="mb-3">
			<label class="form-label">입고 수량</label>
			<input type="text" class="form-control" name="stock" value="<%=product.getStock() %>" />
		</div>
		<div class="mb-3">
			<label class="form-label">상품 제조회사</label>
			<select class="form-select" name="companyNo">
				<option value="<%=product.getCompany().getName()%>" selected disabled> 제조회사를 선택하세요</option>
<%
	for (Company c : companies) {
%>
				<option value="<%=c.getNo() %>"<%=product.hasCompany(c.getNo()) ? "selected" : "" %>><%=c.getName() %></option>
<%
	}
%>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">상품 상태</label>
			<div>
<%
	for (Status s : statusList) {
%>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="statusNo" value="<%=s.getNo() %>" <%=product.hasStatus(s.getNo()) ? "checked" : "" %>>
					<label class="form-check-label"><%=s.getName() %></label>
				</div>
<%
	}
%>
			</div>
		</div>
		<div class="mb-3">
			<label class="form-label">상품 설명</label>
			<textarea class="form-control" rows="5" name="description"><%=product.getDescription() %></textarea>
		</div>
		<div class="mb-3">
			<label class="form-label">추가 혜택</label>
			<div>
<%
	for (Benefit b : benefits) {
%>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="checkbox" name="benefitNo" value="<%=b.getNo() %>"<%=product.hasBenefit(b.getNo()) ? "checked" : "" %>>
					<label class="form-check-label"><%=b.getName() %></label>
				</div>
<%
	}
%>
			</div>
		</div>
		<div class="text-end">
			<a href="home.jsp" class="btn btn-secendary">취소</a>
			<button type="submit" class="btn btn-primary">수정</button>
		</div>
	</form>
</div>
</body>
</html>