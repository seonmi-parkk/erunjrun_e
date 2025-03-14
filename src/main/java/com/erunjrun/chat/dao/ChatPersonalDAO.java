package com.erunjrun.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.chat.dto.ChatCrewLeaderDTO;
import com.erunjrun.chat.dto.ChatPersonalDTO;

@Mapper
public interface ChatPersonalDAO {

	List<ChatPersonalDTO> getContent(String chatIdx, String baseUser);

	List<ChatPersonalDTO> getUserName(String chatIdx);

	String getRoomNum(String id, String unlikeId);

	int createRoom(ChatPersonalDTO dto);

	int linkRoom(String chat_idx, String id, String unlikeId);

	int sendMessage(Map<String, Object> param);

	int exitRoom(String chatIdx, String user);

	void deleteChatData();

	String getCrewLeaderChat(String crewIdx, String baseUser);

	int createCrewLeaderRoom(ChatCrewLeaderDTO dto);

	String getLeaderId(String crewIdx);

	int createCrewLinkTable(String chatIdx, String baseUser, String readerId);

	List<ChatCrewLeaderDTO> getCrewLeaderUserName(String chatIdx);

	List<ChatCrewLeaderDTO> getCrewLeaderContent(String chatIdx);

	int sendCrewLeaderMessage(Map<String, Object> param);

	int exitCrewLeaderRoom(String chatIdx, String user);

	List<ChatCrewLeaderDTO> crewLeaderChatList(String crew_idx);

	List<ChatCrewLeaderDTO> crewLeaderChatListFull(Map<String, Object> parmeterMap);

	int checkBlock(String chatIdx, String baseUser, String otherUser);

	String getOtherUser(String chatIdx, String baseUser);

	String getCrewLeaderOtherUser(String chatIdx, String baseUser);

	int crewLeadercheckBlock(String chatIdx, String baseUser, String otherUser);

	int checkBlocked(String from_id, String id);


}
