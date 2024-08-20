package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Board;
import vo.User;

public class BoardDao {

	/**
	 * 변경된 정보가 반영된 게시글 정보를 전달받아서 테이블에 반영시킨다.
	 * @param board 변경된 정보가 반영된 게시글 정보
	 * @throws SQLException
	 */
	public void updateBoard(Board board) throws SQLException {
		String sql = """
			update store_boards
			set board_title = ?
				, board_content = ?
				, board_view_cnt = ?
				, board_like_cnt = ?
				, board_reply_cnt = ?
				, board_deleted = ?
				, board_updated_date = sysdate
			where board_no = ?
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setString(2, board.getContent());
		pstmt.setInt(3, board.getViewCnt());
		pstmt.setInt(4, board.getLikeCnt());
		pstmt.setInt(5, board.getReplyCnt());
		pstmt.setString(6, board.getDeleted());
		pstmt.setInt(7, board.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 전달받은 게시글 번호에 대한 게시글정보를 조회해서 반환한다.
	 * @param no 조회할 게시글 번호
	 * @return 게시글정보, null이 반환될 수 있다.
	 * @throws SQLException
	 */
	public Board getBoardByNo(int no) throws SQLException {
		String sql = """
			select B.board_no
					, B.board_title
					, B.board_content
					, B.board_view_cnt
					, B.board_like_cnt
					, B.board_reply_cnt
					, B.board_created_date
					, B.board_updated_date
					, B.board_deleted
					, U.user_no
					, U.user_name
				from store_boards B, store_users U
				where B.board_no = ?
				and B.user_no = U.user_no
		""";
		Board board = new Board();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			board = new Board();
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setViewCnt(rs.getInt("board_view_cnt"));
			board.setLikeCnt(rs.getInt("board_like_cnt"));
			board.setReplyCnt(rs.getInt("board_reply_cnt"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			board.setUpdatedDate(rs.getDate("board_updated_date"));
			board.setDeleted(rs.getString("board_deleted"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			board.setUser(user);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return board;
		
	}
	
	/**
	 * 전체 게시글 갯수를 조회해서 반환한다.
	 * @return 게시글 갯수, 삭제된 게시글은 제외한다.
	 * @throws SQLException
	 */
	public int getTotalRows() throws SQLException {
		String sql = """
			select count(*) as cnt
			from store_boards
			where board_deleted = 'N'
		""";
		
		int totalRows = 0;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRows = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		con.close();
		
		return totalRows;
	}
	
	/**
	 * 조회 범위에 맞는 게시글 목록을 조회해서 반환한다.
	 * @param begin 시작일련번호
	 * @param end 끝 일련번호
	 * @return 게시글 목록
	 * @throws SQLException
	 */
	public List<Board> getBoards(int begin, int end) throws SQLException {
		String sql = """
			select *
			from (select row_number() over (order by B.board_no desc) row_num
					, B.board_no
					, B.board_title
					, B.board_view_cnt
					, B.board_like_cnt
					, B.board_reply_cnt
					, B.board_created_date
					, U.user_no
					, U.user_name
				from store_boards B, store_users U
				where B.board_deleted = 'N'
				and B.user_no = U.user_no)
			where row_num between ? and ?
		""";
		
		List<Board> boards = new ArrayList<Board>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Board board = new Board();
			board.setNo(rs.getInt("BOARD_NO"));
			board.setTitle(rs.getString("BOARD_TITLE"));
			board.setViewCnt(rs.getInt("BOARD_VIEW_CNT"));
			board.setLikeCnt(rs.getInt("BOARD_LIKE_CNT"));
			board.setReplyCnt(rs.getInt("BOARD_REPLY_CNT"));
			board.setCreatedDate(rs.getDate("BOARD_CREATED_DATE"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			board.setUser(user);
			
			boards.add(board);
		}
		
		rs.close();
		pstmt.close();
		con.close();
		
		return boards;
	}
	
	/**
	 * 새 게시글저옵를 전달받아서 테이블에 저장시킨다.
	 * @param board 새 게시글 정보
	 * @throws SQLException
	 */
	public void insertBoard(Board board) throws SQLException {
		String sql = """
			insert into STORE_BOARDS
			(BOARD_NO
			, BOARD_TITLE
			, BOARD_CONTENT
			, USER_NO)
			values
			(store_boards_seq.nextval, ?, ?, ?)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setString(2, board.getContent());
		pstmt.setInt(3, board.getUser().getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 게시글번호, 사용자번호를 전달받아서 "좋아요 테이블"에 추가한다.
	 * @param boardNo 게시글번호
	 * @param userNo 사용자번호
	 * @throws SQLException
	 */
	public void insertLike(int boardNo, int userNo) throws SQLException {
		String sql = """
			insert into STORE_BOARD_LIKES
			(BOARD_NO, USER_NO)
			values
			(?, ?)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, userNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
	
	/**
	 * 게시글번호, 사용자번호를 전달받아서 "좋아요 테이블"에서 삭제한다.
	 * @param boardNo 게시글번호
	 * @param userNo 사용자번호
	 * @throws SQLException
	 */
	public void deleteLike(int boardNo, int userNo) throws SQLException {
		String sql = """
			delete from store_board_likes
			where board_no = ? and user_no = ?
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, userNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
}