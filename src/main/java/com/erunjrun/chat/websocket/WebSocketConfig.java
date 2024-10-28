package com.erunjrun.chat.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.RequiredArgsConstructor;


@Configuration
@RequiredArgsConstructor
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	 private final MyWebSocketHandler myWebSocketHandler;

 	//내가 추가
	public WebSocketConfig(MyWebSocketHandler myWebSocketHandler) {
		this.myWebSocketHandler = myWebSocketHandler;
	}
	 
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    
        registry.addHandler(myWebSocketHandler, "ws/chat").setAllowedOrigins("*");
    }
	
	

}
