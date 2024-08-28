package com.proj.instagram.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.instagram.user.UserDTO;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private ILoginService loginService;

    @PostMapping("/loginProc")
    @ResponseBody
    public Map<String, String> login(@RequestBody UserDTO login) {
        // 로그인 서비스 호출하여 사용자 정보 확인
        String result = loginService.loginProc(login);

        Map<String, String> response = new HashMap<>();
        if ("success".equals(result)) {
            response.put("status", "success");
            response.put("redirectUrl", "/index"); // 리다이렉트 URL
        } else {
            response.put("status", "fail");
        }
        return response;
    
    }
}