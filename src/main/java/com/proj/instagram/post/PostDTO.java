package com.proj.instagram.post;
import java.util.Date;
public class PostDTO {
    private Long postId;       // 게시글 ID
    private String email;      // 사용자 이메일
    private String content;    // 게시글 내용
    private String imagePath;  // 이미지 경로
    private Date createdAt;    // 게시글 생성 일시

    // 기본 생성자
    public PostDTO() {}

    // 모든 필드를 포함하는 생성자
    public PostDTO(Long postId, String email, String content, String imagePath, Date createdAt) {
        this.postId = postId;
        this.email = email;
        this.content = content;
        this.imagePath = imagePath;
        this.createdAt = createdAt;
    }

    // Getter 및 Setter 메서드
    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
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