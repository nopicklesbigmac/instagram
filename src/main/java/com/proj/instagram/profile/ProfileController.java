package com.proj.instagram.profile;

import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class ProfileController {

    @Autowired
    private IProfileService profileService;
    @Autowired
    private IUserDAO userDAO;

    @GetMapping("/profile")
    public String profile(Model model, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        return "views/home/profile";
    }

    @GetMapping("/editProfile")
    public String editProfile(Model model, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }
     // 프로필 이미지 URL을 추가로 모델에 포함
        String profileImageUrl = profileService.getProfileImagePath(user.getUsername());
        model.addAttribute("user", user);
        model.addAttribute("profileImageUrl", profileImageUrl);
        return "views/home/editProfile";
    }

    @PostMapping("/editProfile")
    public String updateProfile(
            @RequestParam(value = "comments", defaultValue = "") String comments,
            @RequestParam(value = "use_profile_img", required = false) MultipartFile use_profile_img,
            HttpSession session, Model model) {

        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        // 로그 확인
        System.out.println("Received comments: " + comments);
        
        if (use_profile_img != null && !use_profile_img.isEmpty()) {
            System.out.println("파일 이름: " + use_profile_img.getOriginalFilename());
            System.out.println("파일 크기: " + use_profile_img.getSize());
        } else {
            System.out.println("파일이 전송되지 않았습니다.");
        }

        boolean updateSuccess = profileService.updateProfile(user, comments, use_profile_img);

        if (updateSuccess) {
            user.setComments(comments);
            session.setAttribute("user", user);
            model.addAttribute("message", "프로필이 성공적으로 업데이트되었습니다.");
        } else {
            model.addAttribute("message", "프로필 업데이트 중 오류가 발생했습니다.");
        }

        return "redirect:/profile";
    }


}
