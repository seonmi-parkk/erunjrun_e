/*
package com.erunjrun.chat.websocket;

import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

public class WebSocketConfig_bf implements WebSocketConfigurer {

	private final MyWebSocketHandler_bf myWebSocketHandler;
	
	public WebSocketConfig_bf(MyWebSocketHandler_bf myWebSocketHandler) {
		this.myWebSocketHandler = myWebSocketHandler;
	}
	
//	여기부분 약간 다름 check!!
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(myWebSocketHandler, "/chat").setAllowedOrigins("*");
	}
	
	

}
*/