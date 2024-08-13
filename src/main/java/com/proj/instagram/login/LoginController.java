package com.proj.instagram.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.proj.instagram.user.IuserDAO;
import com.proj.instagram.user.userDTO;

import org.springframework.ui.Model;

@RestController // RESTful 컨트롤러임을 명시
public class LoginController {

    @Autowired
    private IuserDAO iuserDAO; // 로그인 서비스 주입

//	@PostMapping(value = "loginProc") 
//	public String loginProc(userDTO email, Model model) {
//		String msg = iuserDAO.selectuser(email);
//	}
}
