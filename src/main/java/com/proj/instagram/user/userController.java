package com.proj.instagram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class userController {

    

    @PostMapping("/joinProc")
    @ResponseBody
    public  Map<String, Object> joinProc( userDTO user) {
    	System.out.println("  1 1 1 ");
    	Map<String, Object> result = new HashMap<String, Object>();
		
		  
		 System.out.println(user.getName()); 
		 System.out.println(user.getEmail());
		 System.out.println(user.getUsername());
		 System.out.println(user.getPassword());
		 
    	 result.put("code", "0000");
        return result;
        
    }
}
