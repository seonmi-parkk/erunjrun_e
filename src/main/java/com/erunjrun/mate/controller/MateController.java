package com.erunjrun.mate.controller;

import java.util.Map;

=======
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

>>>>>>> 702d4b4c07f51c3622e968294a5684369870636d
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
=======
import org.springframework.web.bind.annotation.ResponseBody;
>>>>>>> 702d4b4c07f51c3622e968294a5684369870636d

import com.erunjrun.mate.dto.MateDTO;
import com.erunjrun.mate.service.MateService;
import com.erunjrun.member.service.MemberService;

@Controller
public class MateController {

	@Autowired MateService mateService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/mate")

	public String mate(HttpSession session, Model model) {
		//check!!임시 세션(나중에 빼기)
		session.setAttribute("loginId", "kimee01");
		session.setAttribute("profileImg", "/photo/profile_img1.jpg");
		session.setAttribute("iconImg", "resources/img/icon/icon1.png");
		session.setAttribute("adminYn", "N");
		
		Map<String, Object> result = new HashMap<String, Object>();

		// 운동메이트 여부 체크
		// check!!(나중에 찐으로 넣어줘야 함)
		String fromUserId = (String) session.getAttribute("loginId");
		String toUserId = "moma123";
		result.put("isMate", mateService.checkMate(fromUserId,toUserId));
				
		// 차단 여부 체크
		result.put("isBlocked", mateService.checkBlock(fromUserId,toUserId));

		// 좋아요 여부 체크
		result.put("isLiked", mateService.checkLike(fromUserId,toUserId));
		
		// 프로필 데이터 가져오기
		MateDTO profileDto = mateService.getProfile(toUserId);
		logger.info("[프로필] 생일: {}/ 동:{}",profileDto.getBirth(),profileDto.getMate());
		
		//check!!(효율적인 방법찾기)
		result.put("image", profileDto.getImage());
		result.put("nickname", profileDto.getNickname());
		result.put("dong", profileDto.getNickname());
		result.put("shortsido", profileDto.getShortsido());
		result.put("gender", profileDto.getGender());
		result.put("birth", profileDto.getBirth());
		result.put("exercise_min", profileDto.getExercise_min());
		result.put("exercise_dis", profileDto.getExercise_dis());
		result.put("exercise", profileDto.getExercise());
		result.put("mate", profileDto.getMate());
		result.put("content", profileDto.getContent());
		
		model.addAttribute("result", result);
		
		return "mate/profileDetail";
	}

	@RequestMapping(value="/mateAppliaction")
	@ResponseBody
	public Map<String, Object> mateApplication(String fromUserId, String toUserId, Model model) {
		logger.info("[controller] mateApplication");
		logger.info("fromUserId : {}, toUserId : {}", fromUserId, toUserId);
		boolean success = mateService.mateApplication(fromUserId, toUserId);
		logger.info("success : "+success);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", success);
		return result;

	}
}
