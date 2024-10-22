package com.erunjrun.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.admin.dto.AdminDTO;

@Mapper
public interface AdminDAO {

	/* List<AdminDTO> list(int limit, int offset); */

	

	List<AdminDTO> memberlist(int limit, int offset);

	int count(int cnt);

}
