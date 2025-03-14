package com.erunjrun.chat.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.chat.dao.ChatPersonalDAO;
import com.erunjrun.chat.dto.ChatCrewLeaderDTO;
import com.erunjrun.chat.dto.ChatPersonalDTO;

@Service
public class ChatPersonalService {

	private final ChatPersonalDAO chatPersonalDAO;

	public ChatPersonalService(ChatPersonalDAO chatPersonalDAO) {
		this.chatPersonalDAO = chatPersonalDAO;
	}

	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	public Map<String, Object> getContent(String chatIdx, String baseUser) {
		Map<String, Object> values = new HashMap<String, Object>();
		String otherUser = chatPersonalDAO.getOtherUser(chatIdx, baseUser);
		boolean blockYn = chatPersonalDAO.checkBlock(chatIdx, baseUser,otherUser) > 0;
		
		List<ChatPersonalDTO> userList = chatPersonalDAO.getUserName(chatIdx);
		List<ChatPersonalDTO> msgList = chatPersonalDAO.getContent(chatIdx, baseUser);
		
		// 날짜 비교 (날짜 바뀔경우 체크)
		LocalDate previousDate = null;
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
	    
        for(ChatPersonalDTO msg : msgList) {
        	LocalDate msgDate = msg.getStart_date().toLocalDate();
        	
        	if(previousDate == null || !msgDate.equals(previousDate)) {
        		msg.setFirstOfDay(msgDate.format(dateFormatter));
        		previousDate = msgDate;
        	}
        }

        values.put("userList", userList);
        values.put("msgList", msgList);
        values.put("blockYn", blockYn);
		return values;
	}


	public String getRoomNum(String id, String unlikeId) {
		return chatPersonalDAO.getRoomNum(id,unlikeId);
	}


	public String createRoom(String id, String unlikeId) {
		Date today = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		ChatPersonalDTO dto = new ChatPersonalDTO();
		dto.setCreate_date(dateFormat.format(today));
		
		String chat_idx = null;
		if(chatPersonalDAO.createRoom(dto)>0) {
			chat_idx = dto.getChat_idx();
			chatPersonalDAO.linkRoom(chat_idx,id,unlikeId);
		}
		return chat_idx;
	}

	public boolean sendMessage(Map<String, Object> param) {
		return chatPersonalDAO.sendMessage(param) > 0;
	}

	public boolean exitRoom(String chatIdx, String user) {
		return chatPersonalDAO.exitRoom(chatIdx,user) > 0;
	}

	// 3년 지난 데이터 삭제
	public void deleteChatData() {
		chatPersonalDAO.deleteChatData();
	}

	public String getCrewLeaderChat(String crewIdx, String baseUser) {
		return chatPersonalDAO.getCrewLeaderChat(crewIdx, baseUser);
	}

	public Map<String, Object> getCrewLeaderContent(String chatIdx, String baseUser) {
		Map<String, Object> values = new HashMap<String, Object>();
		String otherUser = chatPersonalDAO.getCrewLeaderOtherUser(chatIdx, baseUser);
		boolean blockYn = chatPersonalDAO.crewLeadercheckBlock(chatIdx, baseUser,otherUser) > 0 ;
		
		List<ChatCrewLeaderDTO> userList = chatPersonalDAO.getCrewLeaderUserName(chatIdx);
		List<ChatCrewLeaderDTO> msgList = chatPersonalDAO.getCrewLeaderContent(chatIdx);
		
		// 날짜 비교 (날짜 바뀔경우 체크)
		LocalDate previousDate = null;
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
	    
        for(ChatCrewLeaderDTO msg : msgList) {
        	LocalDate msgDate = msg.getCreate_date().toLocalDate();
        	if(previousDate == null || !msgDate.equals(previousDate)) {
        		msg.setFirstOfDay(msgDate.format(dateFormatter));
        		previousDate = msgDate;
        	}
        }
        
        values.put("userList", userList);
        values.put("msgList", msgList);
        values.put("blockYn", blockYn);
		return values;
	}

	public String createCrewLeaderRoom(String crewIdx, String baseUser) {
		ChatCrewLeaderDTO dto = new ChatCrewLeaderDTO();
		dto.setCrew_idx(crewIdx);
		String chatIdx = "";
		// crew_chat 테이블 생성
		if(chatPersonalDAO.createCrewLeaderRoom(dto) > 0 ) {
			chatIdx = dto.getChat_idx();
			String readerId = chatPersonalDAO.getLeaderId(crewIdx);
			// crew_chat_link 테이블 생성
			chatPersonalDAO.createCrewLinkTable(chatIdx,baseUser,readerId);
		}
		return chatIdx;
	}

	public Object sendCrewLeaderMessage(Map<String, Object> param) {
		return chatPersonalDAO.sendCrewLeaderMessage(param) > 0;
	}

	public Object exitCrewLeaderRoom(String chatIdx, String user) {
		return chatPersonalDAO.exitCrewLeaderRoom(chatIdx, user) > 0;
	}

	public List<ChatCrewLeaderDTO> crewLeaderChatList(String crew_idx) {
		return chatPersonalDAO.crewLeaderChatList(crew_idx);
	}

	public List<ChatCrewLeaderDTO> crewLeaderChatListFull(int crew_idx, int page, int cnt, String keyword) {
		int limit = cnt;
		int offset = (page -1) * cnt;
		
		Map<String, Object> parmeterMap = new HashMap<>();
		parmeterMap.put("limit", limit);
		parmeterMap.put("offset", offset);
		parmeterMap.put("keyword", keyword);
		parmeterMap.put("crew_idx", crew_idx);
		
		List<ChatCrewLeaderDTO> list = chatPersonalDAO.crewLeaderChatListFull(parmeterMap);
		return list; 
	}

	public boolean checkBlocked(String from_id, String id) {
		return chatPersonalDAO.checkBlocked(from_id,id) > 0;
	}
	
}

