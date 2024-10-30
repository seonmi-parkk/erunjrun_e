package com.erunjrun.main.service;

import java.time.LocalDate;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.admin.dto.PopupDTO;
import com.erunjrun.main.dao.MainDAO;

@Service
public class MainService {

	@Autowired MainDAO mainDAO;

	public List<PopupDTO> getActivePopups() {
        LocalDate today = LocalDate.now();
        return mainDAO.getActivePopups(today);
    }
	

	
}
