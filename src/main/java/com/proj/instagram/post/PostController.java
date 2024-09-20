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

            // 게시글 저장 후 ID를 가져오고, 이미지 저장을 포함합니다.
            long postId = postService.createPost(postDTO, files);
            return ResponseEntity.ok("게시글이 성공적으로 업로드되었습니다. 게시글 ID: " + postId);
        } catch (Exception e) {
            logger.error("게시글 업로드 실패: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 업로드에 실패했습니다. 오류: " + e.getMessage());
        }
    }
    
    @GetMapping("/post/{email}/{postId}")
    public String viewPost(@PathVariable Long postId, Model model) {
        PostDTO post = postService.getPostById(postId);
        List<ReplyDTO> replies = postService.getRepliesByPostId(postId);

        model.addAttribute("post", post);
        model.addAttribute("replies", replies);
        
        if (post != null) {
            model.addAttribute("post", post);
            return "views/home/post"; // view.jsp 파일을 반환
        } else {
            return "redirect:/error"; // 게시글을 찾을 수 없으면 에러 페이지로 리다이렉트
        }
    }
}
