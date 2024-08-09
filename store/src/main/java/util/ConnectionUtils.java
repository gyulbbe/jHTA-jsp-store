package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * JDBC 드라이버를 메모리에 로딩시키고, 
 * 데이터베이스와 연결된 Connection 객체를 제공하는 클래스다.
 */
public class ConnectionUtils {

	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String username = "hta";
	private static final String password = "zxcv1234";
	
	static {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		}
	}
	
	/**
	 * 데이터베이스와 연결된 Connection객체를 반환한다.
	 * @return Connection 객체
	 * @throws SQLException
	 */
	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(url, username, password);
	}
}
