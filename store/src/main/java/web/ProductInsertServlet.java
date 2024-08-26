package web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.io.IOUtils;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vo.Category;
import vo.Company;
import vo.Product;
import vo.ProductBenefit;
import vo.Status;

@WebServlet(urlPatterns = "/admin/product/insert")
@MultipartConfig
public class ProductInsertServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String directory = "C:\\Users\\jhta\\git\\jHTA-jsp-store\\store\\src\\main\\webapp\\resources\\photo";

		try {
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
			
			// 업로드된 첨부파일 분석하기 처리하기
			Part part = request.getPart("photofile");
			String filename = part.getSubmittedFileName();
			
			// 업로드된 첨부파일(상품사진)을 지정된 폴더에 저장시키기
			InputStream in = part.getInputStream();
			OutputStream out = new FileOutputStream(new File(directory, filename));
			
			IOUtils.copy(in, out);
			
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
			product.setFilename(filename);

			// 3. ProductDao객체를 생성하기
			ProductDao productDao = new ProductDao();
			// 4. 상품 일련번호를 조회한다.
			int productNo = productDao.getSequence();
			// 5. Product객체에 상품일련번호를 담는다.
			product.setNo(productNo);
			
			// 6. 새 상품정보를 저장하기 -> 부모테이블에 먼저 담아줘야 함. 순서도 중요함
			productDao.insertProduct(product);

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
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}