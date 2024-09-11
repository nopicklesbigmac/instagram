package com.proj.instagram.dm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageDAO {
	List<MessageDTO> selectemsg(MessageDTO dto);
	
	 void insertMessage(Message message);
}
 