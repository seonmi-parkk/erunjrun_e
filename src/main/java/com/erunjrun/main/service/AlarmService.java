package com.erunjrun.main.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.main.dao.AlarmDAO;
import com.erunjrun.main.dto.AlarmDTO;

@Service
public class AlarmService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AlarmDAO alarm_dao;
	@Autowired AlarmDTO alarm_dto;
	
	// 알림 수
	public int alarmCount(String loginId) {
		return alarm_dao.alarmCount(loginId);
	}
	
	// 알림 리스트
	public List<AlarmDTO> alarmList(String loginId) {
		return alarm_dao.alarmList(loginId);
	}

	// 크루 권한 알림 insert
	public void crewAdmin(AlarmDTO alarm_dto) {
		alarm_dao.crewAdmin(alarm_dto);
	}

	// 크루 퇴출 알림 insert
	public void crewMemberExpel(Map<String, Object> param) {
		alarm_dao.crewMemberExpel(param);
	}

	public void crewNoticeComment(AlarmDTO alarm_dto) {
		alarm_dao.crewNoticeComment(alarm_dto);
	}

	public void boardComment(AlarmDTO alarm_dto) {
		alarm_dao.boardComment(alarm_dto);
	}

	public void personalChat(AlarmDTO alarm_dto) {
		alarm_dao.personalChat(alarm_dto);
	}

	public void crewLeaderChat(AlarmDTO alarm_dto) {
		alarm_dao.crewLeaderChat(alarm_dto);
	}

	public void crewGroupChat(AlarmDTO alarm_dto) {
		alarm_dao.crewGroupChat(alarm_dto);
	}

	public int alarmUseUpdate(int alarm_idx) {
		return alarm_dao.alarmUseUpdate(alarm_idx);
	}

	public void askCommentAlarm(AlarmDTO alarm_dto) {
		logger.info("문의하기 답변 알림 추가");
		alarm_dao.askCommentAlarm(alarm_dto);
	}
	
}
