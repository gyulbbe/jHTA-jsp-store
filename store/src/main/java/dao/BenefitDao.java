package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Benefit;

public class BenefitDao {

	/**
	 * 모든 혜택정보를 조회해서 반환한다.
	 * @return 모든 혜택정보 목록
	 * @throws SQLException
	 */
	public List<Benefit> getAllBenefits() throws SQLException {
		String sql = """
			select *
			from store_benefits
			order by benefit_no	
		""";
		
		List<Benefit> benefits = new ArrayList<Benefit>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
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
