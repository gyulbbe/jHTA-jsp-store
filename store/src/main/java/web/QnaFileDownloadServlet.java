package web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.SQLException;

import org.apache.commons.io.IOUtils;

import dao.QnaDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Utils;
import vo.Qna;

// 절대경로 상대경로 상관없이 /를 붙이지 않으면 톰캣이 읽지 못함
@WebServlet(urlPatterns = "/qna/download")
public class QnaFileDownloadServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 요청 URL
		 * 	http://localhost/store/qna/download?no=41
		 * 쿼리스트링
		 * 	no=41
		 * 
		 * 요청파라미터
		 * 	name		value
		 * ------------------------------
		 * "no"			"41"	질문번호
		 * 
		 * 요청처리 절차
		 * 	1. 요청파라미터 값을 조회한다. - 질문번호 조회
		 * 	2. 질문번호에 해당하는 질문 상세정보를 조회한다.
		 * 	3. 질문상세정보에서 파일명을 조회한다.
		 * 	4. 첨부파일이 저장된 디렉토리와 파일명을 이용해서 해당위치에 저장된 파일을 읽어오는 스트림을 생성한다.
		 * 	5. 응답객체에서 바이너리 데이터를 브라우저로 보내는 쓰기 스트림을 획득한다.
		 * 	6. IOUtils의 copy() 메소드를 이용해서 읽기스트림으로 읽어온 파일데이터를 쓰기 스트림으로 내보낸다.
		 * 		즉, 브라우저로 파일정보를 응답으로 보낸다.
		 */
		int qnaNo = Utils.toInt(request.getParameter("no"));
		
		try {
			QnaDao qnaDao = new QnaDao();
			Qna qna = qnaDao.getQnaByNo(qnaNo);
			
			String directory = "C:\\Users\\jhta\\git\\jHTA-jsp-store\\store\\src\\main\\webapp\\resources";
			String filename = qna.getFilename();

			// 웹서버에 저장된 파일을 읽어오는 스트림 생성하기
			InputStream in = new FileInputStream(new File(directory, filename));
			System.out.println("인코딩 전 파일명 ---->" + filename);
			filename = URLEncoder.encode(filename, "utf-8");
			System.out.println("인코딩 후 파일명 ---->" + filename);
			
			// 응답메시지에 다운로드되는 파일의 부가적인 정보 설정하기
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
			
			// 브라우저로 내려보는 출력스트림 획득하기
			OutputStream out = response.getOutputStream();
			
			IOUtils.copy(in, out);
			
		} catch (SQLException e) {
			throw new ServletException(e);
		}
	}
}