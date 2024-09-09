package com.proj.instagram.dm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Comparator;
import java.util.List;


@Service
public class ChatService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MessageRepository messageRepository;

    public void sendMessage(User sender, User receiver, String content) {
        Message message = new Message();
        message.setSender(sender.getUsername());
        message.setReceiver(receiver.getUsername());
        message.setContent(content);
        message.setTimestamp(new Timestamp(System.currentTimeMillis()));
        messageRepository.save(message);
    }

    public List<Message> getConversation(User user1, User user2) {
    	//List<Message> list =messageRepository.findBySenderOrReceiver(user1.getUsername(), user2.getUsername());
    	//list.sort(Comparator.comparing(Message::getTimestamp));
        return getAllMessages();
    }
    public List<Message> getleftmsg(User userSender) {
    	List<Message> left_msg = messageRepository.left_msg(userSender.getUsername());
    	left_msg.sort(Comparator.comparing(Message::getTimestamp).reversed());
        return left_msg;
    }

    public List<Message> getAllMessages() {
    	List<Message> list = messageRepository.findAll();
    	list.sort(Comparator.comparing(Message::getTimestamp));
         return list;
    }
}
