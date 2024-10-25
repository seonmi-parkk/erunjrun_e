package com.erunjrun.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.admin.dto.AdminDTO;
import com.erunjrun.image.dto.ImageDTO;

@Mapper
public interface AdminDAO {
	
// login,join	
	public String getAllowedIp(String id);

	public boolean adminLogin(String id, String pw); 
	   
	public String getAuthority(String id);
	 
	public boolean adminJoin(String id, String pw, String name, String ip);

	String SgetAllowedIp(String superAdminId);
	
	
//	회원리스트
	public List<AdminDTO> memberlist(String opt, String keyword, int limit, int offset);
	
	int count(int cnt);

	
//	관리자리스트
	public List<AdminDTO> adminlist(String opt, String keyword, int limit, int offset);

	int admincount(int cnt_);

	
//	회원상세페이지
	public AdminDTO memberdetail(String id);

	public List<AdminDTO> memberreportlist(String id);
	
	public List<AdminDTO> ban(String id);

//	권한	
	public String right(String nickname);
	
	public int rightwrite(Map<String, String> param);
	
	public AdminDTO rightdetail(String id);

	public void rightupdate(Map<String, String> param);
	

// 신고	
	public List<AdminDTO> reportlist(int limit, int offset);

	public int reportcount(int cnt_);

	public AdminDTO reportdetail(String report_idx);

	public ImageDTO image(String report_idx);

	public void reportupdate(Map<String, String> param);


	




}

