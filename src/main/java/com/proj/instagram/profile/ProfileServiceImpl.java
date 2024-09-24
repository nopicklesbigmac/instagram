package com.proj.instagram.profile;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.proj.instagram.post.PostDAO;
import com.proj.instagram.post.PostDTO;
import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;

@Service
public class ProfileServiceImpl implements IProfileService {
    
    @Autowired
    private IUserDAO userDAO;
    
    @Autowired
    private ServletContext servletContext;
    
    @Autowired
    private PostDAO postDAO; // PostDAO로 변경

    @Override
    public boolean updateProfile(UserDTO user, String comment, MultipartFile profileImage) {
        try {
        	
        	String profileImagePath = servletContext.getRealPath("/image/profile/");
        	
        	
            if (profileImage != null && !profileImage.isEmpty()) {
                // 파일 저장 경로
                String userDirectory = profileImagePath  + user.getUsername();
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
            user.setComments(comment);
 
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
    
    @Override
    public List<PostDTO> findPostsByUserEmail(String email) {
        return postDAO.findByUserEmail(email); // PostDAO를 사용
    }
    
    @Override 
    public UserDTO findUserByEmail(String email) {
        return userDAO.selectUserByEmail(email); // ProfileDAO를 사용하여 데이터베이스에서 사용자 정보 가져오기
    }


}
