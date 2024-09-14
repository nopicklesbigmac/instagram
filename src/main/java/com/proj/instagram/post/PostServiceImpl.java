package com.proj.instagram.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PostServiceImpl implements PostService {
    
    @Autowired
    private PostDAO postDAO;

    @Override
    public void createPost(PostDTO post) {
        postDAO.insertPost(post);
    }

    @Override
    public List<PostDTO> getAllPosts() {
        return postDAO.getAllPosts();
    }

    @Override
    public PostDTO getPostById(int postId) {
        return postDAO.getPostById(postId);
    }

    @Override
    public void addReply(String comment, String accountId, int postId) {
        postDAO.insertReply(comment, accountId, postId);
    }

    @Override
    public List<ReplyDTO> getRepliesByPostId(int postId) {
        return postDAO.getRepliesByPostId(postId);
    }

    @Override
    public int getLikeCount(int postId) {
        return postDAO.getLikeCount(postId);
    }

    @Override
    public int getUserLikeStatus(String accountId, int postId) {
        return postDAO.getUserLikeStatus(accountId, postId);
    }

    @Override
    public void likePost(String accountId, int postId) {
        postDAO.likePost(accountId, postId);
    }

    @Override
    public void unlikePost(String accountId, int postId) {
        postDAO.unlikePost(accountId, postId);
    }
}
