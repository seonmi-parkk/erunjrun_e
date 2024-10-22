package com.erunjrun.crew.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.erunjrun.crew.service.CrewService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CrewController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CrewService cres_service;
	
	@GetMapping(value="/crewWriteView")
	public String crewWriteView() {
		return "crewWrite";
	}

}
