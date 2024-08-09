package vo;

public class Benefit {

	private int no;
	private String name;
	
	public Benefit() {}
	public Benefit (int no) {
		this.no = no;
	}
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}