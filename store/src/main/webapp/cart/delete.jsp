<%@page import="vo.Cart"%>
<%@page import="dao.CartDao"%>
<%@page import="util.Utils"%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%
	if (session.getAttribute("USERNO") == null) {
		response.sendRedirect("../user/login-form.jsp?deny");
		return;
	}

	String[] cartNoArr = request.getParameterValues("itemNo");
	CartDao cartDao = new CartDao();
	
	for (String cNo : cartNoArr) {
		int cartNo = Utils.toInt(cNo);
		cartDao.deleteCart(cartNo);
	}
	
	response.sendRedirect("list.jsp");
%>