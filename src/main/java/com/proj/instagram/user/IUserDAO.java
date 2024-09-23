package com.proj.instagram.user;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IUserDAO {
	UserDTO selectemail(String email);
	
	UserDTO selectuser(String user_name);
	 
	void join (UserDTO user);
	
    void updateUser(UserDTO user);
    UserDTO getUserByEmail(String email);
    
    List<UserDTO> findUsersByUsername(String username);
    
    UserDTO selectUserByEmail(String email);
    
    UserDTO findByEmail(String email);
}
 