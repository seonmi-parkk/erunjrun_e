package com.erunjrun.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.member.service.MemberService;

import com.erunjrun.member.dto.MemberDTO;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MemberService memberService;

	@GetMapping(value = "/login")
	public String loginView() {
		return "member/login";
	}

	@GetMapping(value = "/join")
	public String joinView() {
		return "member/join";
	}

	@PostMapping(value = "/join")
	public String join(Model model, @RequestParam Map<String, String> params) {
		String page = "member/join";
		if (memberService.join(params)) {
			model.addAttribute("msg", "회원가입에 성공했습니다!");
			page = "member/login";
		} else {
			model.addAttribute("msg", "회원가입에 실패했습니다.");
		}
		return page;
	}

	@GetMapping(value = "/idOverlay")
	@ResponseBody
	public Map<String, Object> getIdOverlay(String id) {
		logger.info("overlay check : " + id);
		Map<String, Object> map = new HashMap<>();
		map.put("overlay", memberService.idOverlay(id));
		return map;
	}

	@GetMapping(value = "/nickNameOverlay")
	@ResponseBody
	public Map<String, Object> getNickNameOverlay(String nickName) {
		logger.info("nickName check: " + nickName);
		Map<String, Object> map = new HashMap<>();
		map.put("overlay", memberService.nickNameOverlay(nickName));
		return map;
	}

	@GetMapping(value = "/emailOverlay")
	@ResponseBody
	public Map<String, Object> getEmailOverlay(String email) {
		logger.info("email check: " + email);
		Map<String, Object> map = new HashMap<>();
		map.put("overlay", memberService.emailOverlay(email));
		return map;
	}

	@PostMapping(value = "/login")
	public String login(Model model, HttpSession session, String id, String pw) {
	    MemberDTO member = memberService.findSessionId(id); // 회원 정보 조회

	    if (member == null) {
	        model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
	    } else if ("Y".equals(member.getUse_yn())) {
	        model.addAttribute("msg", "탈퇴된 회원입니다."); // 탈퇴 상태 체크
	    } else if (memberService.login(id, pw)) {
	        model.addAttribute("msg", "로그인 되었습니다!");
	        session.setAttribute("loginId", id);
	    } else {
	        model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
	    }
	    
	    return "main";
	}

	@GetMapping(value = "/findId")
	public String findIdview() {
		return "member/findId";
	}

	@PostMapping(value = "/findIdCheck")
	public String findMemberId(HttpServletRequest request, Model model, MemberDTO dto, @RequestParam String name,
			@RequestParam String email) {
		dto.setName(name);
		dto.setEmail(email);
		MemberDTO id = memberService.findMemberId(dto);
		if (id == null) {
			model.addAttribute("msg", "이름 및 이메일이 일치하는 id가 없습니다.");
		}
		model.addAttribute("findId", id);
		return "member/findIdResult";
	}

	@GetMapping(value = "/findPw")
	public String findpwview() {
		return "member/findPw";
	}

	@PostMapping(value = "/tempPw")
	public String tempPw(HttpServletRequest request, Model model, MemberDTO dto, @RequestParam String id,
			@RequestParam String name, @RequestParam String email) {
		dto.setId(id);
		dto.setName(name);
		dto.setEmail(email);

		MemberDTO pw = memberService.findMemberPw(dto);
		if (pw != null) {
			String tempPw = UUID.randomUUID().toString().substring(0, 8);
			memberService.updatePw(id, tempPw);
			model.addAttribute("tempPw", tempPw);
			model.addAttribute("msg", "임시 비밀번호가 생성되었습니다.");

		} else {
			model.addAttribute("msg", "입력한 정보와 일치하는 계정이 없습니다.");
		}
		return "member/findPwResult";
	}

	@GetMapping(value = "/profile")
	public String profileView(Model model, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			MemberDTO member = memberService.profileView(id);
			model.addAttribute("member", member);
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "login"; // 로그인 페이지로 이동
		}
		return "member/profile";
	}

	@GetMapping(value = "/profileUpdate")
	public String profileUpdateView(HttpSession session, Model model) {
	    String id = (String) session.getAttribute("loginId");
	    if (id != null) {
	        MemberDTO member = memberService.profileView(id);
	        model.addAttribute("member", member);
	        return "member/profileUpdate"; // 수정 페이지로 이동
	    } else {
	        return "main"; // 로그인 페이지로 리다이렉트
	    }
	}
	
	@PostMapping(value = "profileUpdate.do")
	public String profileUpdate(Model model, @RequestParam Map<String, String> params, HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    if (id != null) {
	        params.put("id", id); // 세션에서 가져온 ID를 params에 추가
	        logger.info("params : {}", params);
	        memberService.profileUpdate(params);
	        MemberDTO member = memberService.profileView(id);
	        model.addAttribute("member", member);
	        return "member/profile";
	    } else {
	        // 세션에 ID가 없으면 로그인 페이지로 리다이렉트
	        return "main";
	    }
	}
	
	@GetMapping(value = "/delete")
	public String delete() {
		return "member/delete";
	}
	
	@PostMapping("/deleteMember")
	public String deleteMember(@RequestParam String id, 
	                           @RequestParam String email, 
	                           @RequestParam String pw, 
	                           HttpSession session, 
	                           Model model) {
	    String sessionId = (String) session.getAttribute("loginId");
	    if (sessionId.equals(id)) {
	        // ID가 세션에 있는지 확인
	        MemberDTO member = memberService.findSessionId(id);
	        
	        if (member.getEmail().equals(email) && member.getPw().equals(pw)) {
	            // 이메일과 비밀번호가 일치하는 경우
	            memberService.setUseY(id); // 탈퇴 상태로 변경
	            session.invalidate(); // 세션 무효화
	            model.addAttribute("msg", "탈퇴가 완료되었습니다. 지금까지 이용해주셔서 감사합니다.");
	            return "main"; // 로그인 페이지로 리다이렉트
	        } else {
	        	model.addAttribute("msg", "입력한 정보가 올바르지 않습니다.");
	        }
	    } else {
	    	model.addAttribute("msg", "로그인후 탈퇴할 수 있습니다.");
	    }
	    return "main"; // 탈퇴 페이지로 다시 리다이렉트
	}


}
