package com.proj.instagram.post;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface PostService {
    int createPost(PostDTO postDTO, List<MultipartFile> files) throws Exception;
    
    PostDTO getPostById(int postId);
    
    List<ReplyDTO> getRepliesByPostId(int postId);

	void saveReply(ReplyDTO replyDTO);
	
   int getLikeStatus(String accountId, int postId);
    
    int getLikeCount(int postId);
    
    int addLike(LikeDTO likeDto);
    int removeLike(LikeDTO likeDto);
    List<ReplyDTO> addReply(ReplyDTO replyDto);
}
