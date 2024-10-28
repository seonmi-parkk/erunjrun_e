package com.erunjrun.chat.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.chat.dao.ChatPersonalDAO;
import com.erunjrun.chat.dto.ChatPersonalDTO;

@Service
public class ChatPersonalService {

	@Autowired ChatPersonalDAO chatPersonalDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public  List<ChatPersonalDTO> getContent(String chatIdx, String baseUser) {
		return chatPersonalDAO.getContent(chatIdx, baseUser);
	}
	
	
	
	
	
}

