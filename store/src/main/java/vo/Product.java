package vo;

import java.util.Date;
import java.util.List;

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

	@Override
	public String toString() {
		return "Product [no=" + no + ", name=" + name + ", price=" + price + ", discountPrice=" + discountPrice
				+ ", stock=" + stock + ", description=" + description + ", createdDate=" + createdDate + ", updatedDate="
				+ updatedDate + ", category=" + category + ", company=" + company + ", status=" + status + ", benefits="
				+ benefits + "]";
	}
}
