package com.erunjrun.crew.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CrewViewController {
	
    @GetMapping(value="/crewWriteView")
    public String crewWriteView() {
        return "crew/crewWrite";
    }
    
    @GetMapping(value="/crewUpdateView")
    public String crewUpdateView() {
        return "crew/crewUpdate";
    }

}
