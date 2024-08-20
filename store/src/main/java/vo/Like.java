package vo;

public class Like {

	private int boardNo;
	private int userNo;
	
	public Like() {}
	public Like(int boardNo, int userNo) {
		this.boardNo = boardNo;
		this.userNo = userNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
}
