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

	@Autowired MemberDAO memberDAO;

	public boolean join(Map<String, String> params) {
		
		boolean success = false;
		if (memberDAO.join(params) > 0) {
			success = true;
		}
		return success;
	}

	public Object idOverlay(String id) {
		return memberDAO.idOverlay(id);
	}

	public int nickNameOverlay(String nickName) {
		return memberDAO.nickNameOverlay(nickName);
	}

	public int emailOverlay(String email) {
		return memberDAO.emailOverlay(email);
	}

	public boolean login(String id, String pw) {
		
		boolean success = false;
		if (memberDAO.login(id, pw) > 0) {
			success = true;
		}
		return success;
	}
	
	public MemberDTO findSessionId(String id) {
		return memberDAO.findSessionId(id);
	}

	public MemberDTO findId(MemberDTO dto) {
		return memberDAO.findId(dto);
	}

	public MemberDTO findPw(MemberDTO dto) {
		return memberDAO.findPw(dto);
	}

	public void pwUpdate(String id, String tempPw) {
		memberDAO.pwUpdate(id, tempPw);
	}

}
