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
	
	CartDao cartDao = new CartDao();
	// 사용자번호와 상품번호로 장바구니 아이템 정보를 조회한다.
	Cart savedCartItem = cartDao.getCartItemByUserNoAndProductNo(userNo, productNo);
	// 저장된 장바구니 아이템 정보가 존재한다면 해당 상품은 이미 장바구니에 등록된 상품이므로수량만 증가시킨다.
	if (savedCartItem != null) {
		savedCartItem.setAmount(savedCartItem.getAmount() + amount);
		cartDao.updateCartItem(savedCartItem);
	} else {
		// 상품번호로 상품 상세정보를 조회한다.
		ProductDao productDao = new ProductDao();
		Product product = productDao.getProductByNo(productNo);
		
		int price = product.getPrice();
		int discountPrice = product.getDiscountPrice();
		int gap = price - discountPrice;
		int itemPrice = amount * discountPrice;

		Cart cart = new Cart();
		cart.setUserNo(userNo);
		cart.setPrice(itemPrice);
		cart.setProduct(product);
		cart.setAmount(amount);
		
		cartDao.insertCart(cart);
	}
	
	response.sendRedirect("list.jsp");
%>