package com.proj.instagram.post;

import java.util.Date;

public class LikeDTO {
    private Long likeId;        // 좋아요 ID
    private String accountId;   // 사용자 계정 ID (INSTA_USER의 EMAIL)
    private int postId;        // 게시물 ID (INSTA_POST의 POST_ID)
    private Date likedAt;       // 좋아요한 날짜
 
    // Getters and Setters
    public Long getLikeId() {
        return likeId;
    }

    public void setLikeId(Long likeId) {
        this.likeId = likeId;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public Date getLikedAt() {
        return likedAt;
    }

    public void setLikedAt(Date likedAt) {
        this.likedAt = likedAt;
    }
}
