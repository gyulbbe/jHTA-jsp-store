<%@page import="vo.ProductBenefit"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Benefit"%>
<%@page import="vo.Status"%>
<%@page import="vo.Company"%>
<%@page import="vo.Category"%>
<%@page import="vo.Product"%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%--
	요청 URL
		http://localhost/store/admin/product/insert.jsp
	요청 URI
		/store/product/insert.jsp
	폼 데이터
		catNo=1000
		&name=LG Gram 노트북 14인치
		&price=2000000
		&discountPrice=1800000
		&stock=5
		&companyNo=1006
		&statusNo=10
		&description=LG Gram 초경량 노트북입니다.
		&benefitNo=10
		&benefitNo=13
		
	요청파라미터 정보
		-------------------------------------------------------
		no					value
		-------------------------------------------------------
		catNo				1000
		name				LG Gram 노트북 14인치
		price				2000000
		discountPrice		1800000
		stock				5
		companyNo			1006
		statusNo			10
		description			LG Gram 초경량 노트북입니다.
		benefitNo			10
		benefitNo			13
 --%>
<%
	// 1. 항상 제일 먼저 해야 할 것은 요청파라미터 정보가 있는지 없는지 조회하는 것이다.
	int catNo = Integer.parseInt(request.getParameter("catNo"));
	String name = request.getParameter("name");
	int price = Integer.parseInt(request.getParameter("price"));
	int discountPrice = Integer.parseInt(request.getParameter("discountPrice"));
	int stock = Integer.parseInt(request.getParameter("stock"));
	int companyNo = Integer.parseInt(request.getParameter("companyNo"));
	int statusNo = Integer.parseInt(request.getParameter("statusNo"));
	String description = request.getParameter("description");
	// 같은 변수 이름으로 값이 두개 올 수 있는 것은 String배열타입과 getParameterValues를 사용하자
	String[] benefitNoArr = request.getParameterValues("benefitNo");
	
	// 2. Product객체를 생성해서 요청파라미터 정보를 담는다.
	Product product = new Product();
	product.setCategory(new Category(catNo));
	product.setName(name);
	product.setPrice(price);
	product.setDiscountPrice(discountPrice);
	product.setStock(stock);
	product.setCompany(new Company(companyNo));
	product.setStatus(new Status(statusNo));
	product.setDescription(description);

	// 3. ProductDao객체를 생성하기
	ProductDao productDao = new ProductDao();
	// 4. 상품 일련번호를 조회한다.
	int productNo = productDao.getSequence();
	// 5. Product객체에 상품일련번호를 담는다.
	product.setNo(productNo);
	
	// 6. 새 상품정보를 저장하기 -> 부모테이블에 먼저 담아줘야 함. 순서도 중요함
	productDao.insertProduct(product);
	
	// 3. 추가 혜택정보를 Benefit객체에 저장하기
	// {"10", "20"} -> Benefit객체, Benefit객체 -> ArrayList객체에 저장
//	List<Benefit> benefits = new ArrayList<>();
//	for (String value : benefitNoArr) {
//		int benefitNo = Integer.parseInt(value);
//		Benefit benefit = new Benefit(benefitNo);
		
//		benefits.add(benefit);
//	}

	// 7. 체크된 추가 혜택 정보를 저장시킨다.
	for (String value : benefitNoArr) {
		int benefitNo = Integer.parseInt(value);
		
		ProductBenefit productBenefit = new ProductBenefit();
		productBenefit.setProductNo(productNo);
		productBenefit.setBenefitNo(benefitNo);
		
		productDao.insertProductBenefit(productBenefit);
	}
	
	// 8. home.jsp 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("home.jsp");
%>