package com.erunjrun.icon.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.icon.dto.IconDTO;

@Mapper
public interface IconDAO {

	public List<IconDTO> iconbuylist(int icon_idx,int limit, int offset);

	public int iconbuycount(int cnt_);

	public List<IconDTO> iconchart(int limit, int offset, int startAge, int endAge);

	public int iconchartcount(int cnt_);

	public List<IconDTO> getIconList(String userId);

	public IconDTO getUserInfo(String userId);

	public int buyIcon(String iconIdx, String userId);

	public int deductPoint(String iconIdx, String userId);

	public int checkPoint(String userId);

	public int updateMemberTable(String userId);

	public List<IconDTO> adminIconList(int limit, int offset);

	public int adminIconWrite(Map<String, String> param);


	
	
	
}
