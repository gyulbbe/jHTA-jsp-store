package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Cart;
import vo.Product;

public class CartDao {
	
	public void deleteCart(int cartNo) throws SQLException {
		String sql = """
			delete from STORE_CART_ITEMS
			where ITEM_NO = ?
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, cartNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}

	public void insertCart(Cart cart) throws SQLException {
		String sql = """
			insert into STORE_CART_ITEMS
			(ITEM_NO, USER_NO, PRODUCT_NO, ITEM_AMOUNT, ITEM_PRICE, ITEM_CREATED_DATE)
			values
			(STORE_CARTS_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, cart.getUserNo());
		pstmt.setInt(2, cart.getProduct().getNo());
		pstmt.setInt(3, cart.getAmount());
		pstmt.setInt(4, cart.getPrice());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	public List<Cart> getAllCartByUserNo(int userNo) throws SQLException {
		String sql = """
			select p.PRODUCT_NO
					, p.PRODUCT_NAME
					, p.PRODUCT_STOCK
					, p.PRODUCT_DISCOUNT_PRICE
					, p.PRODUCT_PRICE
					, c.ITEM_NO
					, c.ITEM_AMOUNT
					, c.ITEM_PRICE
					, c.ITEM_CREATED_DATE
					, c.ITEM_UPDATED_DATE
			from STORE_CART_ITEMS c, STORE_PRODUCTS p
			where USER_NO = ?
			and p.PRODUCT_NO = c.PRODUCT_NO
		""";
		List<Cart> carts = new ArrayList<>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Cart cart = new Cart();
			cart.setNo(rs.getInt("ITEM_NO"));
			cart.setAmount(rs.getInt("ITEM_AMOUNT"));
			cart.setPrice(rs.getInt("ITEM_PRICE"));
			cart.setCreatedDate(rs.getDate("ITEM_CREATED_DATE"));
			cart.setUpdatedDate(rs.getDate("ITEM_UPDATED_DATE"));
			
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setStock(rs.getInt("PRODUCT_STOCK"));
			product.setDiscountPrice(rs.getInt("PRODUCT_DISCOUNT_PRICE"));
			product.setPrice(rs.getInt("PRODUCT_PRICE"));
			cart.setProduct(product);
			
			carts.add(cart);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return carts;
	}
}
