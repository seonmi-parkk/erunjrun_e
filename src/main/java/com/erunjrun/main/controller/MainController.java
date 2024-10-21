package com.erunjrun.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.erunjrun.main.service.MainService;

@Controller
public class MainController {

	@Autowired MainService mainService;
	//Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/")
	public String main() {
		
		return "common";
	}
	
	
}
