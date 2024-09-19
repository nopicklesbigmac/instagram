package com.proj.instagram.profile;

import com.proj.instagram.post.PostDTO;
import com.proj.instagram.user.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProfileController {

    @Autowired
    private IProfileService profileService;
    
    /**
     * 현재 로그인된 사용자 정보를 반환합니다.
     * @param session 세션 객체
     * @return 사용자 정보 (UserDTO)
     */
    @GetMapping("/getPrincipal")
    @ResponseBody
    public UserDTO getPrincipal(HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        
        if (user == null) {
            throw new RuntimeException("사용자가 로그인되지 않았습니다.");
        }
        
        return user;  // UserDTO 객체를 반환
    }

    /**
     * 사용자 프로필 페이지를 조회합니다.
     * @param email 프로필을 조회할 사용자의 이메일
     * @param model 모델 객체
     * @param session 세션 객체
     * @return 프로필 페이지 뷰 이름
     */
    @GetMapping("/profile/{email}")
    public String profile(@PathVariable("email") String email, Model model, HttpSession session) {
        UserDTO sessionUser = (UserDTO) session.getAttribute("user");

        // 세션에 사용자가 없으면 로그인 페이지로 리다이렉트
        if (sessionUser == null) {
            return "redirect:/login";
        }

        // 프로필을 조회할 사용자의 정보 가져오기
        UserDTO userProfile = profileService.findUserByEmail(email);
        if (userProfile == null) {
            return "redirect:/error"; // 사용자를 찾을 수 없을 때 에러 페이지로 리다이렉트
        }

        // 사용자의 게시글 가져오기
        List<PostDTO> posts = profileService.findPostsByUserEmail(email);

        // 모델에 필요한 정보 추가
        String sessionEmail = sessionUser.getEmail();
        model.addAttribute("sessionEmail", sessionEmail);
        model.addAttribute("user", userProfile);  // 조회한 사용자의 정보 추가
        model.addAttribute("posts", posts);

        return "views/home/profile";
    }


    /**
     * 프로필 편집 페이지를 보여줍니다.
     * @param model 모델 객체
     * @param session 세션 객체
     * @return 프로필 편집 페이지 뷰 이름
     */
    @GetMapping("/editProfile")
    public String editProfile(Model model, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        String profileImageUrl = profileService.getProfileImagePath(user.getUsername());
        model.addAttribute("user", user);
        model.addAttribute("profileImageUrl", profileImageUrl);

        return "views/home/editProfile"; // JSP 파일의 경로
    }

    @PostMapping("/profile/editProfile")
    @ResponseBody
    public Map<String, String> editProfile(@RequestParam(value = "comment", required = false) String comment,
                                            @RequestParam(value = "picture", required = false) MultipartFile picture,
                                            HttpSession session) throws IOException {
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            throw new RuntimeException("로그인이 필요합니다.");
        }

        // 서비스 호출로 프로필 및 이미지 업데이트 처리
        profileService.updateProfile(user, comment, picture);
        System.out.println("Controller : "+ comment);
        // 세션 업데이트
        session.setAttribute("user", user);

        // 클라이언트에 변경된 정보를 반환
        Map<String, String> result = new HashMap<>();
        result.put("email", user.getEmail());
        result.put("username", user.getUsername());
        return result;
    }
}
