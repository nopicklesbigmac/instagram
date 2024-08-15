package com.proj.instagram.login;

import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    private final IUserDAO userDAO;

    @Autowired
    public LoginService(IUserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public UserDTO login(String email, String password) {
        UserDTO user = userDAO.selectuser(email);

        // 비밀번호 확인 또는 추가적인 로직을 구현할 수 있습니다.
        if (user != null && user.getPassword().equals(password)) {
        	System.out.println(user);
            return user; // 로그인 성공 시, 사용자 정보를 반환
        }
        System.out.println(user);
        return null; // 로그인 실패 시, null을 반환
    }
}
