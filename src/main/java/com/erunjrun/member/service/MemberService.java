package com.erunjrun.member.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.member.dto.MemberDTO;

import com.erunjrun.member.dao.MemberDAO;

@Service
public class MemberService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MemberDAO memberDao;

	public boolean join(Map<String, String> params) {
		boolean success = false;

		if (memberDao.join(params) > 0) {
			success = true;
		}

		return success;
	}

	public Object idOverlay(String id) {
		return memberDao.idOverlay(id);
	}

	public int nickNameOverlay(String nickName) {
	    return memberDao.nickNameOverlay(nickName);
	}

	public int emailOverlay(String email) {
	    return memberDao.emailOverlay(email);
	}
	
	public boolean login(String id, String pw) {
		boolean success = false;
	
		if (memberDao.login(id, pw) > 0) {
			success = true;
		}
		
		return success;
	}

	public MemberDTO findMemberId(MemberDTO dto) {
		return memberDao.findMemberId(dto);
	}

	public MemberDTO findMemberPw(MemberDTO dto) {
		return memberDao.findMemberPw(dto);
	}

	public void updatePw(String id, String tempPw) {
		memberDao.updatePw(id, tempPw);
		
	}

	public MemberDTO profileView(String id) {
		return memberDao.profileView(id);
	}

	public void profileUpdate(Map<String, String> params) {
		int row = memberDao.profileUpdate(params);
		logger.info("Update ID: {}", params.get("id"));
		logger.info("update row: "+row);
	
	}

	public MemberDTO findSessionId(String id) {
		return memberDao.findSessionId(id);
	}

	public void setUseY(String id) {
		 memberDao.setUseY(id);
	}


}
