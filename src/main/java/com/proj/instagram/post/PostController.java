package com.proj.instagram.post;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class PostController {

    @Autowired
    private PostService postService;

    @GetMapping("/posts")
    public String getAllPosts(Model model) {
        List<PostDTO> posts = postService.getAllPosts();
        model.addAttribute("posts", posts);
        return "views/post/post";
    }

    @PostMapping("/postReply")
    @ResponseBody
    public List<ReplyDTO> postReply(@RequestBody Map<String, String> data, HttpSession session) {
        String comment = data.get("comment");
        String accountId = data.get("accountId");
        int postId = Integer.parseInt(data.get("postId"));

        postService.addReply(comment, accountId, postId);
        return postService.getRepliesByPostId(postId);
    }

    @PostMapping("/postLike")
    @ResponseBody
    public int likePost(@RequestBody Map<String, String> data) {
        String accountId = data.get("principalId");
        int postId = Integer.parseInt(data.get("postId"));

        postService.likePost(accountId, postId);
        return postService.getLikeCount(postId);
    }

    @DeleteMapping("/postUnlike")
    @ResponseBody
    public int unlikePost(@RequestBody Map<String, String> data) {
        String accountId = data.get("principalId");
        int postId = Integer.parseInt(data.get("postId"));

        postService.unlikePost(accountId, postId);
        return postService.getLikeCount(postId);
    }
    
    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            // 파일 저장 로직
            return ResponseEntity.ok("파일 업로드 성공");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 실패");
        }
    }

}
