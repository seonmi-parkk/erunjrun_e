package com.erunjrun.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.chat.dto.ChatPersonalDTO;

@Mapper
public interface ChatPersonalDAO {

	 List<ChatPersonalDTO> getContent(String chatIdx, String baseUser);

	String[] getUserName(String chatIdx);

	String getRoomNum(String id, String unlikeId);

	//int createRoom(String id, String unlikeId);

	int createRoom(String date);

	int createRoom(ChatPersonalDTO dto);

	int linkRoom(String chat_idx, String id, String unlikeId);


}
