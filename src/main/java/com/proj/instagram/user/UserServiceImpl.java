package com.proj.instagram.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService {
	@Autowired
	private IUserDAO userDao;
	

	@Override
	public Map<String, Object> joinProc(UserDTO user, Map<String, Object> result) {
		if (userDao.selectemail(user.getEmail()) != null) {
			result.put("code", "이미있는 이메일");
		} else if (userDao.selectuser(user.getUsername()) != null) {
			result.put("code", "이미있는 유저네임");
		} else if (userDao.selectemail(user.getEmail()) == null) {
			userDao.join(user);
			result.put("code", true);
		}
		return result;

	}

	@Override
	public boolean idcheck(UserDTO user) {
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
		boolean result = user.getEmail().matches(emailRegex);
		// True = email / False = username
		return result;
	}
	
	
	
	
	/*
	private BCryptPasswordEncoder passwordEncoder;
	//사용자가 입력한 비밀번호가 저장된 비밀번호와 일치하는지 검증
	public boolean checkPassword(String rawPassword, String encodedPassword) {
	    return passwordEncoder.matches(rawPassword, encodedPassword);
	}
	
	// 비밀번호 암호화: 비밀번호를 암호화할 때는 BCryptPasswordEncoder를 사용합니다.
	public void registerUser(String password) {
        String encodedPassword = passwordEncoder.encode(password);
        // encodedPassword >> 암호화된 비밀번호
    }
	
	*/
}
