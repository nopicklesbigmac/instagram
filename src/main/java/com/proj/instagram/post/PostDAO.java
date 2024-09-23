package com.proj.instagram.post;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PostDAO {
    List<PostDTO> findByUserEmail(@Param("email") String email);
    
    void savePost(PostDTO postDTO);

    int getLatestPostId(String email);
    
    void updatePost(PostDTO postDTO);
    
    PostDTO findPostById(Long postId); 
    
    
    List<ReplyDTO> getRepliesByPostId(Long postId);

	void saveReply(ReplyDTO replyDTO);
	
	int findLikeStatus(@Param("accountId") String accountId, @Param("postId") Long postId);
    
    // 이미지 개수를 가져오는 메서드 추가
    int getPostPicSize(Long postId);

    // 좋아요 추가 메서드
    void addLike(@Param("accountId") String accountId, @Param("postId") Long postId);
    
    // 좋아요 제거 메서드
    void removeLike(@Param("accountId") String accountId, @Param("postId") Long postId);
    
    int getLikeCount(Long postId);

	PostDTO getPostById(Long postId);

	int checkLike(String accountId, Long postId);
    
}
