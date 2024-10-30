package com.erunjrun.admin.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.erunjrun.admin.dao.AdminDAO;
import com.erunjrun.admin.dto.AdminDTO;
import com.erunjrun.image.dto.ImageDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminDAO admin_dao;

	public String getAllowedIp(String id) {
        return admin_dao.getAllowedIp(id);
    }

   public boolean adminLogin(String id, String pw) {
      return admin_dao.adminLogin(id, pw);
   }
   
   public String getAuthority(String id) {
       return admin_dao.getAuthority(id);
   }
	
   public String SgetAllowedIp(String superAdminId) {
	      return admin_dao.getAllowedIp(superAdminId);
	      
	   }

   public boolean adminJoin(String id, String pw, String name,String ip) {
	   
	      return admin_dao.adminJoin(id,pw,name,ip);
	   }
   
   
	public int count(int cnt_) {
		
		return admin_dao.count(cnt_);
	}


	public List<AdminDTO> memberlist(String opt, String keyword, String sortField,String sortOrder,int limit, int offset) {
		
		return admin_dao.memberlist(opt, keyword, sortField,sortOrder,limit, offset);
	}

	public int admincount(int cnt_) {
	
		return admin_dao.admincount(cnt_);
	}

	public List<AdminDTO> adminlist(String opt, String keyword, int limit, int offset) {
	
		return admin_dao.adminlist(opt, keyword, limit, offset);
	}


	public List<AdminDTO> memberreportlist(String id) {
		
		return admin_dao.memberreportlist(id);
	}

	public AdminDTO memberdetail(String id) {
		
		return admin_dao.memberdetail(id);
	}
	
	
//	권한처리

	public List<AdminDTO> ban(String id) {
		
		return admin_dao.ban(id);
	}
	
	public String right(String nickname) {
		
		return admin_dao.right(nickname);
	}

	public void rightwrite(Map<String, String> param) {
		admin_dao.rightwrite(param);
	}

	public AdminDTO rightdetail(String ban_idx) {
		
		return admin_dao.rightdetail(ban_idx);
	}

	public void rightupdate(Map<String, String> param) {
		admin_dao.rightupdate(param);
		
	}
	
	@PostConstruct
    public void init() {
        logger.info("서버 시작 시 권한 업데이트 실행");
        checkAndUpdateStatus(); // 서버가 시작될 때 권한 업데이트
    }
	
	
	
	@Scheduled(cron = "0 0 0 * * ?") // 매일 자정 실행
    @Transactional
    public void checkAndUpdateStatus() {
        LocalDate today = LocalDate.now();
        Date sqlDate = Date.valueOf(today);

        try {
            // 1. 오늘 또는 과거의 시작일에 해당하는 권한을 'Y'로 변경
            admin_dao.updateRightY(sqlDate);
            System.out.println("지난 시작일 포함 모든 권한을 'Y'로 변경했습니다.");

            // 2. 오늘 또는 과거의 종료일에 해당하는 권한을 'N'으로 변경
            admin_dao.updateRightN(sqlDate);
            System.out.println("지난 종료일 포함 모든 권한을 'N'으로 변경했습니다.");
        } catch (Exception e) {
            System.err.println("스케줄러 실행 중 오류 발생: " + e.getMessage());
        }
    }
	
	
//	신고
	public List<AdminDTO> reportlist(int limit, int offset) {
		
		return admin_dao.reportlist(limit,offset);
	}

	public int reportcount(int cnt_) {
		
		return admin_dao.reportcount(cnt_);
	}

	public void reportdetail(String report_idx, Model model) {
		AdminDTO dto = admin_dao.reportdetail(report_idx);
		ImageDTO file = admin_dao.image(report_idx);
		model.addAttribute("info",dto);
		model.addAttribute("file",file);
		
	}

	public void reportupdate(Map<String, String> param) {
		admin_dao.reportupdate(param);
		
	}
	
	
	
	//문의하기

	public List<AdminDTO> asklist(String opt, String keyword, int limit, int offset) {
		
		return admin_dao.asklist(opt, keyword ,limit, offset);
	}
	
	public int askcount(int cnt_) {
		
		return admin_dao.askcount(cnt_);
	}

	
 //태그	
	
	public List<AdminDTO>taglist(int limit, int offset) {
		
		return admin_dao.taglist(limit, offset);
	}

	public int tagcount(int cnt_) {
	
		return admin_dao.tagcount(cnt_);
	}

	public void tagwrite(Map<String, String> param) {
		admin_dao.tagwrite(param);
		
	}

	public void tagdetail(String tag_idx,Model model) {
		AdminDTO dto = admin_dao.tagdetail(tag_idx);
		model.addAttribute("info",dto);
		
		
	}

	public void tagupdate(Map<String, String> param) {
		admin_dao.tagupdate(param);
		
	}

	
	
	
	
	
	
	public int codecount(int cnt_) {
		
		return admin_dao.codecount(cnt_);
	}


	public List<AdminDTO> codelist(int limit, int offset, String opt, String keyword) {
		
		return admin_dao.codelist(limit, offset,opt,keyword);
	}
	
	public void codewrite(Map<String, String> param) {
		admin_dao.codewrite(param);
			
	
	}

	public int codeoverlay(String code_name) {
		
		return admin_dao.codeoverlay(code_name);
	}

	public void codedetail(String code_name, Model model) {
		AdminDTO dto = admin_dao.codedetail(code_name);
		model.addAttribute("info",dto);
		
	}

	public void codeupdate(Map<String, String> param) {
		admin_dao.codeupdate(param);
		
	}

	
	
	
	public int popupcount(int cnt_) {
		
		return admin_dao.pupupcount(cnt_);
	}

	public List<AdminDTO> popuplist(int limit, int offset) {
		
		return admin_dao.pupuplist(limit,offset);
	}

	


	

	


	
	 

	
}