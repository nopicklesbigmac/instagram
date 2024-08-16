package com.proj.instagram.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserDAO {
	UserDTO selectemail(String email);
	
	UserDTO selectuser(String username);
	 
	void join (UserDTO user);
}
 