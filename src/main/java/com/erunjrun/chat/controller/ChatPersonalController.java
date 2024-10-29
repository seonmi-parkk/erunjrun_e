package com.erunjrun.chat.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.chat.dto.ChatPersonalDTO;
import com.erunjrun.chat.service.ChatPersonalService;



@Controller
public class ChatPersonalController {

	@Autowired ChatPersonalService chatPersonalService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	 @GetMapping("/chat/{id}/{unlikeId}")
	 @ResponseBody
     public Map<String, Object> getChat(@PathVariable String id, @PathVariable String unlikeId, HttpSession session, Model model){
		 Map<String, Object> data = new HashMap<String, Object>();

		 //check!! 임시세션 나중에 빼기
		session.setAttribute("loginId", "kimee01");
		logger.info("id: {}, unlikeId: {}",id,unlikeId);
		// 채팅방 넘버 체크
		String roomNum = chatPersonalService.getRoomNum(id,unlikeId);
		logger.info("roomNum"+roomNum);
		//model.addAttribute("roomNum", roomNum);
		// 없으면 생성
		if(roomNum == null) {
			roomNum = chatPersonalService.createRoom(id,unlikeId);
		}
		
		data.put("roomNum", roomNum);
        return data;
    }
	 
	 @GetMapping("chat/{roomNum}")
     public String openChat(@PathVariable String roomNum, Model model){
		 model.addAttribute("roomNum", roomNum);
        return "chat/personalChat";
    }

	 @GetMapping("/chat/data/{chatIdx}")
	 @ResponseBody
	 public Map<String, Object> getContent(@PathVariable String chatIdx, HttpSession session){
		
		 String baseUser = (String) session.getAttribute("loginId");
		 Map<String, Object> values = chatPersonalService.getContent(chatIdx, baseUser);
		 
		 return values;
	 }
	
}


