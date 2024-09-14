package com.proj.instagram.post;

import java.util.List;

public interface PostService {
    void createPost(PostDTO post);
    List<PostDTO> getAllPosts();
    PostDTO getPostById(int postId);
    void addReply(String comment, String accountId, int postId);
    List<ReplyDTO> getRepliesByPostId(int postId);
    int getLikeCount(int postId);
    int getUserLikeStatus(String accountId, int postId);
    void likePost(String accountId, int postId);
    void unlikePost(String accountId, int postId);
}
