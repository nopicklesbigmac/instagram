package com.proj.instagram.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserDAO {
	UserDTO selectuser(String email);
	
	void join (UserDTO user);
}
