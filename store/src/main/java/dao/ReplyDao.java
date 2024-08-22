package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Board;
import vo.Reply;
import vo.User;

public class ReplyDao {
	
	public Reply getReplyByNo(int replyNo) throws SQLException {
		String sql = """
			select *
			from STORE_BOARD_REPLYES
			where reply_no = ?
		""";
		Reply reply = null;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, replyNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			reply = new Reply();
			reply.setNo(rs.getInt("REPLY_NO"));
			reply.setContent(rs.getString("REPLY_CONTENT"));
			reply.setCreatedDate(rs.getDate("REPLY_CREATED_DATE"));
			reply.setUpdatedDate(rs.getDate("REPLY_UPDATED_DATE"));
			
			Board board = new Board();
			board.setNo(rs.getInt("BOARD_NO"));
			reply.setBoard(board);
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			reply.setUser(user);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return reply;
	}
	
	public void deleteReplyByNo(int replyNo) throws SQLException {
		String sql = """
			delete from STORE_BOARD_REPLYES
			where REPLY_NO = ?
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, replyNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 게시글 번호를 전달받아서 해당 게시글의 모든 댓글을 조회해서 반환한다.
	 * @param boardNo 게시글번호
	 * @return 댓글 목록
	 * @throws SQLException
	 */
	public List<Reply> getReplyListByBoardNo(int boardNo) throws SQLException {
		String sql = """
			SELECT A.REPLY_NO
					, A.REPLY_CONTENT
					, A.REPLY_CREATED_DATE
					, B.USER_NO
					, B.USER_NAME
			FROM STORE_BOARD_REPLYES A, STORE_USERS B
			WHERE BOARD_NO = ?
			AND A.USER_NO = B.USER_NO
			ORDER BY A.REPLY_NO ASC
		""";
		
		List<Reply> replies = new ArrayList<Reply>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Reply reply = new Reply();
			reply.setNo(rs.getInt("REPLY_NO"));
			reply.setContent(rs.getString("REPLY_CONTENT"));
			reply.setCreatedDate(rs.getDate("REPLY_CREATED_DATE"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			user.setName(rs.getString("USER_NAME"));
			reply.setUser(user);
			
			replies.add(reply);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return replies;
	}
	
	public void insertReply(Reply reply) throws SQLException {
		String sql = """
			insert into store_board_replyes
			(reply_no, reply_content, board_no, user_no)
			values
			(STORE_REPLIES_SEQ.nextval, ?, ?, ?)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, reply.getContent());
		pstmt.setInt(2, reply.getBoard().getNo());
		pstmt.setInt(3, reply.getUser().getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
}
