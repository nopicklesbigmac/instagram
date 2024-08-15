package com.proj.instagram.login;

import com.proj.instagram.user.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {

    private final LoginService loginService;

    @Autowired
    public LoginController(LoginService loginService) {
        this.loginService = loginService;
    }

    @PostMapping("/loginProc") // URL이 JavaScript의 AJAX URL과 일치하는지 확인
    public String login(@RequestParam String email, @RequestParam String password) {
        UserDTO user = loginService.login(email, password);
        if (user != null) {
            return "success";
        } else {
            return "fail";
        }
    }
}
