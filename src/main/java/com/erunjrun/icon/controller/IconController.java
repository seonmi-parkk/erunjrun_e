package com.erunjrun.icon.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.icon.dto.IconDTO;
import com.erunjrun.icon.service.IconService;

@Controller
public class IconController {
   
   @Autowired IconService iconService;

   Logger logger = LoggerFactory.getLogger(getClass());
   
   @GetMapping(value = "/icon")
   public String icon(HttpSession session, Model model){
      String userId = (String) session.getAttribute("loginId");
      List<IconDTO> iconList = iconService.getIconList(userId);
      IconDTO userInfoList = iconService.getUserInfo(userId);
      model.addAttribute("iconList", iconList);
      model.addAttribute("userInfoList", userInfoList);
      return "/icon/iconMallList";
   }
   
   @PostMapping(value = "/buyIcon/{iconIdx}")
   @ResponseBody
   public Map<String, Object> buyIcon(@PathVariable String iconIdx, HttpSession session, Model model){
      String userId = (String) session.getAttribute("loginId");
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("success", iconService.buyIcon(iconIdx, userId));
      return result;
   }
   
     @GetMapping(value = "/checkPoint/{iconPrice}")
     @ResponseBody
     public Map<String, Object> checkPoint(@PathVariable String iconPrice, HttpSession session) {
        logger.info("아이콘번호 : "+iconPrice);
        String userId = (String) session.getAttribute("loginId");     
        
         int iconPriceInt = Integer.parseInt(iconPrice);
         int userPoint =  iconService.checkPoint(iconPrice, userId);
         logger.info("userPoint: {} >= iconPriceInt: {}",userPoint,iconPriceInt);
         
         boolean purchase = userPoint >= iconPriceInt ? true : false;
      
        Map<String,Object> result = new HashMap<String, Object>();
        result.put("purchase", purchase);
        result.put("userPoint", userPoint);
        return result;
     }
     
   
   
     @GetMapping(value="/adminIconListView")
     public String adminIconListView(HttpSession session, Model model) {   
    	 String result = "/admin/adminLogin";
    	 if(session.getAttribute("adminYn") == null) {
    		 model.addAttribute("msg","관리자 로그인이 필요한 페이지입니다.");    		 
    	 }else {
    		 result = "/icon/adminIconList";
    	 }
        return result;
     }
     
     @GetMapping(value = "/adminIconList")
     @ResponseBody
     public  Map<String,Object> adminIconList(String page, String cnt, Model model) {   
        logger.info("adminIconList 실행");
        int page_ = Integer.parseInt(page);
        int cnt_ = Integer.parseInt(cnt);
        int limit = cnt_;
        int offset = (page_ - 1) * cnt_;
       // int totalPages = iconService.iconbuycount(cnt_);
        
        Map<String,Object> result = new HashMap<String, Object>();
        result.put("iconList", iconService.adminIconList(limit,offset));
      
        return result;
     }
     
     @GetMapping(value = "/adminIconData/{icon_idx}")  
     public String adminIconUpdate(@PathVariable String icon_idx, Model model) {   
        logger.info("icon_idx : "+icon_idx);
        IconDTO iconDto = iconService.adminIconData(icon_idx);
        model.addAttribute("iconDto", iconDto);
        return "/icon/adminIconUpdate";
     }
     
     @GetMapping(value = "/adminIconWriteView")  
     public String adminIconWriteView(HttpSession session, Model model) {   
    	 String result = "/admin/adminLogin";
    	 if(session.getAttribute("adminYn") == null) {
    		 model.addAttribute("msg","관리자 로그인이 필요한 페이지입니다.");    		 
    	 }else {
    		 result = "/icon/adminIconWrite";
    	 }
        return result;
     }
     
     @PostMapping(value = "/adminIconWrite")  
     public String adminIconWrite(MultipartFile file, @RequestParam Map<String, String> param) {   
        iconService.adminIconWrite(file, param);
        logger.info("icon_name : "+param.get("icon_name"));
        logger.info("use_yn : "+param.get("use_yn"));
        return "redirect:/adminIconListView";
     }
     
     @PostMapping(value = "/adminIconUpdate")  
     public String adminIconUpdate(MultipartFile file, @RequestParam Map<String, String> param) {   
    	 iconService.adminIconUpdate(file, param);
    	 logger.info("use_yn : "+param.get("use_yn"));
    	 return "redirect:/adminIconListView";
     }
     
     
     
     
     
     
     
     
     
     @GetMapping(value = "adminIconChart")
     public String iconchart(HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
    	 return "icon/adminIconChart"; 
     }
    
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
    return "admin/adminLogin";
  }
   
      
     @GetMapping(value = "adminIconCharList")
     @ResponseBody
     public Map<String, Object> iconchart(String page, String cnt,String agegroup) {
         int page_ = Integer.parseInt(page);
         int cnt_ = Integer.parseInt(cnt);
         int startAge = (agegroup != null && !agegroup.isEmpty()) ? Integer.parseInt(agegroup) : 0;
          int endAge = (agegroup != null && !agegroup.isEmpty()) ? startAge + 9 : 100;
           int limit = cnt_;
           int offset = (page_ - 1) * cnt_;
           int totalPages = iconService.iconchartcount(cnt_,startAge,endAge);
           logger.info("쿼리 파라미터: startAge={}, endAge={}, limit={}, offset={}", startAge, endAge, limit, offset);
         Map<String,Object> result = new HashMap<String, Object>();
         List<IconDTO> list = iconService.iconchart(limit,offset,startAge,endAge);
         
         result.put("totalPages", totalPages);
         result.put("currpage", page);
         result.put("list", list);
         
        return result;
         
     }
        
     
     
     @GetMapping(value = "/adminIconBuy/{icon_idx}")
     public String iconbuy(@PathVariable String icon_idx,HttpSession session,Model model) {
        
     if (session.getAttribute("adminYn") != null) {
    	 model.addAttribute("info",icon_idx);
    	 logger.info(""+icon_idx);
    	 return "icon/adminIconBuyList";
     }
     	
    	    
         model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
       return "admin/adminLogin";
     }
     
     @PostMapping(value = "/adminIconBuyList")
     @ResponseBody
     public Map<String, Object> iconbuylist(String icon_idx,String page, String cnt) {
        logger.info("아이콘번호"+icon_idx);
        int page_ = Integer.parseInt(page);
        int cnt_ = Integer.parseInt(cnt);
        int icon_idx_ =Integer.parseInt(icon_idx);
        int limit = cnt_;
        int offset = (page_ - 1) * cnt_;
        int totalPages = iconService.iconbuycount(cnt_,icon_idx);
        
        
        Map<String,Object> result = new HashMap<String, Object>();
        result.put("totalPages", totalPages);
        result.put("currpage", page);
        result.put("list", iconService.iconbuylist(icon_idx_,limit,offset));
        
        
        return result;
     }

     
    
             
          @GetMapping(value = "/iconSalesData")
          @ResponseBody
          public List<IconDTO> getIconSalesData(@RequestParam(defaultValue = "daily") String period,
                    @RequestParam(required = false) Integer year,
                    @RequestParam(required = false) Integer month) {
           List<IconDTO> iconSalesData;
           if (year == null) {
           year = LocalDate.now().getYear(); // 현재 년도 기본 값 설정
           }
           switch (period) {
           case "monthly":
           iconSalesData = iconService.getMonthlySalesData(year);
           break;
           case "weekly":
           if (month == null) {
           month = LocalDate.now().getMonthValue(); // 현재 월 기본 값 설정
           }
           iconSalesData = iconService.getWeeklySalesData(year, month);
           break;
           default:
           if (month == null) {
           month = LocalDate.now().getMonthValue(); // 현재 월 기본 값 설정
           }
           iconSalesData = iconService.getDailySalesData(year, month);
           break;
           }
           return iconSalesData;
           }
                   
          @GetMapping("/availableYears")
          @ResponseBody
          public List<Integer> getAvailableYears() {
              return iconService.getAvailableYears();
          }
 
           @GetMapping("adminIconGraph")
           public String showIconChartPage(Model model) {
           List<IconDTO> dailySalesData = iconService.getDailySalesData(null, null);
           List<Integer> availableYears = iconService.getAvailableYears();

           logger.info("Daily Sales Data: {}", dailySalesData);
           logger.info("Available Years: {}", availableYears);
           model.addAttribute("iconSalesData", dailySalesData);
           model.addAttribute("availableYears", availableYears);
           return "icon/adminIconGraph"; // Forward to JSP file named iconChart.jsp
       }
  }

     
     





     
     



