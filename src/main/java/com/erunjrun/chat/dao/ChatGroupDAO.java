package com.erunjrun.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.chat.dto.ChatCrewDTO;
import com.erunjrun.chat.dto.ChatCrewLeaderDTO;
import com.erunjrun.crew.dto.CrewDTO;

@Mapper
public interface ChatGroupDAO {

	String getCrewChat(String crewIdx);

	CrewDTO getCrewInfo(String chatIdx);

	String getCrewLeader(String chatIdx);

	List<ChatCrewDTO> getCrewContent(String chatIdx);

	int sendCrewMessage(Map<String, Object> param);



}
