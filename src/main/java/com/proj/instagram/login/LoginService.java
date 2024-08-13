package com.proj.instagram.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class LoginService {
	
	   @Autowired
	    private LoginDTO loginDTO;
	   	private LoginDAO loginDAO;
	   @Autowired
	    private HttpSession session;

}
