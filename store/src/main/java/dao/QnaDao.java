package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.ConnectionUtils;
import vo.Category;
import vo.Qna;
import vo.QnaCategory;
import vo.User;

public class QnaDao {

	public Qna getQnaByNo(int qnaNo) throws SQLException {
		String sql = """
			select A.QNA_NO
					, A.QNA_TITLE
					, A.QNA_QUESTION
					, A.QNA_ANSWER
					, A.QNA_STATUS
					, A.QNA_CREATED_DATE
					, A.QNA_UPDATED_DATE
					, A.QNA_ANSWERED_DATE
					, B.CAT_NO
					, B.CAT_NAME
					, A.USER_NO
					, A.QNA_FILENAME
			from STORE_QNA_BOARDS A, STORE_QNA_CATEGORIES B
			where QNA_NO = ?
			AND A.CAT_NO = B. CAT_NO
			AND QNA_DELETED = 'N'
		""";
		
		Qna qna = null;
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, qnaNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			qna = new Qna();
			qna.setQnaNo(rs.getInt("QNA_NO"));
			qna.setTitle(rs.getString("QNA_TITLE"));
			qna.setQuestion(rs.getString("QNA_QUESTION"));
			qna.setAnswer(rs.getString("QNA_ANSWER"));
			qna.setStatus(rs.getString("QNA_STATUS"));
			qna.setCreatedDate(rs.getDate("QNA_CREATED_DATE"));
			qna.setUpdatedDate(rs.getDate("QNA_UPDATED_DATE"));
			qna.setAnsweredDate(rs.getDate("QNA_ANSWERED_DATE"));
			qna.setUserNo(rs.getInt("USER_NO"));
			qna.setFilename(rs.getString("qna_filename"));
			
			Category category = new Category();
			
			category.setNo(rs.getInt("CAT_NO"));
			category.setName(rs.getString("CAT_NAME"));
			qna.setCategory(category);
		}
		
		return qna;
	}
	
	public List<QnaCategory> getAllQnaCategories() throws SQLException {
		String sql = """
			select *
			from STORE_QNA_CATEGORIES
		""";
		List<QnaCategory> QnaCategories = new ArrayList<QnaCategory>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			QnaCategory qnaCategory = new QnaCategory();
			qnaCategory.setNo(rs.getInt("CAT_NO"));
			qnaCategory.setName(rs.getString("CAT_NAME"));
			QnaCategories.add(qnaCategory);
		}
		
		return QnaCategories;
	}
	
	public List<Qna> getQnasByUserNo(int userNo, int begin, int end) throws SQLException {
		String sql = """
			select *
			from (select row_number() over (order by qna_no desc) row_num
				, qna_no
				, qna_title
				, qna_status
				, qna_created_date
				, qna_answered_date
                              from store_qna_boards
                              where user_no = ?
                              and qna_deleted = 'N')
			where row_num between ? and ?
		""";
		
		List<Qna> qnas = new ArrayList<Qna>();
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qna_no"));
			qna.setTitle(rs.getString("qna_title"));
			qna.setStatus(rs.getString("qna_status"));
			qna.setCreatedDate(rs.getDate("qna_created_date"));
			qna.setAnsweredDate(rs.getDate("qna_answered_date"));
			
			qnas.add(qna);
		}
		return qnas;
	  }
	  	
	public int getTotalRowsByUserNo(int userNo) throws SQLException {
		String sql = """
			select count(*) cnt
			from store_qna_boards
                        where user_no = ?
                        and qna_deleted = 'N'
		""";
		int totalRows = 0;

		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRows = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		con.close();
		
		return totalRows;
	}
	
	public void insertQna(Qna qna) throws SQLException {
		String sql = """
			insert into store_qna_boards
			(qna_no, cat_no, qna_title, qna_question, user_no, QNA_FILENAME)
        	values
			(store_qna_seq.nextval, ?, ?, ?, ?, ?)
		""";
		
		Connection con = ConnectionUtils.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, qna.getCategory().getNo());
		pstmt.setString(2, qna.getTitle());
		pstmt.setString(3, qna.getQuestion());
		pstmt.setInt(4, qna.getUserNo());
		pstmt.setString(5, qna.getFilename());
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}
}