package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.ConnectionUtils;
import vo.User;

public class UserDao {

	/**
	 * 아이디를 전달받아서 사용자정보를 조회해서 반환한다.
	 * @param id 조회할 사용자 아이디
	 * @return 사용자정보, null이 반환될 수 있다.
	 * @throws SQLException
	 */
	public User getUserById(String id) throws SQLException {
		String sql = """
			select *
			from store_users
			where user_id = ?
		""";
		
		User user = null;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			user = new User();
			user.setNo(rs.getInt("USER_NO"));
			user.setId(rs.getString("USER_ID"));
			user.setPassword(rs.getString("USER_PASSWORD"));
			user.setName(rs.getString("USER_NAME"));
			user.setEmail(rs.getString("USER_EMAIL"));
			user.setDisabled(rs.getString("USER_DISABLED"));
			user.setCreatedDate(rs.getDate("USER_CREATED_DATE"));
			user.setUpdatedDate(rs.getDate("USER_UPDATED_DATE"));
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return user;
	}
	
	/**
	 * 신규 회원정보를 전달받아서 데이터베이스에 저장시킨다.
	 * @param user 신규 사용자 정보
	 * @throws SQLException
	 */
	public void insertUser(User user) throws SQLException {
		String sql = """
			insert into store_users
			(user_no
			, user_id
			, user_password
			, user_name
			, user_email)
			values
			(store_users_seq.nextval, ?, ?, ?, ?)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, user.getId());
		pstmt.setString(2, user.getPassword());
		pstmt.setString(3, user.getName());
		pstmt.setString(4, user.getEmail());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
}