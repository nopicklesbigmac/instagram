package com.proj.instagram.post;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PostDAO {
    List<PostDTO> findByUserEmail(@Param("email") String email);
    
    void insertPost(PostDTO post);
    
    List<PostDTO> getAllPosts();
    
    PostDTO getPostById(@Param("postId") int postId);
    
    void insertReply(@Param("comment") String comment, @Param("accountId") String accountId, @Param("postId") int postId);
    
    List<ReplyDTO> getRepliesByPostId(@Param("postId") int postId);
    
    int getLikeCount(@Param("postId") int postId);
    
    int getUserLikeStatus(@Param("accountId") String accountId, @Param("postId") int postId);
    
    void likePost(@Param("accountId") String accountId, @Param("postId") int postId);
    
    void unlikePost(@Param("accountId") String accountId, @Param("postId") int postId);
    
    
}
