package com.erunjrun.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.admin.dto.AdminDTO;
import com.erunjrun.admin.service.AdminService;

@Controller
public class AdminController {

   Logger logger = LoggerFactory.getLogger(getClass());
   
   @Autowired AdminService admin_service;

   @GetMapping(value = "/adminLogin")
      public String adminLogin() {
         return "admin/adminLogin";
      }

      @PostMapping(value = "/adminLogin")
      public String login(Model model, HttpSession session, String id, String pw, HttpServletRequest request) {
         String requestIp = request.getRemoteAddr(); // 요청 IP 가져오기
         logger.info("ip가져왔니?" + requestIp);
         String allowedIp = admin_service.getAllowedIp(id); // 데이터베이스에서 허용된 IP 조회
         logger.info("저장된 아이피 가져 옴?" + allowedIp);
         if (admin_service.adminLogin(id, pw)) {
            logger.info("id, pw?" + id + pw);
            if (allowedIp.equals(requestIp)) {
               model.addAttribute("msg", "로그인 되었습니다!");
               session.setAttribute("loginId", id); // 로그인 ID 저장
               session.setAttribute("authority", admin_service.getAuthority(id)); // 권한 저장
               session.setAttribute("requestIp", requestIp); // 요청 IP 저장

               session.setAttribute("adminYn", "Y"); // 로그인시 관리자 여부

            } else {
               model.addAttribute("msg", "허용되지 않은 IP에서 로그인 시도입니다.");
            }
         } else {
            model.addAttribute("msg", "아이디 또는 비밀번호를 확인해.");
         }

         return "main";
      }
      
      @GetMapping(value = "/adminJoin")
      public String adminJoin() {
         return"admin/adminJoin";
      }
      
      @PostMapping(value = "/adminJoin")
      public String adminJoin(Model model, HttpSession session, String id, String pw, String name, HttpServletRequest request) {
         
         String requestIp = request.getRemoteAddr(); // 요청 IP 가져오기
         String superAdminId = (String) session.getAttribute("loginId");
          String superAdminAuthority = (String) session.getAttribute("authority"); // 로그인한 슈퍼관리자 권한

          // 1. 슈퍼관리자 권한 확인
          if (!superAdminAuthority.equals("s")) {
              model.addAttribute("msg", "슈퍼관리자만 회원가입을 할 수 있습니다.");
              return "main"; // 회원가입 페이지로 리턴
          }

          // 2. 요청 IP 확인
          String allowedIp = admin_service.SgetAllowedIp(superAdminId); // 슈퍼관리자 IP 조회
          if (!allowedIp.equals(requestIp)) {
              model.addAttribute("msg", "허용되지 않은 IP에서 요청하였습니다.");
              return "main"; // 회원가입 페이지로 리턴
          }

          // 회원가입 처리 로직 // 가입시 아이피는 슈퍼어드민의 아이피가 되고, 가입된 어드민은 디폴드값 아이피를 사용하도록 한다. 회사 내 ip로.
          if (admin_service.adminJoin(id, pw, name,requestIp)) { // 회원가입 메서드 호출
          model.addAttribute("msg", "회원가입이 완료되었습니다!");
          } else {
            model.addAttribute("msg", "회원가입에 실패했습니다.");
            return "";
         }
          return "admin/adminLogin"; // 로그인 페이지로 리턴
      }
      
      
      
   @GetMapping(value = "/adminMember")
   public String memberList() {
      return "admin/adminMemberList";
   }
      
   
     @PostMapping(value = "/adminMemberList") //post?
     @ResponseBody 
     public Map<String,Object> memberlist(String page, String cnt,String opt, String keyword,String sortField,String sortOrder){
        
      int page_ = Integer.parseInt(page);
      int cnt_ = Integer.parseInt(cnt);
      int limit = cnt_;
      int offset = (page_ - 1) * cnt_;
      int totalPages = admin_service.count(cnt_);
      
       
      Map<String,Object> result = new HashMap<String, Object>();
      result.put("totalPages", totalPages);
      result.put("currpage", page);
      result.put("list", admin_service.memberlist(opt, keyword,sortField,sortOrder, limit, offset));
      
      return result;
     
     }
   
     @GetMapping(value = "/admin")
     public String adminList() {
        return "admin/adminList";
     }
   
     @PostMapping(value = "/adminList") //post?
     @ResponseBody 
     public Map<String,Object> adminlist(String page, String cnt,String opt, String keyword){
        
      int page_ = Integer.parseInt(page);
      int cnt_ = Integer.parseInt(cnt);
      int limit = cnt_;
      int offset = (page_ - 1) * cnt_;
      int totalPages = admin_service.admincount(cnt_);
      
      Map<String,Object> result = new HashMap<String, Object>();
      List<AdminDTO> list =  admin_service.adminlist(opt, keyword, limit, offset);
      logger.info("페이지"+list);
      result.put("totalPages", totalPages);
      result.put("currpage", page);
      result.put("list", list);
      
      return result;
     
     }
     
     @GetMapping(value = "/adminYn/{admin_id}" )
     public String adminyn(@PathVariable String admin_id){
        admin_service.adminyn(admin_id);
        
        return "redirect:/admin"; 
     }
     
     @PostMapping(value = "/adminMemberDetail/{id}") 
     public String memberdetail(@PathVariable String id, Model model) {
        logger.info(id);
        
        AdminDTO dto = admin_service.memberdetail(id);
        model.addAttribute("info",dto);
        
        List<AdminDTO> result = admin_service.ban(id);
        model.addAttribute("result",result);
        
        List<AdminDTO> list = admin_service.memberreportlist(id);
        model.addAttribute("list",list);
        
        return "admin/adminMemberDetail";
     }
     
     
//      권한처리     -- 권한 세션체크 스케줄링 사용해서 만들어야 함.
     
     @GetMapping(value = "/memberRight")
     public String right(String nickname,Model model) {
        logger.info(nickname);
        String id = admin_service.right(nickname);
        model.addAttribute("info",nickname);
        model.addAttribute("id",id);

        return "admin/adminRight";
     }
     
     @GetMapping(value = "/memberRightWrite")
     public String rightwrite(@RequestParam Map<String, String> param, Model model,HttpSession session) {
       String admin_id = (String)session.getAttribute("loginId");
       logger.info(admin_id);
       param.put("admin_id", admin_id);// 관리자 로그인 ID 저장
       admin_service.rightwrite(param);
       
        return"redirect:/adminMember";
     }
     
     @GetMapping(value = "/memberRightDetail")
     public String rightdetail(String ban_idx,Model model) {
        AdminDTO dto = admin_service.rightdetail(ban_idx);
        model.addAttribute("info",dto);
        
        return"admin/rightDetail";
     }
     
     @GetMapping(value = "/memberRightUpdate")
     public String rightupdate(String ban_idx, Model model) {
        AdminDTO dto = admin_service.rightdetail(ban_idx);
        model.addAttribute("info",dto);
   
        return"admin/rightUpdate";
     }
     
     @PostMapping(value = "/memberRightUpdate")
     public String rightupdate( @RequestParam Map<String, String> param,Model model,HttpSession session) {
        String admin_id = (String)session.getAttribute("loginId");
        param.put("admin_id", admin_id);
        admin_service.rightupdate(param);
        
        return"redirect:/memberRightDetail?ban_idx="+param.get("ban_idx");
     }
     
    
     
     
     
//      신고처리        
     
     @GetMapping(value = "/adminReport")
     public String report() {
        return "admin/adminReportList";
     }
     
     @GetMapping(value = "/adminReportList")
     @ResponseBody 
     public Map<String,Object> reportlist(String page, String cnt,String category,String status) {
        int page_ = Integer.parseInt(page);
      int cnt_ = Integer.parseInt(cnt);
      int limit = cnt_;
      int offset = (page_ - 1) * cnt_;
      int totalPages = admin_service.reportcount(cnt_);
      logger.info("page: " + page_ + ", cnt: " + cnt_ + ", category: " + category + ", status: " + status);
      // category와 status의 기본값 설정
       if (category == null || category.isEmpty()) {
           category = "all"; // 기본값 설정
       }
       if (status == null || status.isEmpty()) {
           status = "all"; // 기본값 설정
       }

      
      Map<String,Object> result = new HashMap<String, Object>();
      List<AdminDTO> list =  admin_service.reportlist(limit, offset,category,status);
      logger.info(status);
      if (list == null || list.isEmpty()) {
          logger.info("조회된 데이터가 없습니다.");
      } else {
          logger.info("조회된 데이터: " + list.size() + "건");
      }
      result.put("totalPages", totalPages);
      result.put("currpage", page);
      result.put("list", list);
        
        return result;
     }
     
     @GetMapping(value = "/adminReportDetail")
     public String reportdetail(String report_idx,String code_name,Model model) {
        admin_service.reportdetail(report_idx,code_name,model);
      
        
        
        return "admin/adminReportDetail";
     }

     @GetMapping(value = "/adminReportUpdate")
     public String reportupdate(String report_idx,String code_name,Model model) {
        admin_service.reportdetail(report_idx,code_name,model);
        
        return "admin/adminReportUpdate";
     }
     
     @PostMapping(value = "/adminReportUpdate")
     public String reportupdate(@RequestParam Map<String, String> param,HttpSession session,
           Model model) {
        String admin_id = (String)session.getAttribute("loginId");
        logger.info(admin_id);
        param.put("admin_id", admin_id);// 관리자 로그인 ID 저장
        admin_service.reportupdate(param);
        logger.info(param.get("report_id"));
       return "redirect:/adminReportDetail?report_idx="+param.get("report_idx");
     }
     
     
     //문의하기
     
     @GetMapping(value = "adminAsk")
     public String ask() {
        return "admin/adminAskList";
     }
     
     @GetMapping(value = "adminAskList")
     @ResponseBody 
     public Map<String, Object> asklist(String page, String cnt,String opt, String keyword) {
      int page_ = Integer.parseInt(page);
      int cnt_ = Integer.parseInt(cnt);
      int limit = cnt_;
      int offset = (page_ - 1) * cnt_;
      int totalPages = admin_service.askcount(cnt_);
      Map<String,Object> result = new HashMap<String, Object>();
      result.put("totalPages", totalPages);
      result.put("currpage", page);
      result.put("list", admin_service.asklist(opt, keyword, limit, offset));
      
      return result;
  
     }
     
     
     // 태그
     
     @GetMapping(value = "adminTag")
     public String tag() {
        return "admin/adminTagList";
     }
     
     @GetMapping(value = "adminTagList")
     @ResponseBody 
     public Map<String, Object> taglist(String page, String cnt) {
         int page_ = Integer.parseInt(page);
         int cnt_ = Integer.parseInt(cnt);
         int limit = cnt_;
         int offset = (page_ - 1) * cnt_;
         int totalPages = admin_service.tagcount(cnt_);
         Map<String,Object> result = new HashMap<String, Object>();
         result.put("totalPages", totalPages);
         result.put("currpage", page);
         result.put("list", admin_service.taglist(limit, offset));
         
         return result;
     
     }
     @GetMapping(value = "adminTagWrite")
     public String tagwrite() {
        return "admin/adminTagWrite";
     }
     
     
     @PostMapping(value = "adminTagWrite")
     public String tagwrite(@RequestParam Map<String, String> param, Model model) {
      logger.info(param.get("tag_name"));
      logger.info(param.get("use_yn"));
      admin_service.tagwrite(param);
        return "redirect:/adminTag";
     }
     
     
     @GetMapping(value = "adminTagUpdate")
     public String tagdetail(String tag_idx,Model model) { 
        admin_service.tagdetail(tag_idx,model);

        return "admin/adminTagUpdate";
     }
     
     @PostMapping(value = "adminTagUpdate")
     public String tagupdate(@RequestParam Map<String, String> param) {
        
        admin_service.tagupdate(param);
        logger.info(param.get("tag_idx"));
        
        return "redirect:/adminTag";
     }
     
     
     
     
     // 구분코드
     @GetMapping(value = "adminCode")
     public String code() {
        return "admin/adminCodeList";
     }
     
     @GetMapping(value = "adminCodeList")
     @ResponseBody
     public Map<String, Object> codelist(String page, String cnt,String opt, String keyword) {
         int page_ = Integer.parseInt(page);
         int cnt_ = Integer.parseInt(cnt);
         int limit = cnt_;
         int offset = (page_ - 1) * cnt_;
         int totalPages = admin_service.codecount(cnt_);
         Map<String,Object> result = new HashMap<String, Object>();
         result.put("totalPages", totalPages);
         result.put("currpage", page);
         result.put("list", admin_service.codelist(limit, offset,opt,keyword));
         
         return result;
     
     }
     
     @GetMapping(value = "adminCodeWrite")
     public String codewrite(){
        return "admin/adminCodeWrite";
     }
     
     @PostMapping(value = "adminCodeWrite")
     public String codewrite(@RequestParam Map<String, String> param,Model model) {
        admin_service.codewrite(param);
        return "redirect:/adminCode";
     }
     
     @PostMapping(value = "/adminCodeOverlay")
     @ResponseBody
      public Map<String, Object> codeoverlay(String code_name) {
         
         Map<String, Object> map = new HashMap<String, Object>();
         map.put("overlay",admin_service.codeoverlay(code_name));
         return map;
      }
     
     @GetMapping(value = "adminCodeUpdate")
     public String codedetail(String code_name,Model model) { 
        admin_service.codedetail(code_name,model);
        return "admin/adminCodeUpdate";
     }
     
     @PostMapping(value = "adminCodeUpdate")
     public String codeupdate(@RequestParam Map<String, String> param) { 
        admin_service.codeupdate(param);
        logger.info(param.get("code_name"));
        logger.info(param.get("content"));
        logger.info(param.get("use_yn"));
        
        return "redirect:/adminCode";
     }
     
     
     @GetMapping(value = "adminPopup")
     public String popup() {
        
        return "admin/adminPopupList";
     }
     
     
     @GetMapping(value = "adminPopupList")
     @ResponseBody
     public Map<String, Object> popuplist(String page, String cnt) {
         int page_ = Integer.parseInt(page);
         int cnt_ = Integer.parseInt(cnt);
         int limit = cnt_;
         int offset = (page_ - 1) * cnt_;
         int totalPages = admin_service.popupcount(cnt_);
         
         Map<String,Object> result = new HashMap<String, Object>();
         result.put("totalPages", totalPages);
         result.put("currpage", page);
         result.put("list", admin_service.popuplist(limit, offset));
         
         return result;
     }
     
     @GetMapping(value = "adminPopupWrite")
     public String popupwrite() {
        
        
        return "admin/adminPopupWrite";
     }
     
     
     @PostMapping(value = "adminPopupWrite")
     public String popupwrite(MultipartFile file,@RequestParam Map<String, String> param, Model model) {
      logger.info(param.get("tag_name"));
      logger.info(param.get("use_yn"));
      admin_service.popupwrite(file,param);
        return "redirect:/adminPopup";
     }
     
     @GetMapping(value = "adminPopupUpdate")
     public String popupupdetail(String popup_idx,String code_name,Model model) { 
        admin_service.popupdetail(popup_idx,code_name,model);
        return "admin/adminPopupUpdate";
     }
     
     @PostMapping(value = "adminPopupUpdate")
     public String popupupdate(MultipartFile file,
           @RequestParam Map<String, String> param) { 
       admin_service.popupupdate(file,param);
      
         
      return "redirect:/adminPopup";
      }
     
     
     @PostMapping(value = "/adminFileDelete")
     @ResponseBody
      public Map<String, Object> filedelete(String code_name,int popup_idx) {
         
        logger.info(code_name);
        logger.info(""+popup_idx);
         Map<String, Object> map = new HashMap<String, Object>();
         map.put("del",admin_service.filedelete(code_name,popup_idx));
         return map;
      }
     
     
     
     
     
     
     
     
     
     
     
}