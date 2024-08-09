package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.ConnectionUtils;
import vo.Product;
import vo.ProductBenefit;

public class ProductDao {

	/**
	 * 새 상품들고에 필요한 상품일련번호를 조회한다.
	 * @return 새 상품일련번호 
	 * @throws SQLException
	 */
	public int getSequence() throws SQLException {
		String sql = """
			select STORE_PRODUCTS_SEQ.nextval
			from dual
		""";
		
		int productNo = 0;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			// 첫번째꺼를 가져온다.
			productNo = rs.getInt(1);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return productNo;
	}
	
	public void insertProduct(Product product) throws SQLException {
		String sql = """
			insert into STORE_PRODUCTS
			(PRODUCT_NO
			, PRODUCT_NAME
			, PRODUCT_PRICE
			, PRODUCT_DISCOUNT_PRICE
			, PRODUCT_STOCK
			, PRODUCT_DESCRIPTION
			, PRODUCT_CATEGORY_NO
			, PRODUCT_COMPANY_NO
			, PRODUCT_STATUS_NO)
			values
			(?, ?, ?, ?, ?, ?, ?, ?, ?)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, product.getNo());
		pstmt.setString(2, product.getName());
		pstmt.setInt(3, product.getPrice());
		pstmt.setInt(4, product.getDiscountPrice());
		pstmt.setInt(5, product.getStock());
		pstmt.setString(6, product.getDescription());
		pstmt.setInt(7, product.getCategory().getNo());
		pstmt.setInt(8, product.getCompany().getNo());
		pstmt.setInt(9, product.getStatus().getNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	public void insertProductBenefit(ProductBenefit productBenefit) throws SQLException {
		String sql = """
			insert into store_product_benefits
			(PRODUCT_NO
			, BENEFIT_NO)
			values
			(?, ?)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, productBenefit.getProductNo());
		pstmt.setInt(2, productBenefit.getBenefitNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
}
