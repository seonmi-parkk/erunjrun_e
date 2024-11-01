package com.erunjrun.main.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.admin.dto.PopupDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.main.dao.MainDAO;

@Service
public class MainService {

	@Autowired MainDAO mainDAO;

	public List<PopupDTO> getActivePopups() {
        LocalDate today = LocalDate.now();
        return mainDAO.getActivePopups(today);
    }

	public ImageDTO image(int popup_idx, String code_name) {
		
		return mainDAO.image(popup_idx,code_name);
	}
	

	
}
