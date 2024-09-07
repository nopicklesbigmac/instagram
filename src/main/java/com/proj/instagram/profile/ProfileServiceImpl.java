package com.proj.instagram.profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;

@Service
public class ProfileServiceImpl implements IProfileService {

    @Autowired
    private IUserDAO userDAO;
    
    private static final String PROFILE_IMAGE_PATH = "C:/path/to/save/images/";

    @Override
    public boolean updateProfile(UserDTO user, String comments, MultipartFile use_profile_img) {
        try {
            // 사용자 댓글 업데이트
            user.setComments(comments);

            // 프로필 이미지 처리
            if (use_profile_img != null && !use_profile_img.isEmpty()) {
                // 사용자 폴더 생성
                String userFolderPath = PROFILE_IMAGE_PATH + user.getUsername();
                File userFolder = new File(userFolderPath);
                if (!userFolder.exists()) {
                    userFolder.mkdirs(); // 폴더가 없으면 생성
                }

                // 이전 프로필 이미지 삭제 (덮어쓰기)
                File oldImage = new File(userFolderPath + "/profile.jpg");
                if (oldImage.exists()) {
                    oldImage.delete();
                }

                // 새로운 이미지 저장
                String imagePath = userFolderPath + "/profile.jpg";
                File imageFile = new File(imagePath);
                use_profile_img.transferTo(imageFile);

                // 이미지 경로 설정
                user.setUse_profile_img(imagePath);
            }

            // 사용자 정보 업데이트
            userDAO.updateUser(user);

            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String getProfileImagePath(String username) {
        return "/dynamicImage/profile/" + username + "/profile.jpg";
    }

}
