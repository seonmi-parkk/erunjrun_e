package com.erunjrun.admin.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.erunjrun.admin.dao.AdminDAO;
import com.erunjrun.admin.dto.AdminDTO;
import com.erunjrun.admin.service.AdminService;

@Controller
public class AdminController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminService admin_service;
	
	@GetMapping(value = "/")
	public String main() {
		return "main";
	}

	@GetMapping(value = "/memberList")
	public String memberlist(Model model) {
		List<AdminDTO> memberList = admin_service.memberList();
		model.addAttribute("memberList",memberList);
		return "memberlist";
	}
	
	@PostMapping(value = "/multi")
	public String multi(Model model) {
		return "";
	}
}
