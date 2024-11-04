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
	
}
