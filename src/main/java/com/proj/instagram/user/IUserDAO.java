package com.proj.instagram.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserDAO {
	UserDTO selectemail(String email);
	
	UserDTO selectuser(String user_name);
	 
	void join (UserDTO user);
	
    void updateUser(UserDTO user);
    UserDTO getUserByEmail(String email);
}
 