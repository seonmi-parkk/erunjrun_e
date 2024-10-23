package com.erunjrun.mate.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.mate.service.MateService;
import com.erunjrun.member.service.MemberService;

@Controller
public class MateController {

	@Autowired MateService mateService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/mate")
	public String mate(HttpSession session) {
		//임시 세션
		session.setAttribute("loginId", "kimee01");
		session.setAttribute("profileImg", "/photo/profile_img1.jpg");
		session.setAttribute("iconImg", "resources/img/icon/icon1.png");
		session.setAttribute("adminYn", "N");
		
		return "mate/profileDetail";
	}

	@RequestMapping(value="/mateAppliaction")
	@ResponseBody
	public Map<String, Object> mateApplication(String fromUserId, String toUserId, Model model) {
		logger.info("[controller] mateApplication");
		logger.info("fromUserId : {}, toUserId : {}", fromUserId, toUserId);
		boolean success = mateService.mateApplication(fromUserId, toUserId);
		logger.info("success : "+success);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", success);
		return result;
	}
}
