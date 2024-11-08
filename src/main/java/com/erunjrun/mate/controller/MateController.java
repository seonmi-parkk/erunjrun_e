package com.erunjrun.mate.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
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
		logger.info("[mate]toUserId"+toUserId);
		
		Map<String, Object> result = new HashMap<String, Object>();
		String loginYn = "Y";
		// 운동메이트 여부 체크

		String fromUserId = (String) session.getAttribute("loginId");
		if(fromUserId == null) {
			fromUserId = "test";
		}
		//String toUserId = "moma123";
		//result.put("isMate", mateService.checkMate(fromUserId,toUserId));
		
		// 운동메이트 신청 여부 체크
		result.put("MateAppl", mateService.checkMateAppl(fromUserId,toUserId));
		logger.info("나11와11 : {}",mateService.checkMateAppl(fromUserId,toUserId));
		
		// 차단 여부 체크
		result.put("isBlocked", mateService.checkBlock(fromUserId,toUserId));

		// 좋아요 여부 체크
		result.put("isLiked", mateService.checkLike(fromUserId,toUserId));
		
		// 프로필 데이터 가져오기
		MateProfileDTO profileDto = mateService.getProfile(toUserId);
		
		// 로그인 유저의 운동메이트 기능 활성여부 체크
		String exerciseUse = mateService.getExerciseUse(fromUserId);

		
		model.addAttribute("profileDto", profileDto);
		model.addAttribute("result", result);
		model.addAttribute("exerciseUse", exerciseUse);

		
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
	@PostMapping(value="/mateUnblock/{toUserId}")
	@ResponseBody
	public Map<String, Object> mateUnblock(@PathVariable String toUserId, HttpSession session) {
		String fromUserId = (String) session.getAttribute("loginId");
		logger.info("[mateUnblock c] fromUserId : {}, toUserId : {}", fromUserId, toUserId);
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
		String fromUserId = (String) session.getAttribute("loginId");
		
		// 운동프로필 작성하지 않은 경우 튕기도록 처리
		if(fromUserId != null) {
			logger.info("여기 실행1 ??????");
			boolean hasProfile = mateService.hasProfile(fromUserId);
			if(!hasProfile) {				
				logger.info("여기 실행2 ??????");
				model.addAttribute("msg", "운동프로필을 작성한 후 이용 가능합니다.");
				return "mypage/createExerciseProfile";
			}
		}
		
		
		
		
		//mateService.getPos(fromUserId);

		logger.info("fromUserId :"+ fromUserId);
		MateProfileDTO userPos = null;
		if(fromUserId == null) {
			// 로그인 안한 경우 임의의 주소 설정 (check!! 나중에 바꾸기 -> 해당 위치 가져오기?)
			fromUserId = "test";
		}
		userPos = mateService.getUserPos(fromUserId); 			
		userPos.setId(fromUserId);
		model.addAttribute("userPos", userPos);
		//model.addAttribute("userShortsido", userPos.getShortsido());
		//model.addAttribute("userDong", userPos.getDong());
		
		
		// 유저와 같은 지역 유저들의 리스트 // check!! 이거 두줄 빼도됨??
		//List<MateProfileDTO> closeList = mateService.getCloseList(userPos); // 아이디, 닉네임, 성별, 짧은시도, 동, 운동메이트 여부, 프로필, 아이콘
		//model.addAttribute("closeList", closeList);
		
		// 전체 유저 위치
		List<MateProfileDTO> posList = mateService.getPosList(fromUserId);
		logger.info("posList0 image : "+posList.get(0).getImage());
		
		model.addAttribute("posList", posList);
		
		return "mate/mateList";
	}
	
	@RequestMapping(value="/searchMateList")
	@ResponseBody
	public List<MateProfileDTO> searchMateList(MateProfileDTO userPos) {
		// 유저와 같은 지역 유저들의 리스트
		List<MateProfileDTO> closeList = mateService.searchMateList(userPos); // 아이디, 닉네임, 성별, 짧은시도, 동, 운동메이트 여부, 프로필, 아이콘
		//model.addAttribute("closeList", closeList);
		return closeList;
	}
	

	@RequestMapping(value="/moveMateList")
	@ResponseBody
	public Map<String, Object> moveMateList(@RequestBody List<String> users, HttpSession session) {
		String fromUserId = (String) session.getAttribute("loginId");
		String loginYn = "Y";
		//logger.info("users.get(0)"+users.get(0));
		//List<MateProfileDTO> moveMateList = mateService.moveMateList(username); // 아이디, 닉네임, 성별, 짧은시도, 동, 운동메이트 여부, 프로필, 아이콘
		//model.addAttribute("closeList", closeList);
		if(fromUserId == null) {
			fromUserId = "test";
			loginYn = "N";
		}
		List<MateProfileDTO> list = null;
		if(users.size()>0) {			
			list = mateService.moveMateList(users,fromUserId);
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("loginYn", loginYn);
		return result;
	}
	
	@PostMapping(value="/mateOn")
	@ResponseBody
	public Map<String, Object> mateOn(HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		String userId = (String) session.getAttribute("loginId");
		result.put("success", mateService.mateOn(userId));
		return result;
	}
	
	
	
}
