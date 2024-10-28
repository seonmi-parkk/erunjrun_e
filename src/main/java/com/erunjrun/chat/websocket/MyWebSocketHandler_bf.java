package com.erunjrun.chat.websocket;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

// 사용자의 웹소켓 세션 관리
@Component //check!! 얘는 왜하는거지 체크??
public class MyWebSocketHandler_bf extends TextWebSocketHandler {
	
	// 현재 접속 중인 사용자들의 세션을 관리할 맵 (사용자 ID -> 세션)
	private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();

	// 사용자가 웹소멧에 연결되었을때 호출
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// // 예: 사용자 ID는 세션의 Principal에서 가져올 수 있습니다.
		String username = session.getPrincipal().getName(); // 인증된 사용자 아이디 가져오기??? check!!
		sessions.put(username, session);
		System.out.println(username + " 접속되었습니다.");
		//System.out.println("WebSocket connection closed with: "+ session.getId());
		//super.afterConnectionEstablished(session);
	}

	// 특정 사용자에게 메시지 전송
	public void sendMessageToUser(String receiver, String message) throws Exception {
		WebSocketSession session = sessions.get(receiver);
		if(session != null && session.isOpen()) {
			session.sendMessage(new TextMessage(message));
		}else {
			System.out.println("사용자가 접속해 있지 않습니다.");
		}
	}
	
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		/*String payload = message.getPayload();
		System.out.println("Received message : "+ payload);
		
		// 클라이언트에게 응답 전송
		//session.sendMessage(new TextMessage("Server response: "+ payload));
		
	    if (jsonObject.getString("action").equals("register")) {
	        String username = jsonObject.getString("userId");
	        sessions.put(username, session);
	        System.out.println(username + " 접속되었습니다.");
	    } else {
	        // 다른 메시지 처리
	        System.out.println("Received message: " + payload);
	    }*/
		
		ObjectMapper objectMapper = new ObjectMapper();
	    Map<String, Object> jsonMap = objectMapper.readValue(message.getPayload(), Map.class);

	    String action = (String) jsonMap.get("action");
	    if ("register".equals(action)) {
	        String username = (String) jsonMap.get("userId");
	        sessions.put(username, session);
	        System.out.println(username + " 접속되었습니다.");
	    } else {
	        // 다른 메시지 처리
	        System.out.println("Received message: " + message.getPayload());
	    }
	}

	
	
	// 사용자가 웹소켓 연결을 끊었을 때 호출
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String username = session.getPrincipal().getName();
		if(username != null) {			
			sessions.remove(username);
			System.out.println(username + "연결이 종료되었습니다.");
		}
		
		//System.out.println("WebSocket connection closed with: "+ session.getId());
		//super.afterConnectionClosed(session, status);
	}
	
	// 사용자의 접속 상태 확인
	public boolean isUserConnected(String username) {
		WebSocketSession session = sessions.get(username);
		return session != null && session.isOpen(); // 세션이 존재하고 열려있으면 접속중
	}
	
	
	
	
}
