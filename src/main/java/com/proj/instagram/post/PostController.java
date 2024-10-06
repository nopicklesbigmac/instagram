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

import com.proj.instagram.user.UserDTO;
import com.proj.instagram.user.IUserDAO;

@Controller
public class PostController {

    @Autowired 
    private PostService postService;
    @Autowired
    private IUserDAO userDao;

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
    public String viewPost(@PathVariable("postId") int postId, Model model) {
        try {
            logger.info("Received request for post ID: " + postId);
            PostDTO post = postService.getPostById(postId);
            UserDTO postAuthor = userDao.selectUserByEmail(post.getEmail());  // 게시글 작성자의 최신 프로필 정보를 가져옴
            List<ReplyDTO> replies = postService.getRepliesByPostId(postId); // 댓글 추가
            
            if (post == null) {
                logger.error("게시글을 찾을 수 없습니다. postId: " + postId);
                return "error/404"; 
            }
            
            model.addAttribute("post", post);
            model.addAttribute("postAuthor", postAuthor);
            model.addAttribute("replies", replies); // 댓글 추가
            logger.info("게시글 조회 성공: " + post);
            return "views/home/post"; 
        } catch (Exception e) {
            logger.error("게시글 조회 실패: ", e);
            return "error/500"; 
        }
    }
    @GetMapping("/post/getLike")
    @ResponseBody
    public ResponseEntity<Integer> getLike(@RequestParam("accountId") String accountId,
                                           @RequestParam("postId") int postId) {
        try {
            boolean isLiked = postService.isPostLiked(accountId, postId);
            return ResponseEntity.ok(isLiked ? 1 : 0); // 1이면 좋아요 상태, 0이면 좋아요 없음
        } catch (Exception e) {
            logger.error("좋아요 상태 조회 실패: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 좋아요 등록
    @PostMapping("/like")
    public ResponseEntity<Integer> likePost(@RequestBody LikeDTO likeDTO) {
        try {
            // 좋아요 추가
            postService.addLike(likeDTO);
            
            // 좋아요 개수 조회
            int updatedLikeCount = postService.getLikeCounts(likeDTO.getPostId()); // 좋아요 개수 가져오기
            
            // PostDTO 업데이트
            PostDTO post = postService.getPostById(likeDTO.getPostId());
            post.setLikeCount(updatedLikeCount); // likeCount 업데이트
            postService.updatePostLikeCount(post); // 업데이트된 게시글 저장

            return ResponseEntity.ok(updatedLikeCount); // 변경된 좋아요 수 반환
        } catch (Exception e) {
            logger.error("좋아요 등록 실패: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


    @DeleteMapping("/unlike")
    public ResponseEntity<Integer> unlikePost(@RequestBody LikeDTO likeDTO) {
        try {
            // 좋아요 제거 및 현재 좋아요 수 조회
            int likeCount = postService.removeLike(likeDTO.getAccountId(), likeDTO.getPostId());
            return ResponseEntity.ok(likeCount); // 현재 좋아요 수 반환
        } catch (Exception e) {
            logger.error("좋아요 취소 실패: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


    
    @PostMapping("/postReply")
    @ResponseBody
    public ResponseEntity<List<ReplyDTO>> postReply(@RequestBody ReplyDTO replyDTO) {
    	try {
        // 댓글 추가 처리
    	postService.addReply(replyDTO); // 댓글 추가 메서드 호출
        List<ReplyDTO> replies = postService.getRepliesByPostId(replyDTO.getPostId()); // 해당 게시글의 모든 댓글 가져오기
        return ResponseEntity.ok(replies); // 댓글 목록 반환
    	 } catch (Exception e) {
    	        logger.error("댓글 추가 실패", e);
    	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    	    }
    }

}
