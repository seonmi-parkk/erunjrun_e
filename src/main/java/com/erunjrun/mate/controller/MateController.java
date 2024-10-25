package com.erunjrun.mate.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.mate.dto.MateProfileDTO;
import com.erunjrun.mate.service.MateService;

@Controller
public class MateController {

	@Autowired MateService mateService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/mate/{toUserId}")

	public String mate(@PathVariable String toUserId, HttpSession session, Model model) {
		//check!!임시 세션(나중에 빼기)
		session.setAttribute("loginId", "kimee01");
		session.setAttribute("profileImg", "profile_img1.jpg");
		session.setAttribute("iconImg", "resources/img/icon/icon1.png");
		session.setAttribute("adminYn", "N");
		logger.info("[mate]toUserId"+toUserId);
		
		Map<String, Object> result = new HashMap<String, Object>();

		// 운동메이트 여부 체크
		// check!!(나중에 찐으로 넣어줘야 함)
		String fromUserId = (String) session.getAttribute("loginId");
		//String toUserId = "moma123";
		//result.put("isMate", mateService.checkMate(fromUserId,toUserId));
		
		// 운동메이트 신청 여부 체크
		result.put("MateAppl", mateService.checkMateAppl(fromUserId,toUserId));
		
		// 차단 여부 체크
		result.put("isBlocked", mateService.checkBlock(fromUserId,toUserId));

		// 좋아요 여부 체크
		result.put("isLiked", mateService.checkLike(fromUserId,toUserId));
		
		// 프로필 데이터 가져오기
		MateProfileDTO profileDto = mateService.getProfile(toUserId);

		
		model.addAttribute("profileDto", profileDto);
		model.addAttribute("result", result);
		
		return "mate/profileDetail";
	}

	//메이트 신청
	@RequestMapping(value="/mateAppliaction")
	@ResponseBody
	public Map<String, Object> mateApplication(String toUserId, Model model, HttpSession session) {
		String fromUserId = (String) session.getAttribute("loginId");
		logger.info("[mateAppliaction c]fromUserId : {}, toUserId : {}", fromUserId, toUserId);
		boolean success = mateService.mateApplication(fromUserId, toUserId);
		logger.info("[mateAppliaction c]success : "+success);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", success);
		return result;

	}
	
	//좋아요
	@PostMapping(value="/toggleLike")
	@ResponseBody
	public Map<String, Object> toggleLike(String toUserId, HttpSession session) {
		String fromUserId = (String) session.getAttribute("loginId");
		logger.info("[toggleLike c]fromUserId : {}, toUserId : {}", fromUserId, toUserId);
		Map<String, Object> result = new HashMap<String, Object>();
		if(mateService.checkLike(fromUserId,toUserId)) {
			if(mateService.dislike(fromUserId, toUserId)) {				
				result.put("isLiked", false);
			}
		}else {
			if(mateService.like(fromUserId, toUserId)) {				
				result.put("isLiked", true);
			}
		}
		return result;
	}
	
	// 차단하기
	@PostMapping(value="/mateBlock")
	@ResponseBody
	public Map<String, Object> mateBlock(String toUserId, HttpSession session) {
		String fromUserId = (String) session.getAttribute("loginId");
		logger.info("[mateBlock c]fromUserId : {}, toUserId : {}", fromUserId, toUserId);
		Map<String, Object> result = new HashMap<String, Object>();
		boolean success = false;
		if(mateService.mateBlock(fromUserId,toUserId)) {
			success = true;
		}
		result.put("success", success);
		logger.info("[mateBlock c]success"+success);
		return result;
	}

	// 차단해제하기
	@PostMapping(value="/mateUnblock")
	@ResponseBody
	public Map<String, Object> mateUnblock(String toUserId, HttpSession session) {
		String fromUserId = (String) session.getAttribute("loginId");
		logger.info("[mateUnblock c]fromUserId : {}, toUserId : {}", fromUserId, toUserId);
		Map<String, Object> result = new HashMap<String, Object>();
		boolean success = false;
		if(mateService.mateUnblock(fromUserId,toUserId)) {
			success = true;
		}
		result.put("success", success);
		return result;
	}
	
	// 러닝메이트 리스트
	@RequestMapping(value="/mateList")
	public String mateList(HttpSession session, Model model) {
		// check!! 임시세션 나중에 지우기
		session.setAttribute("loginId", "kimee01");
		String fromUserId = (String) session.getAttribute("loginId");
		//mateService.getPos(fromUserId);
		// 로그인 유저의 동을 가져오기 ( check!! 로그인 안한경우 ?? 해당 위치 가져오기??)
		MateProfileDTO userPos = mateService.getUserPos(fromUserId); 
		userPos.setId(fromUserId);
		model.addAttribute("userShortsido", userPos.getShortsido());
		model.addAttribute("userDong", userPos.getDong());
		
		// 유저와 같은 지역 유저들의 리스트
		List<MateProfileDTO> closeList = mateService.getCloseList(userPos); // 아이디, 닉네임, 성별, 짧은시도, 동, 운동메이트 여부, 프로필, 아이콘
		model.addAttribute("closeList", closeList);
		
		// 전체 유저 위치
		List<MateProfileDTO> posList = mateService.getPosList(fromUserId);
		model.addAttribute("posList", posList);
		
		return "mate/mateList";
	}
	
	
}
