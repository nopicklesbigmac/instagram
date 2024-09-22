package com.proj.instagram.post;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    
    @GetMapping("/post/{postId}")  // URL 경로를 /post/{postId}로 변경
    public String viewPost(@PathVariable Long postId, Model model) {
        try {
        	logger.info("Received request for post ID: " + postId);
            PostDTO post = postService.getPostById(postId);
            if (post == null) {
                logger.error("게시글을 찾을 수 없습니다. postId: " + postId);
                return "error/404"; // 404 에러 페이지로 이동
            }
            System.out.println("PostController : " + post);
            model.addAttribute("post", post);
            return "views/home/post"; // JSP 파일 경로
        } catch (Exception e) {
        	System.out.println("PostController : error");
            logger.error("게시글 조회 실패: ", e);
            return "error/500"; // 500 에러 페이지로 이동
        }
    }

    @PostMapping("/postReply")
    public ResponseEntity<List<ReplyDTO>> postReply(@RequestBody ReplyDTO replyDTO) {
        postService.saveReply(replyDTO);
        List<ReplyDTO> replies = postService.getRepliesByPostId(replyDTO.getPostId());
        return ResponseEntity.ok(replies);
    }
}
