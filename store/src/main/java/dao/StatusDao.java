package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Status;

public class StatusDao {

	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<Status> getAllStatus() throws SQLException {
		String sql = """
			select *
			from STORE_PRODUCT_STATUS
			order by PRODUCT_STATUS_NO
		""";
		
		List<Status> list = new ArrayList<>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			Status status = new Status();
			status.setNo(rs.getInt("PRODUCT_STATUS_NO"));
			status.setName(rs.getString("PRODUCT_STATUS_NAME"));
			
			list.add(status);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return list;
	}
}
