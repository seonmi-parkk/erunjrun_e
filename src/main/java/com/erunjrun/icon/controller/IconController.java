package com.erunjrun.icon.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.icon.dto.IconDTO;
import com.erunjrun.icon.service.IconService;

@Controller
public class IconController {
	
	@Autowired IconService iconService;

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@GetMapping(value = "icon")
	public String icon(){
		
	
		return"";
		
	}
		@GetMapping(value = "adminIconChart")
		  public String iconchart() {
			  
			  return "icon/adminIconChart";
		  
		}
		
		  @GetMapping(value = "adminIconCharList")
		  @ResponseBody
		  public Map<String, Object> iconchart(String page, String cnt,String agegroup) {
				int page_ = Integer.parseInt(page);
				int cnt_ = Integer.parseInt(cnt);
				int ageGroup = Integer.parseInt(agegroup);
				
				int startAge = (agegroup != null)? ageGroup: 0;
				int endAge = (agegroup != null)? ageGroup+9: 100;
				int limit = cnt_;
				int offset = (page_ - 1) * cnt_;
				int totalPages = iconService.iconchartcount(cnt_);
				
				Map<String,Object> result = new HashMap<String, Object>();
				List<IconDTO> list = iconService.iconchart(limit,offset,startAge,endAge);
				result.put("totalPages", totalPages);
				result.put("currpage", page);
				result.put("list", list);
			  
			  return result;
		  }
		  
		  
		  @GetMapping(value = "adminIconBuy")
		  public String iconbuy(int icon_idx,Model model) {
			  
			  model.addAttribute("info",icon_idx);
			  logger.info(""+icon_idx);
			  return "icon/adminIconBuyList";
		  }
		  
		  @GetMapping(value = "adminIconBuyList")
		  @ResponseBody
		  public Map<String, Object> iconbuylist(String icon_idx,String page, String cnt) {
			logger.info("아이콘번호"+icon_idx);
			int page_ = Integer.parseInt(page);
			int cnt_ = Integer.parseInt(cnt);
			int icon_idx_ =Integer.parseInt(icon_idx);
			int limit = cnt_;
			int offset = (page_ - 1) * cnt_;
			int totalPages = iconService.iconbuycount(cnt_);
			
			
			Map<String,Object> result = new HashMap<String, Object>();
			result.put("totalPages", totalPages);
			result.put("currpage", page);
			result.put("list", iconService.iconbuylist(icon_idx_,limit,offset));
			
			  
			  return result;
		  }
		  	
		
		
	
}
