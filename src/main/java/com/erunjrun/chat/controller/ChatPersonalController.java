package com.erunjrun.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.chat.dto.ChatPersonalDTO;
import com.erunjrun.chat.service.ChatPersonalService;



@Controller
public class ChatPersonalController {

	@Autowired ChatPersonalService chatPersonalService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	 @GetMapping("/chat")
	    public String chatGET(){
	        return "chat/personalChat";
    }

	 @GetMapping("/personalChatList/{chatIdx}")
	 @ResponseBody
	 public List<ChatPersonalDTO> getContent(@PathVariable String chatIdx, HttpSession session){
		 logger.info("chatIdx : "+chatIdx);
		 String baseUser = (String) session.getAttribute("loginId");
		 List<ChatPersonalDTO> list = chatPersonalService.getContent(chatIdx, baseUser);
		 return list;
	 }
	
}


