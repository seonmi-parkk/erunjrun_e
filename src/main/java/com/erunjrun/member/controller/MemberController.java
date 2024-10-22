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

import com.erunjrun.member.dto.MemberDTO ;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberService memberService;
	
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
		if (memberService.login(id, pw)) {
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
}
