package com.proj.instagram.dm;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.instagram.user.IUserDAO;
import com.proj.instagram.user.UserDTO;


@Controller
public class ChatController {
    @Autowired
    private ChatService chatService;
    @Autowired
    private UserRepository userRepository;
	@Autowired private IUserDAO userDao;

	@ResponseBody
	@PostMapping("searchuser")
	public String ex7(@RequestBody(required = false)String username) {
		System.err.println("search : "+username);
		
		if(username == null || username.isEmpty()) {
			// 모든 데이터
			return null;
		}else {
			// 검색어에 맞는 결과 
			return chatService.userSearch(username);
		}
	}

	/*
	 * @GetMapping("/") public String chatPage(Model model) {
	 * model.addAttribute("messages", chatService.getAllMessages()); // 메시지 목록을 모델에
	 * 추가 // 사용자 목록 및 대화 내용 로드 return "chat"; }
	 */
    @GetMapping("/dm")
    public String dm(Model model,HttpSession session) {
    	
    	String send_user = (String) session.getAttribute("username");
    	//UserDTO sender = userDao.selectuser(send_user);
    	model.addAttribute("sender",send_user);
    	User userSender = userRepository.findByUsername(send_user);
    	List<Message> left_msg = chatService.getleftmsg(userSender);
    	 model.addAttribute("left_msg", left_msg); 
    	// 메시지 목록을 모델에 추가
        // 사용자 목록 및 대화 내용 로드
        return "views/home/dm";
    }
    @GetMapping("/direct")
    public String dm2(Model model,HttpSession session,@RequestParam("value") String value) {
    	String send_user = (String) session.getAttribute("username");
    	System.err.println(send_user);
    	//UserDTO sender = userDao.selectuser(send_user);
    	model.addAttribute("sender",send_user);
    	User userSender = userRepository.findByUsername(send_user);
    	User userReceiver = userRepository.findByUsername(value);
    	UserDTO receiver = userDao.selectuser(value);
    	System.err.println(receiver.getName());
    	List<Message> left_msg = chatService.getleftmsg(userSender);
    	 model.addAttribute("left_msg", left_msg); 
    	 model.addAttribute("receiver", value); 
    	 model.addAttribute("receiverinfo", receiver); 
    	
    	 List<MessageDTO> message = chatService.getConversation(userSender,userReceiver);
    	 model.addAttribute("messages", message); // 메시지 목록을 모델에 추가
    	// 메시지 목록을 모델에 추가
        // 사용자 목록 및 대화 내용 로드
        return "views/home/dm";
    }
    @PostMapping("/send")
    public String sendMessage(HttpSession session, @RequestParam String receiver, @RequestParam String content) {
    	String Sender = (String) session.getAttribute("username");
    	User userSender = userRepository.findByUsername(Sender);
        User userReceiver = userRepository.findByUsername(receiver);
        
        chatService.sendMessage(userSender, userReceiver, content);
        return "redirect:/direct?value="+receiver;
    }

}
