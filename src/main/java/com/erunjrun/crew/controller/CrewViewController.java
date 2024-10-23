package com.erunjrun.crew.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.erunjrun.crew.service.CrewService;

@Controller
public class CrewViewController {
	
	@Autowired CrewService crew_service;
	
    @GetMapping(value="/crewWriteView")
    public String crewWriteView() {
        return "crew/crewWrite";
    }
    
    @GetMapping(value="/crewUpdateView")
    public String crewUpdateView(Model model) {
    	
    	int crew_idx = 39;
    	
    	Map<String, Object> resultMap = crew_service.crewUpdate(crew_idx);
    	
    	model.addAttribute("result", resultMap);
    	
        return "crew/crewUpdate";
    }

}
