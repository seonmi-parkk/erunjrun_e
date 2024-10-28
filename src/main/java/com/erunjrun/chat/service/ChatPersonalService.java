package com.erunjrun.chat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.main.dao.MainDAO;

@Service
public class ChatPersonalService {

	@Autowired MainDAO mainDAO;
	
}
