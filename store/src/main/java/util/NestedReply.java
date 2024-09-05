package util;

import java.sql.SQLException;
import java.util.ArrayDeque;
import dao.ReplyDao;
import vo.Reply;

public class NestedReply {

	ReplyDao replyDao = new ReplyDao();
	ArrayDeque<Reply> nestedReplies = new ArrayDeque<Reply>();
	Reply last = new Reply();
	/**
	 * 부모 댓글 번호를 받아서 대댓글 리스트를 반환한다.
	 * @param replyNo 부모 댓글 번호
	 * @return 대댓글 리스트
	 * @throws SQLException
	 */
	public ArrayDeque<Reply> getNestedReplies(int replyNo) throws SQLException {
		// 부모 댓글 번호로 대댓글들 스택 형태로 받기
		ArrayDeque<Reply> tmp = replyDao.getNestedRepliesByReplyNo(replyNo);
		while (!tmp.isEmpty()) {
			last = tmp.pollLast();
			nestedReplies.addLast(last);
			getNestedReplies(last.getNo());
		}
		return nestedReplies;
	}
}