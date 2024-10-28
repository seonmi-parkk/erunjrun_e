package com.erunjrun.chat.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

// 사용자의 웹소켓 세션 관리
@Component //check!! 얘는 왜하는거지 체크??
public class MyWebSocketHandler extends TextWebSocketHandler {
	
	Logger log = LoggerFactory.getLogger(getClass());
	
	 private static List<WebSocketSession> list = new ArrayList<>();
	 
	    @Override
	    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	        String payload = message.getPayload();
	        log.info("payload : " + payload);

	        for(WebSocketSession sess: list) {
	            sess.sendMessage(message);
	        }
	    }

	    /* Client가 접속 시 호출되는 메서드 */
	    @Override
	    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

	        list.add(session);

	        log.info(session + " 클라이언트 접속");
	    }

	    /* Client가 접속 해제 시 호출되는 메서드드 */

	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

	        log.info(session + " 클라이언트 접속 해제");
	        list.remove(session);
	    }
	
	
	
}
