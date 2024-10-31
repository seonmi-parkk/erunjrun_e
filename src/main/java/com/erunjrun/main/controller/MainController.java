package com.erunjrun.main.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.erunjrun.admin.dto.PopupDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.main.service.MainService;

@Controller
public class MainController {

	@Autowired MainService mainService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/")
	public String main(HttpSession session,Model model) {

		 List<PopupDTO> popups = mainService.getActivePopups();
		 for (PopupDTO popup : popups) {
			 int popup_idx = popup.getPopup_idx();
			 String code_name = popup.getCode_name();
			 ImageDTO dto = mainService.image(popup_idx,code_name);
			 if (dto != null) {
				 model.addAttribute("file",dto);
				}
			}
	     model.addAttribute("popups", popups);
		
		if (popups.isEmpty()) {
			logger.info("팝업X");
		}else {
			logger.info("팝업 O");
		}
	     
	     
		//check!!임시 세션(나중에 빼기)
		session.setAttribute("loginId", "crewtest9");
		session.setAttribute("profileImg", "profile_img1.jpg");
		session.setAttribute("iconImg", "resources/img/icon/icon1.png");
		session.setAttribute("adminYn", "N");
		return "main";
	}


	
}
