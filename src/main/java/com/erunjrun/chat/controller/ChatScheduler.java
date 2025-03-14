package com.erunjrun.chat.controller;

import com.erunjrun.chat.service.ChatPersonalService;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@EnableScheduling
@Component
public class ChatScheduler {

	private final ChatPersonalService chatPersonalService;
	public ChatScheduler(ChatPersonalService chatPersonalService) {
		this.chatPersonalService = chatPersonalService;
	}

	@Scheduled(cron = "0 0 0  * * ? ")
	public void deleteChatData() {
		chatPersonalService.deleteChatData();
	}
}
