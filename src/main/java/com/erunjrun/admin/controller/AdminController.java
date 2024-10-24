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
		return "admin/memberList";
	}
		
	
	  @GetMapping(value = "/memberList") //post?
	  @ResponseBody 
	  public Map<String,Object> memberlist(String page, String cnt,String opt, String keyword){
		  
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		
		int limit = cnt_;
		int offset = (page_ - 1) * cnt_;
		int totalPages = admin_service.count(cnt_);
		
		List<AdminDTO> list =  admin_service.memberlist(opt, keyword, limit, offset);
		logger.info("페이지"+list);
		 
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currpage", page);
		result.put("list", list);
		
		return result;
	  
	  }
	
	  @GetMapping(value = "/admin")
	  public String adminList() {
		  return "admin/adminList";
	  }
	  
	
	  @GetMapping(value = "/adminList") //post?
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
	  
	  @GetMapping(value = "/adminMemberDetail") 
	  public String memberdetail(String id, Model model) {
		  logger.info(id);
		  
		  AdminDTO dto = admin_service.memberdetail(id);
		  model.addAttribute("info",dto);
		  
		  List<AdminDTO> result = admin_service.ban(id);
		  model.addAttribute("result",result);
		  
		  List<AdminDTO> list = admin_service.reportlist(id);
		  model.addAttribute("list",list);
		  
		  return "admin/memberDetail";
	  }
	  
	  @GetMapping(value = "/memberRight")
	  public String rightwrite(@RequestParam Map<String, String> param, Model model) {
		  admin_service.right(param);
		  String id= param.get("id");
		  
		  return "admin/right";
	  }
	  

}