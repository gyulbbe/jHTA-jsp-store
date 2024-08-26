package web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;

import org.apache.commons.io.IOUtils;

import dao.QnaDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import util.Utils;
import vo.Category;
import vo.Qna;
import vo.User;

/*
 * @WebServlet
 * 	- 이 클래스가 HTTP요청을 처리하는 서블릿 클래스임을 나타내는 어노테이션
 *  - urlPatterns
 *     이 서블릿 클래스와 매핑되는 URL패턴을 지정한다.
 *     이 서블릿 클래스는 http://localhost/store/qna/insert 요청과 매핑된다.
 *     즉, 위의 URL요청이 서버로 보내지면 실행되는 서블릿 클래스다.
 *     
 * @MultipartConfig
 * 	- 이 클래스가 multipart/form-data 요청을 처리할 수 있는 서블릿 클래스임을 나타내는 어노테이션이다.
 *  - 멀티파트 요청처리와 관련된 설정정보를 저장할 수 있는 어노테이션이다.
 *  - @MultipartConfig(fileSizeThreshold=xxx,
 *  					maxFileSize=xxx,
 *  					maxRequestSize=xxx,
 *  					location=xxx)
 *  
 *  	fileSizeThreshold: 파일을 임시 디렉토리에 저장할 기준 크기
 *  	maxFileSize: 한번에 업로드 할 수 있는 파일 크기
 *  	maxRequestSize: 전체 요청메시지의 크기
 *  	location: 임시파일을 저장할 경로
 */
@WebServlet(urlPatterns = "/qna/insert")
@MultipartConfig
public class QnaInsertServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("QnaInsertServlet의 service(reuquest, response) 실행됨.");
		
		HttpSession session = request.getSession();
		if (session.getAttribute("USERNO") == null) {
			response.sendRedirect("../user/login-form.jsp?deny");
			return;
		}
		
		// 세션에서 사용자 번호 수집하기
		int userNo = (Integer) session.getAttribute("USERNO");
		
		// 입력필드의 값 수집하기
		int catNo = Utils.toInt(request.getParameter("catNo"));
		String title = request.getParameter("title");
		String question = request.getParameter("question");
		
		// 업로드된 첨부파일 정보 수집하기
		Part part = request.getPart("upfile");
		String filename = System.currentTimeMillis() + part.getSubmittedFileName();
		String contentType = part.getContentType();
		long size = part.getSize();
		InputStream inputStream = part.getInputStream();
		
		System.out.println("카테고리 번호: " + catNo);
		System.out.println("제목: " + title);
		System.out.println("질문내용: " + question);
		System.out.println("첨부파일 이름: " + filename);
		System.out.println("첨부파일 컨텐츠 타입: " + contentType);
		System.out.println("첨부파일 사이즈: " + size);
		
		String directory = "C:\\Users\\jhta\\git\\jHTA-jsp-store\\store\\src\\main\\webapp\\resources";
		OutputStream outputStream 
			= new FileOutputStream(new File(directory, filename));
		
		IOUtils.copy(inputStream, outputStream);
		
		Qna qna = new Qna();
		qna.setTitle(title);
		qna.setQuestion(question);
		qna.setCategory(new Category(catNo));
		qna.setUserNo(userNo);
		qna.setFilename(filename);
		
		QnaDao qnaDao = new QnaDao();
		try {
			qnaDao.insertQna(qna);
		} catch (SQLException e) {
			throw new ServletException(e);
		}
		
		response.sendRedirect("list.jsp");
	}
}
