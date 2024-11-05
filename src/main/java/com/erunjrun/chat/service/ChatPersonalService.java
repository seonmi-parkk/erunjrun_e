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

	@Autowired ChatPersonalDAO chatPersonalDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	public Map<String, Object> getContent(String chatIdx, String baseUser) {
		Map<String, Object> values = new HashMap<String, Object>();
		
		List<ChatPersonalDTO> userList = chatPersonalDAO.getUserName(chatIdx);
		logger.info("userNames: "+userList.get(0).getNickname());
		// userNames들어오는지 check하고 위에 values에 아래 list랑 usernames넣어서 컨트롤러 보내기
		// 컨트롤러도 수정해야함.
		List<ChatPersonalDTO> msgList = chatPersonalDAO.getContent(chatIdx, baseUser);
		//logger.info("msgList getContent: "+msgList.get(0).getContent());
		
		// 날짜 비교 (날짜 바뀔경우 체크)
		LocalDate previousDate = null;
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
	    
        for(ChatPersonalDTO msg : msgList) {
        	LocalDate msgDate = msg.getStart_date().toLocalDate();
        	//logger.info("msg.getStart_date(): "+msg.getStart_date());
        	//logger.info("msgDate: "+msgDate);
        	
        	if(previousDate == null || !msgDate.equals(previousDate)) {
        		//logger.info("previousDate: "+previousDate);
        		//logger.info("msgDate: "+msgDate);
        		//logger.info("msgDate.format(dateFormatter): "+msgDate.format(dateFormatter));
        		msg.setFirstOfDay(msgDate.format(dateFormatter));
        		
        		previousDate = msgDate;

        	}
        }
        
        //logger.info("getFirstOfDay: "+ msgList.get(0).getFirstOfDay());
        
        values.put("userList", userList);
        values.put("msgList", msgList);
		return values;
	}


	public String getRoomNum(String id, String unlikeId) {
		logger.info("id: {}, unlikeId: {}",id,unlikeId);
		return chatPersonalDAO.getRoomNum(id,unlikeId);
	}


	public String createRoom(String id, String unlikeId) {
		Date today = new Date();

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		logger.info(" dateFormat.format(today): "+ dateFormat.format(today));
		
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
		return chatPersonalDAO.sendMessage(param)>0 ? true : false;
	}


	public boolean exitRoom(String chatIdx, String user) {
		return chatPersonalDAO.exitRoom(chatIdx,user) > 0 ? true : false;
	}

	// 3년 지난 데이터 삭제
	public void deleteChatData() {
		chatPersonalDAO.deleteChatData();
	}


	public String getCrewLeaderChat(String crewIdx, String baseUser) {
		logger.info("crewIdx : {}, baseUser: {}",crewIdx,baseUser);
		return chatPersonalDAO.getCrewLeaderChat(crewIdx, baseUser);
	}



	public Map<String, Object> getCrewLeaderContent(String chatIdx, String baseUser) {
		 logger.info("/crewLdchat/data service 시작");
		Map<String, Object> values = new HashMap<String, Object>();
		
		List<ChatCrewLeaderDTO> userList = chatPersonalDAO.getCrewLeaderUserName(chatIdx);
		logger.info("userNames"+userList.get(0).getNickname());
		//logger.info("1user is leader"+userList.get(0).getIs_leader());
		//logger.info("2user is leader"+userList.get(1).getIs_leader());

		List<ChatCrewLeaderDTO> msgList = chatPersonalDAO.getCrewLeaderContent(chatIdx);
		logger.info("메세지 내용: " + msgList.get(0).getContent());
		
		// 날짜 비교 (날짜 바뀔경우 체크)
		LocalDate previousDate = null;
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
	    
        for(ChatCrewLeaderDTO msg : msgList) {
        	logger.info("msg.getContent() : "+msg.getContent());

        	LocalDate msgDate = msg.getCreate_date().toLocalDate();
        	logger.info("msg.getStart_date(): "+msg.getCreate_date());
        	logger.info("msgDate: "+msgDate);
        	
        	if(previousDate == null || !msgDate.equals(previousDate)) {
        		logger.info("previousDate: "+previousDate);
        		logger.info("msgDate: "+msgDate);
        		logger.info("msgDate.format(dateFormatter): "+msgDate.format(dateFormatter));
        		msg.setFirstOfDay(msgDate.format(dateFormatter));
        		previousDate = msgDate;
        	}
        	
        }
        
        values.put("userList", userList);
        values.put("msgList", msgList);
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
		return chatPersonalDAO.sendCrewLeaderMessage(param)>0 ? true : false;
	}


	public Object exitCrewLeaderRoom(String chatIdx, String user) {
		return chatPersonalDAO.exitCrewLeaderRoom(chatIdx, user) > 0 ? true : false;
	}


	public List<ChatCrewLeaderDTO> crewLeaderChatList(String crew_idx) {
		return chatPersonalDAO.crewLeaderChatList(crew_idx);
	}


	public List<ChatCrewLeaderDTO> crewLeaderChatListFull(int crew_idx, int page, int cnt, String keyword) {
		int limit = cnt; // 15
		int offset = (page -1) * cnt; // 0
		
		Map<String, Object> parmeterMap = new HashMap<>();
		parmeterMap.put("limit", limit);
		parmeterMap.put("offset", offset);
		parmeterMap.put("keyword", keyword);
		parmeterMap.put("crew_idx", crew_idx);
		
		List<ChatCrewLeaderDTO> list = chatPersonalDAO.crewLeaderChatListFull(parmeterMap);

		return list; 
	}


	
	
	
	
}

