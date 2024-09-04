package com.proj.instagram.user;



/*
CREATE TABLE ins_user
(
email varchar(255),
name varchar(255),
username varchar(255),
password varchar(255)
); 
*/
public class UserDTO {
	public String email;
	public String name;
	public String username;
	public String password;
	public String use_profile_img;
	private String comments;
	public String created_at;
	
	public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
	
	
    public String getUse_profile_img() {
        return use_profile_img;
    }

    public void setUse_profile_img(String use_profile_img) {
        this.use_profile_img = use_profile_img;
    }
    
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}
