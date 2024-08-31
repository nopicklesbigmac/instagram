package com.proj.instagram.login;

import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServicelmpl implements ILoginService{

    @Autowired
    private IUserDAO userDAO;
	@Autowired private HttpSession session;

    @Override
    public String loginProc(UserDTO login) {
        System.out.println("Servicelmpl");

        try {
        // 이메일로 사용자 정보를 조회
        UserDTO user = userDAO.selectemail(login.getEmail());

        // 사용자 정보가 존재하고 비밀번호가 일치하는 경우 사용자 객체 반환
        if (user != null && login.getPassword().equals(user.getPassword())) {
            System.out.println("Servicelmpl2: " + user);
            System.out.println("loginPW : " + login.getPassword());
            System.out.println("DAOPW : " + user.getPassword());
            session.setAttribute("id", user.getEmail());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("name", user.getName());
            session.setAttribute("Following", 0);
            session.setAttribute("Follower", 0);
            session.setAttribute("Profile_img", "instalogo.png");
            session.setAttribute("comment", "");
            
         // 세션 정보 로그 출력
            System.out.println("Session ID: " + session.getId());
            System.out.println("Session Attributes: ");
			/*
			 session.getAttributeNames().asIterator().forEachRemaining(name -> {
			 System.out.println(name + ": " + session.getAttribute(name)); });
			 */
            return "success";
        } else {
            // 비밀번호가 일치하지 않거나 사용자 정보가 없는 경우 실패 반환
            return "fail";
        }
    } catch (Exception e) {
        // 예외 발생 시 로그 기록 및 실패 반환
        e.printStackTrace();
        return "fail";
    }
}
}
