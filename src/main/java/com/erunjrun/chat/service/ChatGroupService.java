package com.erunjrun.chat.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.chat.dao.ChatGroupDAO;
import com.erunjrun.chat.dto.ChatCrewDTO;
import com.erunjrun.chat.dto.ChatCrewLeaderDTO;
import com.erunjrun.crew.dto.CrewDTO;

@Service
public class ChatGroupService {

	private final ChatGroupDAO chatGroupDAO;
	public ChatGroupService(ChatGroupDAO chatGroupDAO) {
		this.chatGroupDAO = chatGroupDAO;
	}

	Logger logger = LoggerFactory.getLogger(getClass());


	public String getCrewChat(String crewIdx) {
		return chatGroupDAO.getCrewChat(crewIdx);
	}

	public Map<String, Object> getCrewContent(String crewIdx, String chatIdx) {
		Map<String, Object> values = new HashMap<String, Object>();
		
		CrewDTO crewInfo = chatGroupDAO.getCrewInfo(crewIdx);
		String crewLeader = chatGroupDAO.getCrewLeader(crewIdx);
		List<ChatCrewDTO> msgList = chatGroupDAO.getCrewContent(chatIdx);
		
		// 날짜 비교 (날짜 바뀔경우 체크)
		LocalDate previousDate = null;
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
	    
        for(ChatCrewDTO msg : msgList) {
        	LocalDate msgDate = msg.getCreate_date().toLocalDate();
        	if(previousDate == null || !msgDate.equals(previousDate)) {
        		msg.setFirstOfDay(msgDate.format(dateFormatter));
        		previousDate = msgDate;
        	}
        }
        
        values.put("crewInfo", crewInfo);
        values.put("crewLeader", crewLeader);
        values.put("msgList", msgList);
		return values;
	}

	public Object sendCrewMessage(Map<String, Object> param) {
		return chatGroupDAO.sendCrewMessage(param) > 0;
	}

	
}

