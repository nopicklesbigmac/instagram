package com.proj.instagram.post;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class PostController {

    @Autowired 
    private PostService postService;

    private static final Logger logger = LoggerFactory.getLogger(PostController.class);

    @PostMapping("/upload")
    @ResponseBody
    public ResponseEntity<String> uploadPost(@RequestParam("email") String email,
                                             @RequestParam("content") String content,
                                             @RequestParam("file") List<MultipartFile> files) {
        try {
            if (files.isEmpty()) {
                return ResponseEntity.badRequest().body("파일이 업로드되지 않았습니다.");
            }

            PostDTO postDTO = new PostDTO();
            postDTO.setEmail(email);
            postDTO.setContent(content);

            long postId = postService.createPost(postDTO, files);
            return ResponseEntity.ok("게시글이 성공적으로 업로드되었습니다. 게시글 ID: " + postId);
        } catch (Exception e) {
            logger.error("게시글 업로드 실패: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 업로드에 실패했습니다. 오류: " + e.getMessage());
        }
    }
    
    @GetMapping("/post/{postId}") 
    public String viewPost(@PathVariable int postId, Model model) {
        try {
            logger.info("Received request for post ID: " + postId);
            PostDTO post = postService.getPostById(postId);
            List<ReplyDTO> replies = postService.getRepliesByPostId(postId); // 댓글 추가
            
            if (post == null) {
                logger.error("게시글을 찾을 수 없습니다. postId: " + postId);
                return "error/404"; 
            }
            
            
            model.addAttribute("post", post);
            model.addAttribute("replies", replies); // 댓글 추가
            System.out.println("PostController viewPost : " + post);
            return "views/home/post"; 
        } catch (Exception e) {
            logger.error("게시글 조회 실패: ", e);
            return "error/500"; 
        }
    }

    // 좋아요 추가
    @PostMapping("/post/like")
    public ResponseEntity<Integer> postLike(@RequestBody LikeDTO likeDto) {
        int likeCount = postService.addLike(likeDto);
        return new ResponseEntity<>(likeCount, HttpStatus.OK);
    }

    // 좋아요 취소
    @DeleteMapping("/post/like")
    public ResponseEntity<Integer> postUnlike(@RequestBody LikeDTO likeDto) {
        int likeCount = postService.removeLike(likeDto);
        return new ResponseEntity<>(likeCount, HttpStatus.OK);
    }

    // 댓글 작성
    @PostMapping("/post/reply")
    public ResponseEntity<List<ReplyDTO>> postReply(@RequestBody ReplyDTO replyDto) {
        List<ReplyDTO> replies = postService.addReply(replyDto);
        return new ResponseEntity<>(replies, HttpStatus.OK);
    }
}
