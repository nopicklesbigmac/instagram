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
            int likeCount = postDAO.getLikeCount(postId);
            post.setLikeCount(likeCount);
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
    public int getLikeStatus(String accountId, int postId) {
        return postDAO.findLikeStatus(accountId, postId);
    }

    @Override
    public int getLikeCount(int postId) {
        return postDAO.getLikeCount(postId);
    }

    @Override
    public int addLike(LikeDTO likeDto) {
        postDAO.addLike(likeDto);
        return postDAO.countLikes(likeDto.getPostId());
    }

    @Override
    public int removeLike(LikeDTO likeDto) {
        postDAO.removeLike(likeDto);
        return postDAO.countLikes(likeDto.getPostId());
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
}
