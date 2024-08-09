package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Company;

public class CompanyDao {

	/**
	 * 모든 제조사를 조회해서 반환한다.
	 * @return 모든 제조회사 목록
	 * @throws SQLException
	 */
	public List<Company> getAllCompanies() throws SQLException {
		String sql = """
			select *
			from store_product_companies
			order by PRODUCT_COMPANY_NO asc
		""";
		
		List<Company> companies = new ArrayList<Company> ();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			Company company = new Company();
			company.setNo(rs.getInt("PRODUCT_COMPANY_NO"));
			company.setName(rs.getString("PRODUCT_COMPANY_NAME"));
			company.setTel(rs.getString("PRODUCT_COMPANY_TEL"));
			
			companies.add(company);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return companies;
	}
}
