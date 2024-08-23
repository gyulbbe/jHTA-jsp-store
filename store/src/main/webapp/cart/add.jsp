<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Cart"%>
<%@page import="dao.CartDao"%>
<%@page import="util.Utils"%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%
	if (session.getAttribute("USERNO") == null) {
		response.sendRedirect("../user/login-form.jsp?deny");
		return;
	}

	int productNo = Utils.toInt(request.getParameter("productNo"));
	int userNo = (Integer) session.getAttribute("USERNO");
	int amount = Utils.toInt(request.getParameter("amount"));
	
	ProductDao productDao = new ProductDao();
	Product product = productDao.getProductByNo(productNo);
	
	int price = product.getPrice();
	int discountPrice = product.getDiscountPrice();
	int gap = price - discountPrice;
	int itemPrice = amount * discountPrice;
	
	CartDao cartDao = new CartDao();
	Cart cart = new Cart();
	cart.setUserNo(userNo);
	cart.setPrice(itemPrice);
	cart.setProduct(product);
	cart.setAmount(amount);
	
	cartDao.insertCart(cart);
	
	response.sendRedirect("list.jsp");
%>