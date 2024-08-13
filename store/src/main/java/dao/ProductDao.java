package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Benefit;
import vo.Category;
import vo.Company;
import vo.Product;
import vo.ProductBenefit;
import vo.Status;

public class ProductDao {

	public int getTotalRows() throws SQLException {
		String sql = """
			select count(*)
			from store_products
		""";
		int totalRows = 0;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			totalRows = rs.getInt(1);
		}
		
		pstmt.close();
		con.close();
		
		return totalRows;
	}
	
	public List<Product> getProducts(int begin, int end) throws SQLException {
		String sql = """
			select *
			from (
				select row_number() over (order by product_no desc) rownumber
						, p.product_no
						, p.product_name
						, p.product_price
						, p.product_discount_price
						, s.product_status_no
						, s.product_status_name
				from store_products p, store_product_status s
				where p.product_status_no = s.product_status_no
				)
			where rownumber between ? and ?
		""";
	
	List<Product> products = new ArrayList<Product>();
	
	Connection con = ConnectionUtils.getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, begin);
	pstmt.setInt(2, end);
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()) {
		Product product = new Product();
		product.setNo(rs.getInt("product_no"));
		product.setName(rs.getString("product_name"));
		product.setPrice(rs.getInt("product_price"));
		product.setDiscountPrice(rs.getInt("product_discount_price"));
		
		Status status = new Status();
		status.setNo(rs.getInt("product_status_no"));
		status.setName(rs.getString("product_status_name"));
		
		product.setStatus(status);
		
		products.add(product);
	}
	rs.close();
	pstmt.close();
	con.close();
	
	return products;
	}
	
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
	
	public Product getProductByNo(int productNo) throws SQLException {
		String sql = """
			SELECT p.product_no
			    , p.product_name
			    , p.product_price
			    , p.product_discount_price
			    , p.product_stock
			    , p.product_description
			    , p.product_created_date
			    , p.product_updated_date
			    , ca.product_category_no
			    , ca.product_category_name
			    , co.product_company_no
			    , co.product_company_name
			    , st.product_status_no
			    , st.product_status_name
			FROM store_products p
			    , store_product_categories ca
			    , store_product_companies co
			    , store_product_status st
			where p.product_no = ?
			    and p.product_category_no = ca.product_category_no
			    and p.product_company_no = co.product_company_no
			    and p.product_status_no = st.product_status_no
		""";
		
		Product product = null;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDiscountPrice(rs.getInt("product_discount_price"));
			product.setStock(rs.getInt("product_stock"));
			product.setDescription(rs.getString("product_description"));
			product.setCreatedDate(rs.getDate("product_created_date"));
			product.setUpdatedDate(rs.getDate("product_updated_date"));
			
			Category category = new Category();
			category.setNo(rs.getInt("product_category_no"));
			category.setName(rs.getString("product_category_name"));
			product.setCategory(category);
			
			Company company = new Company();
			company.setNo(rs.getInt("product_company_no"));
			company.setName(rs.getString("product_company_name"));
			product.setCompany(company);
			
			Status status = new Status();
			status.setNo(rs.getInt("product_status_no"));
			status.setName(rs.getString("product_status_name"));
			product.setStatus(status);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return product;
	}
	
	public List<Benefit> getBenefitByProductNo(int productNo) throws SQLException {
		String sql = """
			select b.benefit_no
			    , b.benefit_name
			from store_product_benefits pb, store_benefits b
			where pb.product_no = ?
			and pb.benefit_no = b.benefit_no
		""";
		
		List<Benefit> benefits = new ArrayList<Benefit>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Benefit benefit = new Benefit();
			benefit.setNo(rs.getInt("benefit_no"));
			benefit.setName(rs.getString("benefit_name"));
			
			benefits.add(benefit);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return benefits;
	}
}
