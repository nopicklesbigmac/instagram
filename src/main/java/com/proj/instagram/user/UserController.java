package com.proj.instagram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class UserController {
	@Autowired private IUserDAO userDao;
	@Autowired private IUserService userService;
 
    @PostMapping("/joinProc")
    @ResponseBody
    public  Map<String, Object> joinProc(@RequestBody UserDTO user) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		result = userService.joinProc(user,result); 
		return result;
    }
}
