package com.proj.instagram.post;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostDAO postDAO;

    @Autowired
    private ServletContext servletContext;

    private String getImageBasePath() { 
        return servletContext.getRealPath("/image/post/");
    }

    @Override
    public int createPost(PostDTO postDTO, List<MultipartFile> files) throws Exception {
        // 게시글 저장
        postDAO.savePost(postDTO);
        int postId = postDAO.getLatestPostId(postDTO.getEmail());

        // 이미지 저장 경로
        String userFolder = getImageBasePath() + postDTO.getEmail() + "/" + postId;
        File directory = new File(userFolder);
        if (!directory.exists()) {
            directory.mkdirs(); // 디렉토리 생성
        }

        StringBuilder imagePaths = new StringBuilder();
        int imageIndex = 0; // 이미지 번호를 추적할 변수

        // 이미지 저장
        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                imageIndex++; // 이미지 번호 증가
                String fileName = "image" + imageIndex + ".jpg";
                File serverFile = new File(directory, fileName);
                file.transferTo(serverFile); // 파일 저장

                // 이미지 경로 저장
                imagePaths.append("/image/post/" + postDTO.getEmail() + "/" + postId + "/" + fileName).append(";"); // 세미콜론으로 구분
            }
        }

        // 마지막 세미콜론 제거
        if (imagePaths.length() > 0) {
            imagePaths.setLength(imagePaths.length() - 1);
        }

        // 게시글 DTO에 이미지 경로 및 이미지 개수 설정
        postDTO.setImagePath(imagePaths.toString());
        postDTO.setPostPicSize(imageIndex); // 이미지 개수 설정

        // 업데이트된 게시글 저장
        postDTO.setPostId(postId); // postId를 long으로 변환하여 설정
        postDAO.updatePost(postDTO); // 이미지 경로와 함께 게시글 업데이트

        return postId;
    }

    @Override
    public PostDTO getPostById(int postId) {
        PostDTO post = postDAO.findPostById(postId);
        if (post != null) {
            Integer picSize = postDAO.getPostPicSize(postId); // Integer 사용
            post.setPostPicSize(picSize != null ? picSize : 0); // null일 경우 0으로 설정
        }
        return post;
    }

    @Override
    public void saveReply(ReplyDTO replyDTO) {
        System.out.println("saveReply ReplyDTO: " + replyDTO); // DTO 로그 확인
        if (replyDTO.getUsername() == null || replyDTO.getUsername().isEmpty()){
            throw new IllegalArgumentException("Username cannot be null or empty");
        }
        postDAO.insertReply(replyDTO);
    }

    @Override
    public List<ReplyDTO> addReply(ReplyDTO replyDTO) {
    	postDAO.insertReply(replyDTO); // 댓글 DB에 저장
        return postDAO.findRepliesByPostId(replyDTO.getPostId()); // 저장된 댓글 목록 반환
    } 

    @Override
    public List<ReplyDTO> getRepliesByPostId(int postId) {
    	System.out.println("PostService getRepliesByPostId : " + postId);
        return postDAO.selectRepliesByPostId(postId);
    }
    
    // 좋아요 상태 확인
    @Override
    public boolean isPostLiked(String accountId, int postId) {
        Integer count = postDAO.isPostLiked(accountId, postId);
        return count != null && count > 0; 
    }

    // 좋아요 등록
    @Override
    public void likePost(String accountId, int postId) {
        postDAO.insertLike(accountId, postId);
        postDAO.updateLikeCount(postId); // 좋아요 추가
    }

    @Override
    public void unlikePost(String accountId, int postId) {
        postDAO.deleteLike(accountId, postId);
        postDAO.updateLikeCount(postId); // 좋아요 취소
    }

    // 좋아요 개수 조회
    @Override
    public int getLikeCounts(int postId) {
        Integer count = postDAO.likeCount(postId);
        return count != null ? count : 0; // null일 경우 0을 반환
    }

    // 좋아요 등록
    @Override
    public void addLike(LikeDTO likeDTO) {
        // 좋아요 추가
        postDAO.addLike(likeDTO);
        
        // 좋아요 수 업데이트
        PostDTO post = postDAO.findPostById(likeDTO.getPostId());
        updatePostLikeCount(post); // 업데이트된 게시글 저장
    }

    // 좋아요 개수 업데이트
    public void updatePostLikeCount(int postId) {
        int likeCount = postDAO.getLikeCount(postId); // 좋아요 개수 가져오기
        postDAO.updatePostLikeCount(postId, likeCount); // 게시글의 좋아요 개수 업데이트
    }
    
    
    public int removeLike(String accountId, int postId) {
        // 좋아요 제거
        postDAO.removeLike(accountId, postId);
        
        // 좋아요 개수 조회
        int likeCount = postDAO.getLikeCount(postId);
        
        // 게시물의 좋아요 개수 업데이트
        postDAO.updatePostLikeCount(postId, likeCount);
        
        return likeCount; // 현재 좋아요 수 반환
    }


    @Override
    public void updatePostLikeCount(PostDTO postDTO) {
        Integer likeCount = postDAO.getLikeCount(postDTO.getPostId());
        postDTO.setLikeCount(likeCount); // 좋아요 수 업데이트
        postDAO.updatePostLikeCount(postDTO.getPostId(), postDTO.getLikeCount()); // DB에 업데이트
    }

	@Override
	public int removeLike(LikeDTO likeDto) {
		// TODO Auto-generated method stub
		return 0;
	}
 
}
