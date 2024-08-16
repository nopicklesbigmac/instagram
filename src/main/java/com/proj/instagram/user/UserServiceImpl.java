package com.proj.instagram.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements IUserService{
	@Autowired private IUserDAO userDao;
	
	@Override
	public Map<String, Object> joinProc( UserDTO user,Map<String, Object> result) {
		if(userDao.selectemail(user.getEmail())!=null) {
			result.put("code", "2222");
		}
		else if(userDao.selectuser(user.getUsername())!=null) {result.put("code", "3333");}
		else if(userDao.selectemail(user.getEmail())==null){
			userDao.join(user);
			result.put("code", "1111");
		}
		return result;
 
	}

	@Override
	public boolean usercheck(UserDTO user) {
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
		boolean result = user.getEmail().matches(emailRegex); 
		//True = email / False = username
		return result;
	}
}
