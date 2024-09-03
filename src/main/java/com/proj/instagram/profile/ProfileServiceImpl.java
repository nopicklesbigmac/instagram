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
    public boolean updateProfile(UserDTO user, String comments, MultipartFile use_profile_img) {
        try {
            // 사용자 댓글 업데이트
        	user.setComments(comments);
            // 프로필 이미지 처리
            if (use_profile_img != null && !use_profile_img.isEmpty()) {
                // 이메일을 기반으로 사용자 폴더 생성
                String userFolderPath = "/path/to/save/images/" + user.getUsername(); // email을 폴더 이름으로 사용
                File userFolder = new File(userFolderPath);
                if (!userFolder.exists()) {
                    userFolder.mkdirs(); // 폴더가 없으면 생성
                }

                // 이미지 파일 경로 설정
                String imagePath = userFolderPath + "/profile.jpg";
                File imageFile = new File(imagePath);
                
                // 파일 저장
                use_profile_img.transferTo(imageFile);
                System.out.println("use_img" + use_profile_img);

                // 경로를 DB에 저장하기 위한 필드 업데이트
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
