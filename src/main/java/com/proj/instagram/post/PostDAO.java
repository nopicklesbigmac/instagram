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
    
    PostDTO findPostById(int postId); 
    
    
    List<ReplyDTO> getRepliesByPostId(int postId);

	void saveReply(ReplyDTO replyDTO);
	
	int findLikeStatus(@Param("accountId") String accountId, @Param("postId") int postId);
    
    // 이미지 개수를 가져오는 메서드 추가
    int getPostPicSize(int postId);

    // 좋아요 추가 메서드
    void addLike(@Param("accountId") String accountId, @Param("postId") int postId);
    
    // 좋아요 제거 메서드
    void removeLike(@Param("accountId") String accountId, @Param("postId") int postId);
    
    int getLikeCount(int postId);

	PostDTO getPostById(int postId);

	int checkLike(String accountId, int postId);

	void addReply(ReplyDTO replyDto);

	List<ReplyDTO> findRepliesByPostId(int postId);

	void removeLike(LikeDTO likeDto);

	void addLike(LikeDTO likeDto);

	int countLikes(int postId);
	
    void insertReply(ReplyDTO replyDTO); // 댓글 저장
    List<ReplyDTO> selectRepliesByPostId(@Param("postId") int postId); // 댓글 조회
    
}
