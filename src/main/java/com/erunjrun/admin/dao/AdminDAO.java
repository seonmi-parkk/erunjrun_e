package com.erunjrun.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.admin.dto.AdminDTO;

@Mapper
public interface AdminDAO {
	
	public String getAllowedIp(String id);

	public boolean adminLogin(String id, String pw); 
	   
	public String getAuthority(String id);
	 
	public boolean adminJoin(String id, String pw, String name, String ip);

	String SgetAllowedIp(String superAdminId);
	
	public List<AdminDTO> memberlist(String opt, String keyword, int limit, int offset);
	
	int count(int cnt);

	public List<AdminDTO> adminlist(String opt, String keyword, int limit, int offset);

	int admincount(int cnt_);

	public AdminDTO memberdetail(String id);

	public List<AdminDTO> reportlist(String id);

	




}

