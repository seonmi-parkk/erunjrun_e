package com.erunjrun.chat.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.erunjrun.chat.service.ChatPersonalService;

@EnableScheduling
@Component
public class ChatScheduler {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatPersonalService chatPersonalService;
	
	@Scheduled(cron = "0 0 0  * * ? ")
	public void deleteChatData() {
		chatPersonalService.deleteChatData();
	}
}
