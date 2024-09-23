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
                imagePaths.append("/image/post/" + postDTO.getEmail() + "/" + postId + "/" + fileName).append(";");
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
        postDTO.setPostId((long) postId); // postId를 long으로 변환하여 설정
        postDAO.updatePost(postDTO); // 이미지 경로와 함께 게시글 업데이트

        return postId;
    }

    @Override
    public PostDTO getPostById(Long postId) {
        PostDTO post = postDAO.findPostById(postId);
        if (post != null) {
            int picSize = postDAO.getPostPicSize(postId); // 이미지 개수 가져오기
            post.setPostPicSize(picSize); // 이미지 개수 설정
            int likeCount = postDAO.getLikeCount(postId); // 좋아요 개수 가져오기
            post.setLikeCount(likeCount); // 좋아요 개수 설정
        }
        return post;
    }

    @Override
    public List<ReplyDTO> getRepliesByPostId(Long postId) {
        return postDAO.getRepliesByPostId(postId);
    }

    public void saveReply(ReplyDTO replyDTO) {
        postDAO.saveReply(replyDTO);
    }

    @Override
    public int getLikeStatus(String accountId, Long postId) {
        System.out.println("PostServiceImpl getLikeStatus PostId : " +  postId);
        System.out.println("PostServiceImpl getLikeStatus accountId : " +  accountId);
        return postDAO.findLikeStatus(accountId, postId);
    }
    
    @Override
    public void likePost(String accountId, Long postId) {
        // 먼저 좋아요 상태를 확인하고, 좋아요가 없을 경우 추가
        if (postDAO.findLikeStatus(accountId, postId) == 0) {
            postDAO.addLike(accountId, postId);
        }
    }

    @Override
    public void unlikePost(String accountId, Long postId) {
        // 좋아요가 있을 경우에만 제거
        if (postDAO.findLikeStatus(accountId, postId) > 0) {
            postDAO.removeLike(accountId, postId);
        }
    }

    @Override
    public int getLikeCount(Long postId) {
        return postDAO.getLikeCount(postId);
    }
}
