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
	<h1>새 상품 입력폼</h1>
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
%>
	
	<form class="border bg-light p-3" method="post" action="insert"
		enctype="multipart/form-data">
		<div class="mb-3">
			<label class="form-label">상품 카테고리</label>
			<select class="form-select" name="catNo">
				<option value="" selected disabled> 카테고리를 선택하세요</option>
<%
	for (Category c : categories) {
%>
				<option value="<%=c.getNo() %>"> <%=c.getName() %></option>
<%
	}
%>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">상품 이름</label>
			<input type="text" class="form-control" name="name" />
		</div>
		<div class="mb-3">
			<label class="form-label">상품 가격</label>
			<input type="text" class="form-control" name="price" />
		</div>
		<div class="mb-3">
			<label class="form-label">상품 할인가격</label>
			<input type="text" class="form-control" name="discountPrice" />
		</div>
		<div class="mb-3">
			<label class="form-label">입고 수량</label>
			<input type="text" class="form-control" name="stock" />
		</div>
		<div class="mb-3">
			<label class="form-label">상품 제조회사</label>
			<select class="form-select" name="companyNo">
				<option value="" selected disabled> 제조회사를 선택하세요</option>
<%
	for (Company c : companies) {
%>
				<option value="<%=c.getNo() %>"> <%=c.getName() %></option>
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
					<input class="form-check-input" type="radio" name="statusNo" value="<%=s.getNo() %>">
					<label class="form-check-label"><%=s.getName() %></label>
				</div>
<%
	}
%>
			</div>
		</div>
		<div class="mb-3">
			<label class="form-label">상품 설명</label>
			<textarea class="form-control" rows="5" name="description"></textarea>
		</div>
		<div class="mb-3">
			<label class="form-label">상품 사진</label>
			<input type="file" class="form-control" name="photofile">
		</div>
		<div class="mb-3">
			<label class="form-label">추가 혜택</label>
			<div>
<%
	for (Benefit b : benefits) {
%>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="checkbox" name="benefitNo" value="<%=b.getNo() %>">
					<label class="form-check-label"><%=b.getName() %></label>
				</div>
<%
	}
%>
			</div>
		</div>
		<div class="text-end">
			<a href="home.jsp" class="btn btn-secendary">취소</a>
			<button type="submit" class="btn btn-primary">등록</button>
		</div>
	</form>
</div>
</body>
</html>