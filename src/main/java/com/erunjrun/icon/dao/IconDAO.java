package com.erunjrun.icon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.icon.dto.IconDTO;

@Mapper
public interface IconDAO {

	public List<IconDTO> iconbuylist(int icon_idx,int limit, int offset);

	public int iconbuycount(int cnt_);

	public List<IconDTO> iconchart(int limit, int offset, int startAge, int endAge);

	public int iconchartcount(int cnt_);

	
	
	
}
