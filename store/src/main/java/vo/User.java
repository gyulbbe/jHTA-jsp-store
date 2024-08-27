package vo;

import java.util.Date;

public class User {

	private int no;
	private String id;
	private String password;
	private String name;
	private String email;
	private String disabled;
	private Date createdDate;
	private Date updatedDate;
	
	public User() {}
	
	public User(int no) {
		this.no = no;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDisabled() {
		return disabled;
	}

	public void setDisabled(String disabled) {
		this.disabled = disabled;
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
	
	public static Builder builder() {
		return new Builder();
	}
	
	public static class Builder {
		private int no;
		private String id;
		private String password;
		private String name;
		private String email;
		private String disabled;
		private Date createdDate;
		private Date updatedDate;
		
		public Builder no(int no) {
			this.no = no;
			return this;
		}
		public Builder id(String id) {
			this.id = id;
			return this;
		}
		public Builder password(String password) {
			this.password = password;
			return this;
		}
		public Builder name(String name) {
			this.name = name;
			return this;
		}
		public Builder email(String email) {
			this.email = email;
			return this;
		}
		public Builder disabled(String disabled) {
			this.disabled = disabled;
			return this;
		}
		public Builder createdDate(Date createdDate) {
			this.createdDate = createdDate;
			return this;
		}
		public Builder updatedDate(Date updatedDate) {
			this.updatedDate = updatedDate;
			return this;
		}
		public User build() {
			User user = new User();
			user.setNo(no);
			user.setId(id);
			user.setEmail(email);
			user.setName(name);
			user.setPassword(password);
			user.setDisabled(disabled);
			user.setCreatedDate(createdDate);
			user.setUpdatedDate(updatedDate);
			
			return user;
		}
	}
}
