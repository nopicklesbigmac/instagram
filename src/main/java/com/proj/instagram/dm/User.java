package com.proj.instagram.dm;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "insta_user") // 테이블 이름을 i_user로 설정
public class User {
	@Id
    private String email;
	
    private String username;

    private String password;
    private String name;
    private String useProfileImg;
    private String comments;

    private String createdAt;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUseProfileImg() {
		return useProfileImg;
	}

	public void setUseProfileImg(String useProfileImg) {
		this.useProfileImg = useProfileImg;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}


    
}