package com.proj.instagram.dm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proj.instagram.user.UserDTO;

import java.sql.Timestamp;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;


@Service
public class ChatService {
    
    @Autowired
    private MessageDAO dao;

    public void sendMessage(UserDTO sender, UserDTO receiver, String content) {
    	MessageDTO message = new MessageDTO();
        message.setSender_username(sender.getUsername());
        message.setReceiver_username(receiver.getUsername());
        message.setContent(content);
        message.setTimestamp(new Timestamp(System.currentTimeMillis()));
        dao.insertMessage(message);
    }

    public List<MessageDTO> getConversation(UserDTO user1, UserDTO user2) {
    	 String username1 = user1.getUsername();
    	 String username2 = user2.getUsername();
    	 MessageDTO msg = new MessageDTO();
    	 msg.setSender_username(username1);
    	 msg.setReceiver_username(username2);
    	 List<MessageDTO> msg_list = dao.selectemsg(msg);

    	//List<Message> list =messageRepository.getMessages(username1, username2);
    	//list.sort(Comparator.comparing(Message::getTimestamp));
    	 //getAllMessages()// timestamp를 기준으로 정렬
    	 Collections.sort(msg_list, new Comparator<MessageDTO>() {
             @Override
             public int compare(MessageDTO m1, MessageDTO m2) {
                 return m1.getTimestamp().compareTo(m2.getTimestamp());
             }
         });
        return msg_list;
    }
    public List<MessageDTO> getleftmsg(UserDTO userSender) {
    	String u_name = userSender.getUsername();
    	List<MessageDTO> left_msg = dao.leftMsg(u_name);
    	left_msg.sort(Comparator.comparing(MessageDTO::getTimestamp).reversed());
        return left_msg;
    }

	/*
	 * public List<Message> getAllMessages() { List<Message> list =
	 * messageRepository.findAll();
	 * list.sort(Comparator.comparing(Message::getTimestamp)); return list; }
	 */
    public void sendMessage(MessageDTO message) {
        message.setTimestamp(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
        dao.insertMessage(message);
    }

    public List<MessageDTO> getMessagesByReceiver(MessageDTO msg) {
        return dao.selectemsg(msg);
    }



	public  String userSearch(String username) {
		List<UserDTO> list = dao.userSearch(username);
		return fromJson(list);
	}

	public String fromJson(List<UserDTO> list) {
		String data = "{\"cd\" : [";
		for(UserDTO tmp : list) {
			data += "{ \"username\" : \"" + tmp.getUsername() + "\",";
			data += " \"profile_img\" : \"" + tmp.getUse_profile_img() +"\" ,";
			data += " \"email\" : \"" + tmp.getEmail() +"\" ,";
			data += " \"name\" : \"" + tmp.getName() +"\" },";
		}
		data = data.substring(0, data.length()-1);
		data += "]}";
		return data;
	}
}
