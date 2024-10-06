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
	
	Integer findLikeStatus(@Param("accountId") String accountId, @Param("postId") int postId);
    
    // 이미지 개수를 가져오는 메서드 추가
    int getPostPicSize(int postId);

    // 좋아요 추가 메서드
    void addLike(@Param("accountId") String accountId, @Param("postId") int postId);
    
    // 좋아요 제거 메서드
    void removeLike(@Param("accountId") String accountId, @Param("postId") int postId);

	PostDTO getPostById(int postId);

	int checkLike(String accountId, int postId);

	void addReply(ReplyDTO replyDto);

	List<ReplyDTO> findRepliesByPostId(int postId);

	int likeCount(int postId);
	
    void insertReply(ReplyDTO replyDTO); // 댓글 저장
    List<ReplyDTO> selectRepliesByPostId(@Param("postId") int postId); // 댓글 조회


    void insertLike(LikeDTO likeDto); // 좋아요 추가
    void deleteLike(LikeDTO likeDto); // 좋아요 삭제

    Integer getLikeCountByPostId(int postId);
    Integer getLikeCounts(int postId);
    int getLikeStatus(String accountId, int postId);
    void insertLike(String accountId, int postId);
    void deleteLike(String accountId, int postId);

	int isPostLiked(String accountId, int postId);

	void updateLikeCount(int postId);

	void updatePostLikeCount(@Param("postId") int postId, @Param("likeCount") int likeCount);
	
	void updatePostLikeCount(PostDTO postDTO); // 추가

	void addLike(LikeDTO likeDTO);

	Integer getLikeCount(int postId);
}
