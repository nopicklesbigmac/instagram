package com.proj.instagram.login;

import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServicelmpl {

    @Autowired
    private IUserDAO userDAO;

    // 로그인 처리를 수행하는 메서드
    public UserDTO loginProc(String email, String password) {
    	System.out.println("Servicelmpl");
        // 이메일로 사용자 정보를 조회
        UserDTO user = userDAO.selectuser(email);
        
        // 사용자 정보가 존재하고 비밀번호가 일치하는 경우 사용자 객체 반환
        if (user != null && user.getPassword().equals(password)) {
        	System.out.println("Servicelmpl2:" + user);
            return user;
        } else {
            // 그렇지 않은 경우 null 반환
            return null;
        }
    }
}
