<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="util.Utils"%>
<%@page import="dao.QnaDao"%>
<%@page import="vo.Qna"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int userNo = (Integer) session.getAttribute("USERNO");
	int catNo = Utils.toInt(request.getParameter("catNo"));
	String title = request.getParameter("title");
	String question = request.getParameter("question");
	
	System.out.println("카테고리 번호: " + catNo);
	System.out.println("제목: " + title);
	System.out.println("질문내용: " + question);
	
	Qna qna = new Qna();
	qna.setUserNo(userNo);
	qna.setCatNo(catNo);
	qna.setTitle(title);
	qna.setQuestion(question);
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.insertQna(qna);
	
	response.sendRedirect("list.jsp");
%>