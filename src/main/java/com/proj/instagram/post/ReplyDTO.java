package com.proj.instagram.post;

import java.util.Date;

public class ReplyDTO {
    private String accountId;
    private int postId;
    private String email;
    private String username;
    private String comments;
    private String useProfileImg;
    private Date createdAt;

    // Getter and Setter for replyId
    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    // Getter and Setter for postId
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    // Getter and Setter for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getter and Setter for username
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Getter and Setter for comments
    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    // Getter and Setter for useProfileImg
    public String getUseProfileImg() {
        return useProfileImg;
    }

    public void setUseProfileImg(String useProfileImg) {
        this.useProfileImg = useProfileImg;
    }

    // Getter and Setter for createdAt
    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}

