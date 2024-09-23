package com.proj.instagram.post;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface PostService {
    int createPost(PostDTO postDTO, List<MultipartFile> files) throws Exception;
    
    PostDTO getPostById(Long postId);
    
    List<ReplyDTO> getRepliesByPostId(Long postId);

	void saveReply(ReplyDTO replyDTO);
	
   int getLikeStatus(String accountId, Long postId);
    
    // 좋아요 추가 메서드
    void likePost(String accountId, Long postId);
    
    // 좋아요 제거 메서드
    void unlikePost(String accountId, Long postId);
    
    int getLikeCount(Long postId);
}
