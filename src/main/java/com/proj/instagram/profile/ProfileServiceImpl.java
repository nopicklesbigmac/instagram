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

    private static final String PROFILE_IMAGE_PATH = "/path/to/save/images/";

    @Override
    public boolean updateProfile(UserDTO user, String comment, MultipartFile profileImage) {
        try {
            // 사용자 댓글 업데이트
            user.setComments(comment);

            // 프로필 이미지 처리
            if (profileImage != null && !profileImage.isEmpty()) {
                String imagePath = PROFILE_IMAGE_PATH + user.getUsername() + "/profile.jpg";
                File imageFile = new File(imagePath);
                // 디렉토리 생성
                imageFile.getParentFile().mkdirs();
                // 파일 저장
                profileImage.transferTo(imageFile);
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
