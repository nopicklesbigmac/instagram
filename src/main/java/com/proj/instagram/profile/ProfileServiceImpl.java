package com.proj.instagram.profile;

import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Service
public class ProfileServiceImpl implements IProfileService {
    
    @Autowired
    private IUserDAO userDAO;
    
    private static final String PROFILE_IMAGE_PATH = "C:/javas/test_kill/src/main/webapp/image/profile/";

    @Override
    public boolean updateProfile(UserDTO user, String comment, MultipartFile profileImage) {
        try {
            if (profileImage != null && !profileImage.isEmpty()) {
                // 파일 저장 경로
                String userDirectory = PROFILE_IMAGE_PATH + user.getUsername();
                File dir = new File(userDirectory);
                if (!dir.exists()) {
                    dir.mkdirs(); // 디렉토리 생성
                }

                // 파일 저장
                String fileName = "profile.png";
                File file = new File(userDirectory + File.separator + fileName);
                profileImage.transferTo(file);

                // 프로필 이미지 URL 업데이트
                user.setUse_profile_img("/image/profile/" + user.getUsername() + "/" + fileName);
            }

            // 댓글 업데이트
            user.setComments(comment);  // Comment 값이 올바르게 설정되는지 확인
            System.out.println("Service: Comment : " + comment);

            // 사용자 정보를 DB에 저장
            userDAO.updateUser(user);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String getProfileImagePath(String username) {
        // 프로필 이미지 경로를 반환
        return "/image/profile/" + username + "/profile.png";
    }
}
