/*
package com.erunjrun.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.chat.dto.ChatPersonalDTO;
import com.erunjrun.chat.service.ChatPersonalService;
import com.erunjrun.mate.dto.MateProfileDTO;
import com.erunjrun.mate.service.MateService;

@Controller
public class ChatPersonalController_bf {

	@Autowired ChatPersonalService chatPersonalService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/chat")
	public String chat() {
		return "chat/personalChat";
	}
	
	@PostMapping("/sendMessage")
	public void sendMessage(@RequestBody ChatPersonalDTO chatPersonalDTO) throws Exception {
		// 메세지를 db에 저장
		chatPersonalService.saveMessage(chatPersonalDTO);
		
		// 상대방이 접속 중이면 웹 소켓을 통해 실시간으로 메시지 전송
		if(chatPersonalService.isUserOnline(chatPersonalDTO.getRecipient())) {
			chatPersonalService.sendMessageSocket(chatPersonalDTO);
		}
	}
	
	@GetMapping("/getMessages")
    public List<ChatPersonalDTO> getMessages(@RequestParam String userId) {
        // 해당 사용자가 받지 못한 메시지들을 반환
        return chatPersonalService.getUnreadMessages(userId);
    }
	
	
}

*/
