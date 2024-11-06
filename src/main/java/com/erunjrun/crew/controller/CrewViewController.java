package com.erunjrun.crew.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.erunjrun.crew.service.CrewService;
import com.erunjrun.member.dto.MemberDTO;

@Controller
public class CrewViewController {
	
	@Autowired CrewService crew_service;
	
    @GetMapping(value="/crewWrite")
    public String crewWriteView(HttpSession session) {
        if(session.getAttribute("loginId") != null) {
        	return "/crew/crewWrite";
    	}
    	return "redirect:/loginView";
    }
    
    // 크루 수정!
    @GetMapping(value="/crewUpdate/{crew_idx}")
    public String crewUpdateView(@PathVariable int crew_idx, Model model, HttpSession session) {
    	
    	String loginId = (String) session.getAttribute("loginId");
    	if(loginId != null) {
    		model.addAttribute("crew_idx", crew_idx);
    		String leaderId = crew_service.crewLocationLeaderCheck(loginId, crew_idx);
    		if(leaderId != null) {
    			model.addAttribute("leaderId", leaderId);
    		}
    		return "/crew/crewUpdate";
    	}
    	return "redirect:/loginView";
    }


    @GetMapping(value="/crewDetail/{crew_idx}")
    public String crewDetailView(@PathVariable int crew_idx, Model model, HttpSession session) {
    	model.addAttribute("crew_idx", crew_idx);
    	model.addAttribute("notice_date", crew_service.crewNoriceDate(crew_idx));
    	model.addAttribute("crewChatMin", crew_service.crewChatMin(crew_idx));
    	return "/crew/crewDetail";
    }
    
    @GetMapping(value="/crewList")
    public String crewListView() {
    	return "/crew/crewList";
    }
    
    @GetMapping(value="/crewMemberList/{crew_idx}")
    public String crewMemberListView(@PathVariable int crew_idx, Model model, HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	if(loginId != null) {
    		model.addAttribute("crew_idx", crew_idx);
    		String leaderId = crew_service.crewLocationLeaderCheck(loginId, crew_idx);
    		if(leaderId != null) {
    			model.addAttribute("leaderId", leaderId);
    		}
    		return "/crew/crewMemberList";
    	}
    	return "redirect:/loginView";
    }
    
    @GetMapping(value="/crewAuthorityList/{crew_idx}")
    public String crewAuthorityListView(@PathVariable int crew_idx, Model model, HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	if(loginId != null) {
    		model.addAttribute("crew_idx", crew_idx);
    		String leaderId = crew_service.crewLocationLeaderCheck(loginId, crew_idx);
    		if(leaderId != null) {
    			model.addAttribute("leaderId", leaderId);
    		}
    		return "/crew/crewAuthorityList";
    	}
    	return "redirect:/loginView";
    }
    
    @GetMapping(value="/crewManagerList/{crew_idx}")
    public String crewManagerView(@PathVariable int crew_idx, Model model, HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	if(loginId != null) {
    		model.addAttribute("crew_idx", crew_idx);
    		String leaderId = crew_service.crewLocationLeaderCheck(loginId, crew_idx);
    		if(leaderId != null) {
    			model.addAttribute("leaderId", leaderId);
    		}
    		return "/crew/crewManagerList";
    	}
    	return "redirect:/loginView";
    }
    
    @GetMapping(value="/crewNoticeList/{crew_idx}")
    public String crewNoticeListView(@PathVariable int crew_idx, Model model, HttpSession session) {
    	if(session.getAttribute("loginId") != null) {
    		model.addAttribute("crew_idx", crew_idx);
    		return "/crew/crewNoticeList";
    	}
    	return "redirect:/loginView";
    }
    
    @GetMapping(value="/crewNoticeWrite/{crew_idx}")
    public String crewNoticeWrete(@PathVariable int crew_idx, Model model, HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	if(loginId != null) {
    		model.addAttribute("crew_idx", crew_idx);
    		String leaderId = crew_service.crewLocationLeaderCheck(loginId, crew_idx);
    		if(leaderId != null) {
    			model.addAttribute("leaderId", leaderId);
    		}
    		return "/crew/crewNoticeWrite";
    	}
    	return "redirect:/loginView";
    }
    
    @RequestMapping(value="/crewNoticeDetail/{notice_idx}")
    public String crewNoticeDetailView(@PathVariable int notice_idx, Model model, HttpSession session) {
    	
    	String loginId = (String) session.getAttribute("loginId");
    	
    	MemberDTO nick = crew_service.nickName(loginId);
    	
    	if(loginId != null) {
    		model.addAttribute("notice_idx", notice_idx);
//    		model.addAttribute("detail", crew_service.crewNoticeDelete(notice_idx));
    		model.addAttribute("nickname", nick);
    		return "crew/crewNoticeDetail";
    	}
    	return "redirect:/loginView";
    }

    @GetMapping(value="/crewNoticeUpdate/{notice_idx}")
    public String crewNoticeUpdateView(@PathVariable int notice_idx, Model model, HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	if(loginId != null) {
    		model.addAttribute("result", crew_service.crewNoticeUpdateView(notice_idx));
    		model.addAttribute("notice_idx", notice_idx);
    		String leaderId = crew_service.crewNoticeLeaderCheck(loginId, notice_idx);
    		if(leaderId != null) {
    			model.addAttribute("leaderId", leaderId);
    		}
    		return "crew/crewNoticeUpdate";
    	}
    	return "redirect:/loginView";
    }
    
    @RequestMapping(value="/crewChatListView/{crew_idx}")
    public String crewChatListView(@PathVariable String crew_idx, Model model, HttpSession session) {
    	if(session.getAttribute("loginId") != null) {
    		model.addAttribute("crew_idx", crew_idx);
    		return "crew/crewChatList";
    	}
    	return "redirect:/loginView";
    }

    
}
