package com.erunjrun.mate.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.erunjrun.mate.service.MateService;

@Controller
public class MateController {

	@Autowired MateService mateService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/mate")
	public String mate() {
		return "mate/profileDetail";
	}

	@RequestMapping(value="/mateAppliaction")
	public String mateApplication(String fromUserId, String toUserId) {
		logger.info("[controller] mateApplication");
		boolean result = mateService.mateApplication(fromUserId, toUserId);
		logger.info("result : "+result);
		return "mate/profileDetail";
	}
}
