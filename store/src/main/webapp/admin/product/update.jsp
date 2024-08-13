<%@page import="vo.ProductBenefit"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Status"%>
<%@page import="vo.Company"%>
<%@page import="vo.Category"%>
<%@page import="vo.Product"%>
<%@page import="util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
   요청 URL
      http://localhost/store/admin/product/update.jsp?no=5201
   요청 URI
      /store/admin/product/update.jsp
   쿼리스트링
      no=5201
   form data
      catNo=1000
      &name=LG Gram 노트북 14인치
      &price=2000000
      &discountPrice=1800000
      &stock=5
      &companyNo=1001
      &statusNo=10
      &description=LG Gram 초경량 노트북입니다.
      &benefitNo=10
      &benefitNo=13
      
   요청파라미터 정보
   -----------------------------------------------
   name         value
   -----------------------------------------------
   no              5201
   catNo         1000
   name         LG Gram 노트북 14인치
   price         2000000
   discountPrice   1800000
   stock         5
   companyNo      1001
   statusNo      10
   description      LG Gram 초경량 노트북입니다.
   benefitNo      10
   benefitNo      13
   -----------------------------------------------
   
   처리내용
   	1. 요청파라미터값을 조회한다.
   	2. 상품번호로 데이터베이스에서 기존 상품정보를 조회한다.
   	3. 2번에서 조회한 Product객체에 요청파라미터로 조회된 값을 대입한다.
   	4. 변경된 정보가 대입된 Product객체를 Dao에 전달해서 테이블에 반영시킨다.
--%>
<%
	//1. 항상 제일 먼저 해야 할 것은 요청파라미터 정보가 있는지 없는지 조회하는 것이다.
	int productNo = Utils.toInt(request.getParameter("no"));
	int catNo = Utils.toInt(request.getParameter("catNo"));
	String name = request.getParameter("name");
	int price = Utils.toInt(request.getParameter("price"));
	int discountPrice = Utils.toInt(request.getParameter("discountPrice"));
	int stock = Utils.toInt(request.getParameter("stock"));
	int companyNo = Utils.toInt(request.getParameter("companyNo"));
	int statusNo = Utils.toInt(request.getParameter("statusNo"));
	String description = request.getParameter("description");
	String[] benefitNoArr = request.getParameterValues("benefitNo");
	
	// 2. 상품번호로 상품정보를 조회한다.
	ProductDao productDao = new ProductDao();
	Product product = productDao.getProductByNo(productNo);
	
	// 3. 조회된 상품정보에 요청파라미터로 조회한 값을 대입해서 정보를 수정한다.
	product.setNo(productNo);
	product.setCategory(new Category(catNo));
	product.setName(name);
	product.setPrice(price);
	product.setDiscountPrice(discountPrice);
	product.setStock(stock);
	product.setCompany(new Company(companyNo));
	product.setStatus(new Status(statusNo));
	product.setDescription(description);
	
	// 4. 수정된 정보가 반영된 Product객체를 ProductDao객체의 updateProduct() 메소드로 전달해서 데이터베이스에 반영시킨다.
	productDao.updateProduct(product);
	
	// 5. 해당 상품의 추가혜택정보를 전부 삭제한다.
	productDao.deleteBenefitsByProductNo(productNo);
	
	// 6. 수정폼에서 새로 체크한 추가혜택정보를 저장한다.
	if (benefitNoArr != null) {
		for (String value : benefitNoArr) {
			int benefitNo = Utils.toInt(value);
			
			ProductBenefit productBenefit = new ProductBenefit();
			productBenefit.setProductNo(productNo);
			productBenefit.setBenefitNo(benefitNo);
			
			productDao.insertProductBenefit(productBenefit);
		}
	}
	
	// 7. detail.jsp를 재요청하는 URL을 응답으로 보내기
	response.sendRedirect("detail.jsp?no=" + productNo);
%>