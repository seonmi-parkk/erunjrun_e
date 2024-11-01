package com.erunjrun.icon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.icon.dao.IconDAO;
import com.erunjrun.icon.dto.IconDTO;

@Service
public class IconService {
	
	@Autowired IconDAO iconDAO;

	
	
	// 구매리스트
	public List<IconDTO> iconbuylist(int icon_idx,int limit, int offset) {
		
		return iconDAO.iconbuylist(icon_idx,limit,offset);
	}

	public int iconbuycount(int cnt_) {
		
		return iconDAO.iconbuycount(cnt_);
	}


// 아이콘 차트
	public List<IconDTO> iconchart(int limit, int offset, int startAge, int endAge) {
		
		return  iconDAO.iconchart(limit,offset,startAge,endAge);
	}

	public int iconchartcount(int cnt_) {
	
		return iconDAO.iconchartcount(cnt_);
	}

	

	
	
}
