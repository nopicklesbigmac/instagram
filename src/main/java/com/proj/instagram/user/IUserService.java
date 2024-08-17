package com.proj.instagram.user;

import java.util.Map;

public interface IUserService {


	boolean usercheck(UserDTO user);




	Map<String, Object> joinProc(UserDTO user, Map<String, Object> result);
 
}
