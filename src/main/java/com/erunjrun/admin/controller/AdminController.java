package com.erunjrun.admin.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.admin.service.AdminService;

@Controller
public class AdminController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminService admin_service;

	
	@GetMapping(value = "/admin")
	public String memberListForm() {
		return "admin/memberList";
	}
	
	  @GetMapping(value = "/memberList") 
	  @ResponseBody
	  public Map<String, Object>memberlist(String page,String cnt) {
		  logger.info("ㅁㄴㅇㄹ");
		  logger.info(page);
		  logger.info(cnt);
	 int page_ = Integer.parseInt(page); 
	 int cnt_=Integer.parseInt(cnt);
	  logger.info(cnt); 
	  logger.info(page);
	  
	 return admin_service.memberlist(page_,cnt_);
	  
	  }
	
	
//	@PostMapping(value = "/memberList")
//	public String memberlist(Model model) {
//		
//		List<AdminDTO> list = admin_service.memberlist();
//		model.addAttribute("list", list);
//		
//		return "admin/memberList";
//		
//	}
	
		/*
		 * @GetMapping(value = "/MemberDetail") public String admindetail(Model model) {
		 * return "admin/memberDetail";
		 * }
		 */
	
	/*
	 * @PostMapping(value = "/adminMulti") public String multi(Model model) { return
	 * "adminMulti"; }
	 */
}