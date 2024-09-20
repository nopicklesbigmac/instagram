package com.proj.instagram.post;

import java.util.Date;

public class ReplyDTO {
    private Long id; // 댓글 ID
    private String comments; // 댓글 내용
    private String username; // 댓글 작성자 이름
    private boolean useProfileImg; // 프로필 이미지 사용 여부
    private String email;
    private Long postId; // 해당 게시글 ID
    private Date createdAt; // 댓글 작성 날짜

    // Getters and Setters
    
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isUseProfileImg() {
        return useProfileImg;
    }

    public void setUseProfileImg(boolean useProfileImg) {
        this.useProfileImg = useProfileImg;
    }

    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
