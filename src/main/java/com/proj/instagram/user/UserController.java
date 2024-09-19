package com.proj.instagram.user;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class UserController {
	@Autowired private IUserService userService;
 
    @PostMapping("/joinProc")
    @ResponseBody
    public  Map<String, Object> joinProc(@RequestBody UserDTO user) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		result = userService.joinProc(user,result); 
		return result;
    }
    @PostMapping("/passProc")
    @ResponseBody
    public  Map<String, Object> passProc(@RequestBody UserDTO user) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		result = userService.passProc(user,result); 
		return result;
    }
    
    @GetMapping("/findUser")
    @ResponseBody
    public List<UserDTO> findUser(@RequestParam("username") String username) {
        return userService.findUsersByUsername(username);
    }
    
}
