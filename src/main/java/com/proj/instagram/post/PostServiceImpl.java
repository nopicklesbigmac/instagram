package com.proj.instagram.post;

import java.io.File;
import java.io.IOException;
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
        int imageIndex = 1; // 이미지 번호를 추적할 변수

        // 이미지 저장
        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                // 파일 이름 생성 (image1.jpg, image2.jpg, ...)
                String fileName = "image" + imageIndex + ".jpg";
                File serverFile = new File(directory, fileName);
                file.transferTo(serverFile); // 파일 저장

                // 이미지 경로 저장
                imagePaths.append("/image/post/" + postDTO.getEmail() + "/" + postId + "/" + fileName).append(";");
                imageIndex++; // 이미지 번호 증가
            }
        }

        // 마지막 세미콜론 제거
        if (imagePaths.length() > 0) {
            imagePaths.setLength(imagePaths.length() - 1);
        }

        // 게시글 DTO에 이미지 경로 설정
        postDTO.setImagePath(imagePaths.toString());

     // 업데이트된 게시글 저장
        postDTO.setPostId((long) postId); // postId를 long으로 변환하여 설정
        postDAO.updatePost(postDTO); // 이미지 경로와 함께 게시글 업데이트

        // 로그 확인
        System.out.println("Final Image Path: " + postDTO.getImagePath());

        return postId;
    }


}