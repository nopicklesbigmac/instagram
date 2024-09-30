package com.proj.instagram.post;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

public class ReplyDTO {
	private String replyId;
    private int postId;
    private String email;
    private String username;
    private String comments;
    
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createdAt;
    
    private String useProfileImg;

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

    // Getter and Setter for createdAt
    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

	public String getUseProfileImg() {
		return useProfileImg;
	}

	public void setUseProfileImg(String useProfileImg) {
		this.useProfileImg = useProfileImg;
	}

	public String getReplyId() {
		return replyId;
	}

	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}

	@Override
	public String toString() {
	    return "ReplyDTO{" +
	            "replyId=" + replyId +
	            ", postId=" + postId +
	            ", email='" + email + '\'' +
	            ", username='" + username + '\'' +
	            ", comments='" + comments + '\'' +
	            ", createdAt=" + createdAt +
	            ", useProfileImg='" + useProfileImg + '\'' +
	            '}';
	}

}

