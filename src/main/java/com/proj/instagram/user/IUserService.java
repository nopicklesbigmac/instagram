package com.proj.instagram.user;

import java.util.List;
import java.util.Map;

public interface IUserService {

	Map<String, Object> joinProc(UserDTO user, Map<String, Object> result);

	boolean idcheck(UserDTO user);

	Map<String, Object> passProc(UserDTO user, Map<String, Object> result);
	
	List<UserDTO> findUsersByUsername(String username);
 
}
