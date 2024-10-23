package com.erunjrun.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.admin.dto.AdminDTO;
import com.erunjrun.admin.service.AdminService;

@Controller
public class AdminController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminService admin_service;

	
	@GetMapping(value = "/adminMember")
	public String memberListForm() {
		return "admin/memberList";
	}


	  @GetMapping(value = "/memberList") 
	  @ResponseBody 
	  public Map<String,Object> memberlist(String page, String cnt,String keyword){
		  
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		int limit = cnt_;
		int offset = (page_ - 1) * cnt_;
		int totalPages = admin_service.count(cnt_);
		
		Map<String,Object> result = new HashMap<String, Object>();
		List<AdminDTO> list =  admin_service.memberlist(limit, offset,keyword);
		logger.info("페이지"+list);
		result.put("totalPages", totalPages);
		result.put("currpage", page);
		result.put("list", list);
		
		return result;
	  
	  }
	
	  @GetMapping(value = "/adminList") 
	  @ResponseBody 
	  public Map<String,Object> adminlist(String page, String cnt){
		  
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		int limit = cnt_;
		int offset = (page_ - 1) * cnt_;
		int totalPages = admin_service.count(cnt_);
		
		Map<String,Object> result = new HashMap<String, Object>();
		List<AdminDTO> list =  admin_service.adminlist(limit, offset);
		logger.info("페이지"+list);
		result.put("totalPages", totalPages);
		result.put("currpage", page);
		result.put("list", list);
		
		return result;
	  
	  }
	  
	  
	  
//	@GetMapping(value = "/memberList")
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
