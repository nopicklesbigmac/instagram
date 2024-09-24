package com.proj.instagram.post;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PostDTO {
    private int postId;       // 게시글 ID
    private String email;      // 사용자 이메일
    public String name;        // 사용자 닉네임
    public String username;    // 사용자 이름
    private String content;    // 게시글 내용
    private String imagePath;  // 이미지 경로
    private int likeCount;
    private int postPicSize;   // 이미지 개수
    private Date createdAt;     // 게시글 생성 일시

    // 기본 생성자
    public PostDTO() {}

    // 모든 필드를 포함하는 생성자
    public PostDTO(int postId, String email, String content, String imagePath, Date createdAt) {
        this.postId = postId;
        this.email = email;
        this.content = content;
        this.imagePath = imagePath;
        this.createdAt = createdAt;
    }

    // Getter 및 Setter 메서드
    public int getPostPicSize() {
        return postPicSize;
    }

    public void setPostPicSize(int postPicSize) {
        this.postPicSize = postPicSize;
    }
    
    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
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

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    // 날짜 포맷팅 메서드
    public String getFormattedCreatedAt() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 MM월 dd일");
        return formatter.format(createdAt);
    }

    @Override
    public String toString() {
        return "PostDTO{" +
                "postId=" + postId +
                ", email='" + email + '\'' +
                ", content='" + content + '\'' +
                ", imagePath='" + imagePath + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
