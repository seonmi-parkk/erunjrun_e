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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.chat.dto.ChatCrewDTO;
import com.erunjrun.chat.dto.ChatCrewLeaderDTO;
import com.erunjrun.chat.service.ChatGroupService;
import com.erunjrun.chat.service.ChatPersonalService;
import com.erunjrun.chat.service.SseService;



@Controller
public class ChatGroupController {

	@Autowired ChatGroupService chatGroupService ;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	 
	 @GetMapping("/crewChat/{crewIdx}")
	 @ResponseBody
     public Map<String, Object> getCrewChat(@PathVariable String crewIdx){
		 Map<String, Object> data = new HashMap<String, Object>();
		 
		 // 채팅방 번호 조회
		 String roomNum = chatGroupService.getCrewChat(crewIdx);
		data.put("roomNum", roomNum);
        return data;
    }
	 
	 @GetMapping("/crewChat/open/{crew_idx}/{roomNum}")
     public String openCrewChat(@PathVariable String roomNum, @PathVariable String crew_idx, Model model){
		 model.addAttribute("roomNum", roomNum);
		 model.addAttribute("crewIdx", crew_idx);
        return "chat/crewChat";
    }
	 
	 @GetMapping("/crewChat/data/{chatIdx}")
	 @ResponseBody
	 public Map<String, Object> getCrewContent(@PathVariable String chatIdx, HttpSession session){
		 //String baseUser = (String) session.getAttribute("loginId");
		 Map<String, Object> values = chatGroupService.getCrewContent(chatIdx);
		 
		 
		 
		 List<ChatCrewDTO> list = (List<ChatCrewDTO>) values.get("msgList");
		 for (int num = 0; num<list.size(); num++) {				
			 logger.info("@@@@@@getSender : "+  list.get(num).getSender());
		}
		
		 return values;
	 }
		 
	 
}
