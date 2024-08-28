package com.proj.instagram.login;

import javax.servlet.http.HttpServletRequest;

import com.proj.instagram.user.UserDTO;

public interface ILoginService {
	
	String loginProc(UserDTO login);

}
