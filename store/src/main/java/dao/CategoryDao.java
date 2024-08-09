package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Category;

public class CategoryDao {

	/**
	 * 모든 카테고리 정보를 조회해서 반환한다.
	 * @return 모든 카테고리 목록
	 * @throws SQLException
	 */
	public List<Category> getAllCategories() throws SQLException {
		String sql = """
			select *
			from store_product_categories
			order by product_category_no asc
		""";
		
		List<Category> categories = new ArrayList<>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setNo(rs.getInt("PRODUCT_CATEGORY_NO"));
			category.setName(rs.getString("PRODUCT_CATEGORY_NAME"));
			
			categories.add(category);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return categories;
	}
}
