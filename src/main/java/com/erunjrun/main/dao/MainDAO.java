package com.erunjrun.main.dao;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.admin.dto.PopupDTO;

@Mapper
public interface MainDAO {

	List<PopupDTO> getActivePopups(LocalDate today);
	
	

}
