package com.proj.instagram.profile;

import com.proj.instagram.user.UserDTO;
import org.springframework.web.multipart.MultipartFile;

public interface IProfileService {
    boolean updateProfile(UserDTO user, String comment, MultipartFile profileImage);
    String getProfileImagePath(String username);
    
}
