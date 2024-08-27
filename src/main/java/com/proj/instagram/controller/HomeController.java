package com.proj.instagram.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@GetMapping(value = "/")
	public String index(Model model) {
		model.addAttribute("formpath", "main");
		return "views/login";
	}

//     필요에 따라 주석 처리된 부분을 복원하거나 제거합니다.
//     @RequestMapping(value = "index")
//     public void index(String formpath, Model model) {
//         model.addAttribute("formpath", formpath);
//     }

	@RequestMapping(value = "/home/index") 
	public String index(String formpath, Model model) {
		model.addAttribute("formpath", formpath); 
		return "home/index";
	}
	 // 실제로 /WEB-INF/view/home/index.jsp 파일에 매핑 }
	 
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
		return "views/join";
	}

	// dm
	@GetMapping("/dm")
	public String dm() {
		return "home/dm";
	}

	@GetMapping(value = "/index")
	public String index2() {
		return "index";
	}

}
