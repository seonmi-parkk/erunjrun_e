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
	
	// 크루 공지사항 댓글 알림
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
	
	// 게시글 댓글 알림
	public void boardComment(int board_idx, String from_id, String board_name) {
		logger.info("게시글 알림 들어옴");
		alarm_dto.setSubject("게시글 댓글");
		alarm_dto.setCode_name("AB100");
		alarm_dto.setIs_url("Y");
		alarm_dto.setIdx(board_idx);
		alarm_dto.setFrom_id(from_id);
		
		if(board_name.equals("R")) {
			alarm_dto.setUrl("/runBoardDetail/"+board_idx); // 러닝 코스 게시판
		}else {
			alarm_dto.setUrl("/freeBoardDetail/"+board_idx); // 자유 게시판
		}
		
		alarm_service.boardComment(alarm_dto);
	}
	
	// 문의하기 답글 알림
	public void askCommentAlarm(int ask_idx, String from_id) {
		logger.info("문의하기 알림 들어옴");
		alarm_dto.setSubject("문의 답변");
		alarm_dto.setCode_name("AM100");
		alarm_dto.setIs_url("Y");
		alarm_dto.setIdx(ask_idx);
		alarm_dto.setFrom_id(from_id);
		alarm_dto.setUrl("/askBoardDetail/"+ask_idx);
		
		alarm_service.askCommentAlarm(alarm_dto);
	}
	
	// 1:1 채팅 알림
	public void personalChat(int idx, String id, String from_id) {
		
		logger.info("개인 채팅 알림 insert===================================================");
		logger.info("idx ======================> " + idx);
		logger.info("id ======================> " + id);
		logger.info("from_id ======================> " + from_id);
		alarm_dto.setId(id);
		alarm_dto.setFrom_id(from_id);
		alarm_dto.setSubject("1:1 채팅");
		alarm_dto.setCode_name("AN100");
		alarm_dto.setIs_url("Y");
		alarm_dto.setIdx(idx);
		alarm_dto.setUrl("/chat/"+idx);
		
		alarm_service.personalChat(alarm_dto);
	}
	
	// 크루장 채팅 알림 
	public void crewChat(int idx, String from_id, String code) {
		logger.info("크루장 1 대 1 채팅 알림 메서드 호출" + idx + " : " +from_id);
		
		if(code.equals("P")) { // 크루장 1 : 1
			alarm_dto.setSubject("크루 1:1");
			alarm_dto.setCode_name("AN101");
			alarm_dto.setFrom_id(from_id);
			alarm_dto.setIdx(idx);
			alarm_dto.setIs_url("Y");
			alarm_dto.setUrl("/crewLdchat/open/"+idx);
			
			alarm_service.crewLeaderChat(alarm_dto);
		}else { // 크루 채팅
			alarm_dto.setSubject("크루 채팅");
			alarm_dto.setCode_name("AN102");
			alarm_dto.setFrom_id(from_id);
			alarm_dto.setIdx(idx);
			alarm_dto.setIs_url("Y");
			// /crewChat/open/crew_idx/chat_idx -> crew_idx는 chat_idx로 가져와야 함
			// alarm_dto.setUrl("/crewChat/open/52/12"+idx);
			
			alarm_service.crewGroupChat(alarm_dto);
		}
		// 크루 채팅 알림
		// 알림 테이블에 insert => url ()
		
	}
	
	@GetMapping(value="/alarmUseUpdate")
	@ResponseBody
	public boolean alarmUseUpdate(@RequestParam int alarm_idx) {
		
		if(alarm_service.alarmUseUpdate(alarm_idx) > 0) {
			return true;
		}
		
		return false;
	}
	
	
	
}
