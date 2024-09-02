package com.proj.instagram.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.proj.instagram.user.UserDTO;

@Controller
public class HomeController {

	@GetMapping(value = "/")
	public String index(Model model) {
		model.addAttribute("formpath", "main");
		System.out.println("HomeController login" + model);
		return "views/login";
	}

//     필요에 따라 주석 처리된 부분을 복원하거나 제거합니다.
//     @RequestMapping(value = "index")
//     public void index(String formpath, Model model) {
//         model.addAttribute("formpath", formpath);
//     }

//	@RequestMapping(value = "/views/home/index") 
//	public void index(String formpath, Model model) {
//		System.out.println("HomeController index" + model);
//		model.addAttribute("formpath", formpath); 
//	}
	 // 실제로 /WEB-INF/view/home/index.jsp 파일에 매핑 }
	 
	
	
	   @RequestMapping(value = "/index")
	    public String index(String formpath, Model model) {
	        model.addAttribute("formpath", formpath);
	        return "views/home/index"; // 뷰 이름만 반환
	    }
	
	
	
    // layout 폴더 파일
	@GetMapping(value = "/header")
	public String header() {
		return "layout/header";
	}

	@GetMapping(value = "/footer")
	public String footer() {
		return "layout/footer";
	}

	@GetMapping("/join")
	public String join() {
	    return "views/join"; // /WEB-INF/views/join.jsp
	}
 
	@GetMapping("/insta")
	public String insta() {
	    return "views/home/index"; // /WEB-INF/views/home/index.jsp
	}
	
	@GetMapping("/home")
	public String home() {
	    return "views/home/index"; // /WEB-INF/views/home/index.jsp
	}

	@GetMapping("/find")
	public String find() {
	    return "views/home/find"; // /WEB-INF/views/home/find.jsp
	}

//	@GetMapping("/profile")
//	public String profile(Model model, HttpSession session) {
//		// 세션에서 로그인된 사용자 정보 가져오기
//        UserDTO user = (UserDTO) session.getAttribute("user");
//        // 세션에 사용자가 있는지 확인
//        if (user == null) {
//            return "redirect:/login";
//        }
//        // JSP로 사용자 정보 전달
//        model.addAttribute("user", user);
//	    return "views/home/profile"; // /WEB-INF/views/home/profile.jsp
//	}

	@GetMapping("/dm")
	public String dm() {
	    return "views/home/dm"; // /WEB-INF/views/home/dm.jsp
	}
	@GetMapping("/dm2")
	public String dm2() {
	    return "views/home/dm2"; // /WEB-INF/views/home/dm.jsp
	}
	@GetMapping("/dm3")
	public String dm3() {
	    return "views/home/dm3"; // /WEB-INF/views/home/dm.jsp
	}
	@GetMapping("/write")
	public String write() {
	    return "views/home/write"; // /WEB-INF/views/home/write.jsp
	}



}