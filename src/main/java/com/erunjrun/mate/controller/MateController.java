package com.erunjrun.mate.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.erunjrun.mate.service.MateService;

@Controller
public class MateController {

	@Autowired MateService mateService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/mate")
	public String mateApplication() {
		return "";
	}
}
