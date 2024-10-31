package com.erunjrun.main.dao;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.admin.dto.PopupDTO;
import com.erunjrun.image.dto.ImageDTO;

@Mapper
public interface MainDAO {

	List<PopupDTO> getActivePopups(LocalDate today);

	ImageDTO image(int popup_idx, String code_name);
	
	

}
