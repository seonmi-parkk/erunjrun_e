package com.erunjrun.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.main.dto.AlarmDTO;
import com.erunjrun.main.service.AlarmService;

@Controller
public class AlarmController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AlarmService alarm_service;
	@Autowired AlarmDTO alarm_dto;
	
	@GetMapping(value="/alarmCount")
	@ResponseBody
	public int alarmCount(@RequestParam String loginId){
		
//		logger.info("알림 수 : loginId => " + loginId);
		
		return alarm_service.alarmCount(loginId);
	}
	
	@PostMapping(value="/alarmList")
	@ResponseBody
	public Map<String, Object> alarmList(@RequestParam String loginId){
		
//		logger.info("알림 리스트 : loginId => " + loginId);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("result", alarm_service.alarmList(loginId));
		
		return resultMap;
	}
	
	public void crewAdmin(int crew_idx, String id, String from_id) {
//		logger.info("크루 권한 crew_idx => " + crew_idx);
//		logger.info("크루 권한 id => " + id);
//		logger.info("크루 권한 from_id => " + from_id);
		
		alarm_dto.setId(id); // 받는 사람 id
		alarm_dto.setFrom_id(from_id); // 보낸 사람 id (크루장)
		alarm_dto.setSubject("크루 권한"); // 제목
		alarm_dto.setCode_name("AC100"); // 구분코드
		alarm_dto.setUrl("/crewDetail/" + crew_idx); // 이동 url
		alarm_dto.setIdx(crew_idx);
		
//		alarm_dto.setIs_url("N"); // default 값 (생략)
//		alarm_dto.setContent(); // 크루이름 (insert 할 때 idx 로 뽑아와서 넣기)
		
		alarm_service.crewAdmin(alarm_dto);
	}
	

	// 크루 퇴출
	public void crewMemberExpel(int crew_idx, List<String> ids) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("idx", crew_idx);
		param.put("idList", ids);
		param.put("subject", "크루 퇴출");
		param.put("code_name", "AC101");
		// from_id, content : select로 받아서 넣음
		
		alarm_service.crewMemberExpel(param);
	}
	
	// 크루 공지사항 댓글
	public void crewNoticeComment(int notice_idx, String from_id) {
//		logger.info("공지 idx => " + notice_idx);
//		logger.info("댓글 작성 id => " + from_id);
		
		alarm_dto.setSubject("공지 댓글");
		alarm_dto.setCode_name("AC102");
		alarm_dto.setFrom_id(from_id);
		alarm_dto.setIs_url("Y");
		alarm_dto.setUrl("/crewNoticeDetail/"+notice_idx);
		alarm_dto.setIdx(notice_idx);
		
		alarm_service.crewNoticeComment(alarm_dto);
		
		// id : crew_idx로 가져오기 (crew_notice)
		// contnet : notice_idx 로 가져오기 (crew_notice)
	}
	
}
