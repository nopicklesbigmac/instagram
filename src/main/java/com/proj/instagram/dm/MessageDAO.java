package com.proj.instagram.dm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.proj.instagram.user.UserDTO;

@Mapper
public interface MessageDAO {
	List<MessageDTO> selectemsg(MessageDTO dto);
	List<UserDTO> userSearch(String username);
	 void insertMessage(Message message);
}
 