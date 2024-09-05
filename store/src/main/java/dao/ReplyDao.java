package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Board;
import vo.Reply;
import vo.User;

public class ReplyDao {
	
	/**
	 * 게시물번호를 받아서 그 게시물에 존재하는 루트 댓글의 갯수를 센다.
	 * 페이징
	 * @param boardNo
	 * @return
	 * @throws SQLException
	 */
	public int getCountRootCommentByBoardNo(int boardNo) throws SQLException {
		String sql = """
			select count(*) as cnt
			from STORE_BOARD_REPLYES
			where BOARD_NO = ?
			and PARENT_REPLY_NO is null
		""";
		
		int count = 0;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		count = rs.getInt(1);
		
		rs.close();
		pstmt.close();
		con.close();
		
		return count;
	}
	
	/**
	 * 부모 댓글 번호로 자식 댓글리스트 오름차순
	 * @param replyNo
	 * @return 대댓글
	 * @throws SQLException
	 */
	public ArrayDeque<Reply> getNestedRepliesByReplyNo(int replyNo) throws SQLException {
		String sql = """
			select r.REPLY_NO
					, r.REPLY_CONTENT
					, r.REPLY_CREATED_DATE
					, r.REPLY_UPDATED_DATE
					, r.REPLY_DEPTH
					, r.PARENT_REPLY_NO
					, u.USER_NAME
			from STORE_BOARD_REPLYES r
			join STORE_USERS u on r.USER_NO = u.USER_NO
			where PARENT_REPLY_NO = ?
			and PARENT_REPLY_NO is not null
			order by REPLY_CREATED_DATE asc
		""";
		
		ArrayDeque<Reply> nestedReplies = new ArrayDeque<Reply>();
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, replyNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Reply reply = new Reply();
			reply.setNo(rs.getInt("REPLY_NO"));
			reply.setContent(rs.getString("REPLY_CONTENT"));
			reply.setCreatedDate(rs.getDate("REPLY_CREATED_DATE"));
			reply.setUpdatedDate(rs.getDate("REPLY_UPDATED_DATE"));
			reply.setDepth(rs.getInt("REPLY_DEPTH"));
			reply.setParentNo(rs.getInt("PARENT_REPLY_NO"));
			
			User user = new User();
			user.setName(rs.getString("USER_NAME"));
			reply.setUser(user);
			
			nestedReplies.addLast(reply);
		}
		rs.close();
		pstmt.close();
		con.close();
		
		return nestedReplies;
	}
	
	/**
	 * 댓글번호로 댓글 불러오기
	 * @param replyNo 댓글번호
	 * @return 댓글
	 * @throws SQLException
	 */
	public Reply getReplyByNo(int replyNo) throws SQLException {
		String sql = """
			select *
			from STORE_BOARD_REPLYES
			where reply_no = ?
			and PARENT_REPLY_NO IS NULL;
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
	 * 게시글 번호를 전달받아서 해당 게시글의 루트 댓글을 조회해서 반환한다.
	 * 조회 범위에 맞는 루트 댓글 목록을 조회해서 반환한다.
	 * @param boardNo 게시글번호
	 * @return 댓글 목록
	 * @throws SQLException
	 */
	public List<Reply> getReplyListByBoardNo(int boardNo, int begin, int end) throws SQLException {
		String sql = """
			SELECT *
			FROM(SELECT ROW_NUMBER() OVER (ORDER BY A.REPLY_NO ASC) ROW_NUM
						, A.REPLY_NO
						, A.REPLY_CONTENT
						, A.REPLY_CREATED_DATE
						, B.USER_NO
						, B.USER_NAME
				FROM STORE_BOARD_REPLYES A, STORE_USERS B
				WHERE BOARD_NO = ?
				AND A.USER_NO = B.USER_NO
				AND A.PARENT_REPLY_NO IS NULL)
			WHERE ROW_NUM BETWEEN ? AND ?
		""";
		
		List<Reply> replies = new ArrayList<Reply>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
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
