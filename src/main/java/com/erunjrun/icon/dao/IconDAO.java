package com.erunjrun.icon.dao;

import com.erunjrun.icon.dto.IconDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface IconDAO {

	public List<IconDTO> iconbuylist(int icon_idx,int limit, int offset);

	public int iconbuycount(int cnt_, String icon_idx);

	public List<IconDTO> iconchart(int limit, int offset, int startAge, int endAge);

	public int iconchartcount(int cnt_, int startAge, int endAge);

	public List<IconDTO> getIconList(String userId);

	public IconDTO getUserInfo(String userId);

	public int buyIcon(String iconIdx, String userId);

	public int deductPoint(String iconIdx, String userId);

	public int checkPoint(String userId);

	public int updateMemberTable(String userId);

	public List<IconDTO> adminIconList(int limit, int offset);

	public int adminIconWrite(Map<String, String> param);

	public IconDTO adminIconData(String icon_idx);

	public int adminIconUpdate(Map<String, String> param);

	public List<IconDTO> getMonthlySalesData(Integer year);

	public List<IconDTO> getDailySalesData(Integer year, Integer month);

	public List<IconDTO> getWeeklySalesData(Integer year, Integer month);

	public List<Integer> getAvailableYears();


	
	
	
}
