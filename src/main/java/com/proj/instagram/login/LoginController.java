package com.proj.instagram.login;

import com.proj.instagram.user.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller  // RestController가 아닌 Controller 사용
public class LoginController {

    @Autowired
    private LoginServicelmpl loginService;

    @PostMapping("/loginProc")
    public String login(@RequestParam String email, @RequestParam String password, Model model) {
        // 로그인 서비스 호출하여 사용자 정보 확인
        System.out.println("controller");
        UserDTO user = loginService.loginProc(email, password);

        if (user != null) {
            System.out.println("controller2:" + user);
            // 로그인 성공 시 home/index.jsp 뷰로 이동
            return "redirect:/home/index"; 
        } else {
            // 로그인 실패 시 "fail" 메시지와 함께 로그인 페이지로 돌아감
        	System.out.println("controller3:" + user);
//            model.addAttribute("errorMessage", "Invalid email or password.");
//            return "login";  // login.jsp로 돌아감
        	return "fail";
        }
    }
}
