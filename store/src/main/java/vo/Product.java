package vo;

import java.util.Date;
import java.util.List;

/*
 * Product는 상품정보를 표현하는 클래스다.
 * 
 * Product는 상품의 카테고리정보를 표현하는 Category객체를 포함한다.
 * Product는 상품의 제조회사정보를 표현하는 Company객체를 포함한다.
 * Product는 상품의 상태정보를 표현하는 Status객체를 포함한다.
 * Product는 상품의 추가혜택정보를 표현하는 List<Benefit>객체를 포함한다.
 * 
 * Product는 상품정보와 관련된 다양한 메소드를 제공한다.
 *  + 상품의 설명의 줄바꿈문자를 <br>태그로 치환해서 제공하는 메소드
 *  + 
 */
public class Product {

	private int no;
	private String name;
	private int price;
	private int discountPrice;
	private int stock;
	private String description;
	private Date createdDate;
	private Date updatedDate;
	// Product와 Category는 N:1관계다.
	private Category category;
	// Product와 Company는 N:1관계다.
	private Company company;
	// Product와 Status는 N:1관계다.
	private Status status;
	// Product와 Benefit는 M:N관계다.
	private List<Benefit> benefits;
	
	public Product () {}
	public Product (int no) {
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(int discountPrice) {
		this.discountPrice = discountPrice;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	/**
	 * 텍스트의 줄바꿈문자를 br 태그로 변환해서 반환하는 메소드
	 * @return br태그가 포함된 문자열
	 */
	public String getHtmlDescription() {
		return description.replace(System.lineSeparator(), "<br>");
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public List<Benefit> getBenefits() {
		return benefits;
	}

	public void setBenefits(List<Benefit> benefits) {
		this.benefits = benefits;
	}
	
	public boolean hasCategory(int categoryNo) {
		return categoryNo == category.getNo();
	}
	
	public boolean hasCompany(int companyNo) {
		return companyNo == company.getNo();
	}
	
	public boolean hasStatus(int statusNo) {
		return statusNo == status.getNo();
	}

	public boolean hasBenefit(int benefitNo) {
		for (Benefit benefit : benefits) {
			if (benefit.getNo() == benefitNo) {
				return true;
			}
		}
		return false;
	}
	
	@Override
	public String toString() {
		return "Product [no=" + no + ", name=" + name + ", price=" + price + ", discountPrice=" + discountPrice
				+ ", stock=" + stock + ", description=" + description + ", createdDate=" + createdDate + ", updatedDate="
				+ updatedDate + ", category=" + category + ", company=" + company + ", status=" + status + ", benefits="
				+ benefits + "]";
	}
}
