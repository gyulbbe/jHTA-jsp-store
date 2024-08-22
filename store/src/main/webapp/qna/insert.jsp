<%@page import="dao.QnaDao"%>
<%@page import="vo.Qna"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int userNo = (Integer) session.getAttribute("USERNO");
	int catNo = Integer.parseInt(request.getParameter("catNo"));
	String title = request.getParameter("title");
	String question = request.getParameter("question");
	
	Qna qna = new Qna();
	qna.setUserNo(userNo);
	qna.setCatNo(catNo);
	qna.setTitle(title);
	qna.setQuestion(question);
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.insertQna(qna);
	
	response.sendRedirect("list.jsp");
%>