package com.proj.instagram.profile;

import com.proj.instagram.post.PostDTO;
import com.proj.instagram.user.UserDTO;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface IProfileService {
    boolean updateProfile(UserDTO user, String comment, MultipartFile profileImage);
    
    String getProfileImagePath(String username); 
    
    List<PostDTO> findPostsByUserEmail(String email);
    
    UserDTO findUserByEmail(String email); 

}
 