package com.proj.instagram.post;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface PostService {
    int createPost(PostDTO postDTO, List<MultipartFile> files) throws Exception;
    
    PostDTO getPostById(int postId);
    
    List<ReplyDTO> getRepliesByPostId(int postId);

	void saveReply(ReplyDTO replyDTO);
     
   int getLikeCounts(int postId);
    
    void addLike(LikeDTO likeDto);
    int removeLike(LikeDTO likeDto);
    List<ReplyDTO> addReply(ReplyDTO replyDto);

	void likePost(String accountId, int postId);

	void unlikePost(String accountId, int postId);

	boolean isPostLiked(String accountId, int postId);

	void updatePostLikeCount(PostDTO post);

	int removeLike(String accountId, int postId);
}
