package com.erunjrun.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	
	public int count(int cnt_) {
		
		return admin_dao.count(cnt_);
	}


	public List<AdminDTO> memberlist(int limit, int offset, String keyword) {
		
		return admin_dao.memberlist(limit, offset, keyword);
	}


	public List<AdminDTO> adminlist(int limit, int offset) {
	
		return admin_dao.adminlist(limit, offset);
	}


	
	 
//	public List<AdminDTO> memberlist() {
//		
//		return admin_dao.memberlist();
//	}
	
}