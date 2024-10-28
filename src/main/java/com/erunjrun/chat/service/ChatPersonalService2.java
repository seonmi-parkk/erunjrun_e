/*
package com.erunjrun.chat.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketHandler;

import com.erunjrun.chat.dao.ChatPersonalDAO_bf;
import com.erunjrun.chat.dto.ChatPersonalDTO;
import com.erunjrun.chat.websocket.MyWebSocketHandler_bf;
import com.erunjrun.main.dao.MainDAO;

@Service
public class ChatPersonalService {

	@Autowired ChatPersonalDAO_bf chatPersonalDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MyWebSocketHandler_bf myWebSocketHandler;
	
	// 메시지 저장
	public void saveMessage(ChatPersonalDTO chatPersonalDTO) {
		 chatPersonalDAO.save(chatPersonalDTO); // db에 저장
	}
	
	// 수신자 접속 상태 확인
	public boolean isUserOnline(String recipient) {
		return myWebSocketHandler.isUserConnected(recipient);
	}
	
	   // 웹소켓을 통해 메시지 실시간 전송
	public void sendMessageSocket(ChatPersonalDTO chatPersonalDTO) throws Exception {
		myWebSocketHandler.sendMessageToUser(chatPersonalDTO.getRecipient(), chatPersonalDTO.getContent());
	}
	
	 // 읽지 않은 메시지 가져오기
    public List<ChatPersonalDTO> getUnreadMessages(String receiver) {
        return chatPersonalDAO.findByReceiverAndIsReadFalse(receiver);  // DB에서 읽지 않은 메시지 조회
    }
	
	
//	서비스부터 이어서 하면 됨!!!!
	
	
	
}
*/
