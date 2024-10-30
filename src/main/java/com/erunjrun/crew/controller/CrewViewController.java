package com.erunjrun.crew.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.erunjrun.crew.service.CrewService;

@Controller
public class CrewViewController {
	
	@Autowired CrewService crew_service;
	
    @GetMapping(value="/crewWrite")
    public String crewWriteView() {
        return "/crew/crewWrite";
    }
    
    @GetMapping(value="/crewUpdate/{crew_idx}")
    public String crewUpdateView(@PathVariable int crew_idx, Model model) {
    	
    	Map<String, Object> resultMap = crew_service.crewUpdateView(crew_idx);
    	
    	model.addAttribute("crew_idx", crew_idx);
    	model.addAttribute("result", resultMap);
    	
        return "/crew/crewUpdate";
    }
    
    @GetMapping(value="/crewDetail/{crew_idx}")
    public String crewDetailView(@PathVariable int crew_idx, Model model) {
    	
    	model.addAttribute("crew_idx", crew_idx);
    	
    	return "/crew/crewDetail";
    }
    
    @GetMapping(value="/crewList")
    public String crewListView() {
    	return "/crew/crewList";
    }
    
    @GetMapping(value="/crewMemberList/{crew_idx}")
    public String crewMemberListView(@PathVariable int crew_idx, Model model) {
    	model.addAttribute("crew_idx", crew_idx);
    	return "/crew/crewMemberList";
    }
    
    @GetMapping(value="/crewAuthorityList/{crew_idx}")
    public String crewAuthorityListView(@PathVariable int crew_idx, Model model) {
    	model.addAttribute("crew_idx", crew_idx);
    	return "/crew/crewAuthorityList";
    }
    
    @GetMapping(value="/crewManagerList/{crew_idx}")
    public String crewManagerView(@PathVariable int crew_idx, Model model) {
    	model.addAttribute("crew_idx", crew_idx);
    	return "/crew/crewManagerList";
    }
    
    @GetMapping(value="/crewNoticeList")
    public String crewNoticeListView() {
    	return "/crew/crewNoticeList";
    }
    
    @GetMapping(value="/crewNoticeWrite")
    public String crewNoticeWrete() {
    	return "/crew/crewNoticeWrite";
    }
    
    @RequestMapping(value="/crewNoticeDetail/{notice_idx}")
    public String crewNoticeDetailView(@PathVariable int notice_idx) {
    	
    	return "crew/crewNoticeDetail";
    }

    @GetMapping(value="/crewNoticeUpdate")
    public String crewNoticeUpdateView() {
    	return "crew/crewNoticeUpdate";
    }
    

    
}
