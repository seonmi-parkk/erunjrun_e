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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

         return "redirect:/adminMember";
      }
      
      @GetMapping(value = "/adminJoin")
      public String adminJoin(HttpSession session) {
         
         return"admin/adminJoin";
      }
      
      @PostMapping(value = "/adminJoin")
      public String adminJoin(Model model, HttpSession session, String id, String pw, String name, HttpServletRequest request) {
         
         String requestIp = request.getRemoteAddr(); // 요청 IP 가져오기
         logger.info("슈퍼관리자 아이피 : "+requestIp);
         String superAdminId = (String) session.getAttribute("loginId");
         logger.info("슈퍼관리자 아이디 : "+superAdminId);
         String superAdminAuthority = (String) session.getAttribute("authority"); // 로그인한 슈퍼관리자 권한
         logger.info("슈퍼관리자 권한 : "+superAdminAuthority);
          // 1. 슈퍼관리자 권한 확인
          if (!superAdminAuthority.equals("s")) {
              model.addAttribute("msg", "슈퍼관리자만 회원가입을 할 수 있습니다.");
              return "admin/adminJoin"; // 회원가입 페이지로 리턴
          }

          // 2. 요청 IP 확인
          String allowedIp = admin_service.SgetAllowedIp(superAdminId); // 슈퍼관리자 IP 조회
          if (!allowedIp.equals(requestIp)) {
              model.addAttribute("msg", "허용되지 않은 IP에서 요청하였습니다.");
              return "admin/adminJoin"; // 회원가입 페이지로 리턴
          }

          // 회원가입 처리 로직 // 가입시 아이피는 슈퍼어드민의 아이피가 되고, 가입된 어드민은 디폴드값 아이피를 사용하도록 한다. 회사 내 ip로.
          if (admin_service.adminJoin(id, pw, name,requestIp)) { // 회원가입 메서드 호출
	          model.addAttribute("msg", "회원가입이 완료되었습니다!");
	          logger.info("성공");
          } else {
            model.addAttribute("msg", "회원가입에 실패했습니다.");
            logger.info("실패");
            return "admin/adminMember";
         }
          return "admin/adminMember"; // 로그인 페이지로 리턴
      }
      
      
      
      @GetMapping(value = "/adminMember")
      public String memberList(HttpSession session,Model model) {
         if (session.getAttribute("adminYn") != null) {
            return "admin/adminMemberList";
      }
         
         model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
         return "redirect:/adminLogin";
      }
         
      
      @GetMapping(value = "/adminMemberList")
      @ResponseBody
      public Map<String, Object> memberlist(String page, String cnt, String opt, String keyword, String sortField, String sortOrder) {
          int page_ = Integer.parseInt(page);
          int cnt_ = Integer.parseInt(cnt);
          int limit = cnt_;
          int offset = (page_ - 1) * cnt_;
          
          // 검색 조건을 반영하여 페이지 수를 계산
          int totalPages = admin_service.count(cnt_, opt, keyword);

          Map<String, Object> result = new HashMap<>();
          logger.info("총갯수"+totalPages);
          logger.info(page);
          result.put("totalPages", totalPages);
          result.put("currpage", page);
          result.put("list", admin_service.memberlist(opt, keyword, sortField, sortOrder, limit, offset));

          return result;
      }
   
     @GetMapping(value = "/admin")
     public String adminList(HttpSession session,Model model) {
        if (session.getAttribute("adminYn") != null) {
           return "admin/adminList";
     }
        
        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
   
     @PostMapping(value = "/adminList") //post?
     @ResponseBody 
     public Map<String,Object> adminlist(String opt, String keyword,String page, String cnt){
        
      int page_ = Integer.parseInt(page);
      int cnt_ = Integer.parseInt(cnt);
      int limit = cnt_;
      int offset = (page_ - 1) * cnt_;
      int totalPages = admin_service.admincount(cnt_,opt,keyword);
      
      Map<String,Object> result = new HashMap<String, Object>();
      List<AdminDTO> list =  admin_service.adminlist(opt, keyword, limit, offset);
      logger.info("페이지"+list);
      result.put("totalPages", totalPages);
      result.put("currpage", page);
      result.put("list", list);
      
      return result;
     
     }
     
     @GetMapping(value = "/adminYn/{admin_id}" )
     public String adminyn(@PathVariable String admin_id,HttpSession session,Model model){
     
     if (session.getAttribute("adminYn") != null) {
    	 String superAdminAuthority = (String) session.getAttribute("authority");
    	 if (!superAdminAuthority.equals("s")) {
    		 model.addAttribute("msg","슈퍼 관리자만 가능한 기능입니다.");
			return "admin/adminList";
		}else {
			admin_service.adminyn(admin_id);
			return "redirect:/admin"; 	
		}
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
    return "redirect:/adminLogin";
  }
     
     @GetMapping(value = "/adminMemberDetail/{id}") 
     public String memberdetail(@PathVariable String id, HttpSession session,Model model) {
        
    if (session.getAttribute("adminYn") != null) {
           AdminDTO dto = admin_service.memberdetail(id);
           model.addAttribute("info",dto);
           
           List<AdminDTO> result = admin_service.ban(id);
           model.addAttribute("result",result);
           
           List<AdminDTO> list = admin_service.memberreportlist(id);
           model.addAttribute("list",list);
         return "admin/adminMemberDetail";
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
   }
     
//      권한처리     -- 권한 세션체크 스케줄링 사용해서 만들어야 함.
     
     @GetMapping(value = "/memberRight/{nickname}")
     public String right(@PathVariable String nickname,HttpSession session,Model model) {
        
    if (session.getAttribute("adminYn") != null) {
       String id = admin_service.right(nickname);
         model.addAttribute("info",nickname);
         model.addAttribute("id",id);

         return "admin/adminRight";
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
   }
     
     
     
     @GetMapping(value = "/memberRightWrite")
     public String rightwrite(@RequestParam Map<String, String> param, Model model,HttpSession session) {
  
     if (session.getAttribute("adminYn") != null) {
        String admin_id = (String)session.getAttribute("loginId");
         param.put("admin_id", admin_id);// 관리자 로그인 ID 저장
         admin_service.rightwrite(param);
         return "redirect:/adminMember";
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
  }
     
     
     
     @GetMapping(value = "/memberRightDetail/{ban_idx}")
     public String rightdetail(@PathVariable String ban_idx,HttpSession session,Model model) {
        
     if (session.getAttribute("adminYn") != null) {
        AdminDTO dto = admin_service.rightdetail(ban_idx);
         model.addAttribute("info",dto);
         
         return"admin/rightDetail";
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
  }
     
     
     
     
     @GetMapping(value = "/memberRightUpdate/{ban_idx}")
     public String rightupdate(@PathVariable String ban_idx,HttpSession session,Model model) {
 
     if (session.getAttribute("adminYn") != null) {
        AdminDTO dto = admin_service.rightdetail(ban_idx);
         model.addAttribute("info",dto);
    
         return"admin/rightUpdate";
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
    return "redirect/adminLogin";
  }
     
     
     
     @PostMapping(value = "/memberRightUpdate")
     public String rightupdate(@RequestParam Map<String, String> param,Model model,HttpSession session) {

     if (session.getAttribute("adminYn") != null) {
        String admin_id = (String)session.getAttribute("loginId");
         param.put("admin_id", admin_id);
         admin_service.rightupdate(param);
         
         return"redirect:/memberRightDetail/"+param.get("ban_idx");
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
  }
    
     
     
     
//      신고처리        
     
     @GetMapping(value = "/adminReport")
     public String report() {
         return "admin/adminReportList";
     }

     @GetMapping(value = "/adminReportList")
     @ResponseBody
     public Map<String, Object> reportlist(String page, String cnt, String category, String status) {
         // 페이지 및 개수 파라미터를 정수로 변환
         int page_ = Integer.parseInt(page);
         int cnt_ = Integer.parseInt(cnt);
         int limit = cnt_;
         int offset = (page_ - 1) * cnt_;

         // category와 status의 기본값 설정 및 필터링 처리
         if (category == null || category.equals("all") || category.isEmpty()) {
             category = null; // 기본값이 "all"일 경우 null로 설정하여 쿼리에서 조건을 무시하도록 설정
         }
         if (status == null || status.equals("all") || status.isEmpty()) {
             status = null; // 기본값이 "all"일 경우 null로 설정하여 쿼리에서 조건을 무시하도록 설정
         }

         // 필터 조건에 맞는 페이지 수 계산
         int totalPages = admin_service.reportcount(limit, category, status); // 필터를 적용한 총 개수 계산

         // 결과 맵 생성 및 서비스 호출
         Map<String, Object> result = new HashMap<>();
         List<AdminDTO> list = admin_service.reportlist(limit, offset, category, status);

         // 로그 출력
         logger.info("page: " + page_ + ", cnt: " + cnt_ + ", category: " + category + ", status: " + status);
         if (list == null || list.isEmpty()) {
             logger.info("조회된 데이터가 없습니다.");
         } else {
             logger.info("조회된 데이터: " + list.size() + "건");
         }

         // 결과 맵에 데이터 추가
         result.put("totalPages", totalPages);
         result.put("currpage", page);
         result.put("list", list);

         return result;
     }
     @GetMapping(value = "/adminReportDetail/{report_idx},{code_name}")
     public String reportdetail(@PathVariable String report_idx,@PathVariable String code_name,HttpSession session,Model model) {
       
     if (session.getAttribute("adminYn") != null) {
         admin_service.reportdetail(report_idx,code_name,model);
          return "admin/adminReportDetail";
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
  }
     
     

     @GetMapping(value = "/adminReportUpdate/{report_idx},{code_name}")
     public String reportupdate(@PathVariable String report_idx,@PathVariable String code_name,HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
         admin_service.reportdetail(report_idx,code_name,model);         
          return "admin/adminReportUpdate";
   }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
    }
     
     
     
     
     @GetMapping(value = "/adminReportUpdate")
     public String reportupdate(@RequestParam Map<String, String> param,HttpSession session,
           Model model) {
     if (session.getAttribute("adminYn") != null) {
        String admin_id = (String)session.getAttribute("loginId");
         logger.info(admin_id);
         param.put("admin_id", admin_id);// 관리자 로그인 ID 저장
         admin_service.reportupdate(param);
         logger.info(param.get("report_id"));
        return "redirect:/adminReportDetail/"+param.get("report_idx")+","+param.get("code_name");
      }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "admin/adminLogin";
      }
     //문의하기
     
     @GetMapping(value = "/adminAsk")
     public String ask(HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
          return "admin/adminAskList";
     }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "admin/adminLogin";
      }
     
     
     
     @PostMapping(value = "/adminAskList")
     @ResponseBody 
     public Map<String, Object> asklist(String page, String cnt,String opt, String keyword) {
      int page_ = Integer.parseInt(page);
      int cnt_ = Integer.parseInt(cnt);
      int limit = cnt_;
      int offset = (page_ - 1) * cnt_;
      int totalPages = admin_service.askcount(cnt_,opt,keyword);
      Map<String,Object> result = new HashMap<String, Object>();
      result.put("totalPages", totalPages);
      result.put("currpage", page);
      result.put("list", admin_service.asklist(opt, keyword, limit, offset));
      
      return result;
  
     }
     
     // 태그
     
     @GetMapping(value = "/adminTag")
     public String tag(HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
         return "admin/adminTagList";
     }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
      }
     
     
     
     @GetMapping(value = "/adminTagList")
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
     @GetMapping(value = "/adminTagWrite")
     public String tagwrite(HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
        return "admin/adminTagWrite";
     }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
      }
     
     
     @PostMapping(value = "/adminTagWrite")
     public String tagwrite(@RequestParam Map<String, String> param, HttpSession session,Model model) {
      logger.info(param.get("tag_name"));
      logger.info(param.get("use_yn"));
      admin_service.tagwrite(param);
        return "redirect:/adminTag";
     }
     
     
     @GetMapping(value = "/adminTagUpdate/{tag_idx}")
     public String tagdetail(@PathVariable String tag_idx,HttpSession session,Model model) { 

     if (session.getAttribute("adminYn") != null) {
        admin_service.tagdetail(tag_idx,model);

         return "admin/adminTagUpdate";
      }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
   }
    
     
   
     
     
     @PostMapping(value = "/adminTagUpdate")
     public String tagupdate(@RequestParam Map<String, String> param,HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
     admin_service.tagupdate(param);
      logger.info(param.get("tag_idx"));
      return "redirect:/adminTag";
      }
      
      model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
      return "redirect:/adminLogin";
   }
     
     
     
     // 구분코드
  // 구분코드
     @GetMapping(value = "/adminCode")
     public String code(HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
        return "admin/adminCodeList";
     }

        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     
     @GetMapping(value = "/adminCodeList")
     @ResponseBody 
     public Map<String, Object> codeList(String page, String cnt, String opt, String keyword) {
         int page_ = Integer.parseInt(page);
         int cnt_ = Integer.parseInt(cnt);
         int limit = cnt_;
         int offset = (page_ - 1) * cnt_;
         int totalPages = admin_service.codecount(cnt_, keyword, opt); // 쿼리에서 계산된 페이지 수 사용

         Map<String, Object> result = new HashMap<>();
         result.put("totalPages", totalPages);
         result.put("currpage", page);
         result.put("list", admin_service.codelist(opt, keyword, limit, offset));

         return result;
     }
     
     @GetMapping(value = "/adminCodeWrite")
     public String codewrite(HttpSession session,Model model){
     if (session.getAttribute("adminYn") != null) {
        return "admin/adminCodeWrite";
     }
        
        
        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     @PostMapping(value = "/adminCodeWrite")
     public String codewrite(@RequestParam Map<String, String> param,HttpSession session,Model model) {
  
     if (session.getAttribute("adminYn") != null) {
        admin_service.codewrite(param);
        return "redirect:/adminCode";
     }
        
        
        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     @PostMapping(value = "/adminCodeOverlay")
     @ResponseBody
      public Map<String, Object> codeoverlay(String code_name) {
         
         Map<String, Object> map = new HashMap<String, Object>();
         map.put("overlay",admin_service.codeoverlay(code_name));
         return map;
      }
     
     @GetMapping(value = "/adminCodeUpdate/{code_name}")
     public String codedetail(@PathVariable String code_name,HttpSession session,Model model) { 
        admin_service.codedetail(code_name,model);
        return "admin/adminCodeUpdate";
     }
     
     @PostMapping(value = "/adminCodeUpdate")
     public String codeupdate(@RequestParam Map<String, String> param,HttpSession session,Model model) { 
     
     if (session.getAttribute("adminYn") != null) {
        admin_service.codeupdate(param);

        return "redirect:/adminCode";
     }
        
        
        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     
     @GetMapping(value = "/adminPopup")
     public String popup(HttpSession session,Model model) {
        
     if (session.getAttribute("adminYn") != null) {
        return "admin/adminPopupList";
     }
        
        
        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     @GetMapping(value = "/adminPopupList")
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
     
     @GetMapping(value = "/adminPopupWrite")
     public String popupwrite(HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
        return "admin/adminPopupWrite";
     }

        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     @PostMapping(value = "/adminPopupWrite")
     public String popupwrite(MultipartFile file,@RequestParam Map<String, String> param,HttpSession session,Model model) {
     if (session.getAttribute("adminYn") != null) {
        admin_service.popupwrite(file,param);
        return "redirect:/adminPopup";
     }

        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     @GetMapping(value = "/adminPopupUpdate/{popup_idx},{code_name}")
     public String popupupdetail(@PathVariable String popup_idx,@PathVariable String code_name,HttpSession session,Model model) { 
     if (session.getAttribute("adminYn") != null) {
        admin_service.popupdetail(popup_idx,code_name,model);
        return "admin/adminPopupUpdate";
     }
        
        
        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
     return "admin/adminLogin";
     }
     
     @PostMapping(value = "/adminPopupUpdate")
     public String popupupdate(MultipartFile file,
           @RequestParam Map<String, String> param,HttpSession session,Model model) { 
     if (session.getAttribute("adminYn") != null) {
        admin_service.popupupdate(file,param);
        
        return "redirect:/adminPopup";
     }
        
        
        model.addAttribute("msg","관리자 로그인이 필요한 서비스 입니다.");
        return "redirect:/adminLogin";
     }
     
     @PostMapping(value = "/adminFileDelete")
     @ResponseBody
      public Map<String, Object> filedelete(String code_name,int popup_idx,HttpSession session,Model model) {
         
       
         Map<String, Object> map = new HashMap<String, Object>();
         map.put("del",admin_service.filedelete(code_name,popup_idx));
         return map;
         
         
      }
     
     
     
     
     
     
     
     
     
     
     
}