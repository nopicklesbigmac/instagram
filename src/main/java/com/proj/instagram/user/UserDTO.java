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
