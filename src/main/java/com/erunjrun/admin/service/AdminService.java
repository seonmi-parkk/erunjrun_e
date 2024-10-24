package com.erunjrun.admin.service;

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

	public String getAllowedIp(String id) {
        return admin_dao.getAllowedIp(id);
    }

   public boolean adminLogin(String id, String pw) {
      return admin_dao.adminLogin(id, pw);
   }
   
   public String getAuthority(String id) {
       return admin_dao.getAuthority(id);
   }
	
   public String SgetAllowedIp(String superAdminId) {
	      return admin_dao.getAllowedIp(superAdminId);
	      
	   }

   public boolean adminJoin(String id, String pw, String name,String ip) {
	   
	      return admin_dao.adminJoin(id,pw,name,ip);
	   }
   
   
	public int count(int cnt_) {
		
		return admin_dao.count(cnt_);
	}


	public List<AdminDTO> memberlist(String opt, String keyword, int limit, int offset) {
		
		return admin_dao.memberlist(opt, keyword ,limit, offset);
	}

	public int admincount(int cnt_) {
	
		return admin_dao.admincount(cnt_);
	}

	public List<AdminDTO> adminlist(String opt, String keyword, int limit, int offset) {
	
		return admin_dao.adminlist(opt, keyword, limit, offset);
	}


	public List<AdminDTO> reportlist(String id) {
		
		return admin_dao.reportlist(id);
	}

	public AdminDTO memberdetail(String id) {
		
		return admin_dao.memberdetail(id);
	}

	public List<AdminDTO> ban(String id) {
		
		return admin_dao.ban(id);
	}

	
	public String right(String nickname) {
		
		return admin_dao.right(nickname);
	}

	public void rightwrite(Map<String, String> param) {
		String code_name =param.get("code_name");
		 String admin_id_ =param.get("admin_id");
		 String id =param.get("id");
		 String start_date =param.get("start_date");
		 String end_date =param.get("end_date");
		 String content =param.get("content");
		 admin_dao.rightwrite(param);
		 
		 logger.info(code_name+admin_id_+id+start_date+end_date+content);
		
	}

	public AdminDTO rightdetail(String id) {
		
		return admin_dao.rightdetail(id);
	}

	public void rightupdate(Map<String, String> param) {
		admin_dao.rightupdate(param);
		
	}


	


	
	 

	
}