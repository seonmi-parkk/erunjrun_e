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

	
	 public Map<String, Object> memberlist(int page, int cnt) {
	 logger.info("현재페이지 :"+page); 
	 logger.info("한페이지에 보여줄 갯수 :"+cnt);
	  
	 int limit = cnt;
	 int offset = (page-1)*cnt;
	 int totalPage = admin_dao.count(cnt);
	  
	 Map<String, Object> result = new HashMap<String, Object>();
	 result.put("totalPages", totalPage); 
	 result.put("currPage", page);
	 result.put("list", admin_dao.memberlist(limit,offset));
	 
	 
	 
	 return result; }


	
	 
//	public List<AdminDTO> memberlist(int page_, int cnt_) {
//		
//		return admin_dao.memberlist();
//	}
	
}
