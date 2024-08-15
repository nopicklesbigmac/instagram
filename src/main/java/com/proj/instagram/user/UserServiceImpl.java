package com.proj.instagram.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements IUserService{
	@Autowired private IUserDAO userDao;
	
	@Override
	public Map<String, Object> joinProc( UserDTO user,Map<String, Object> result) {
		if(userDao.selectuser(user.getEmail())==null) {
			userDao.join(user);
			result.put("code", "1111");
		}else{
	    	 result.put("code", "0000");
		}
		return result;

	}
}
