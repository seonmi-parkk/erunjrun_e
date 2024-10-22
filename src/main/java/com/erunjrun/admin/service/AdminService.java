package com.erunjrun.admin.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.admin.dao.AdminDAO;
import com.erunjrun.admin.dto.AdminDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminDAO admin_dao;

	public List<AdminDTO> memberList() {
		
		return admin_dao.memberList();
	}
	
}
