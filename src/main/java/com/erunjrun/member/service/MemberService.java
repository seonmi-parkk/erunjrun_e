package com.erunjrun.member.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.member.dto.MemberDTO;
import com.erunjrun.member.dto.ProfileDTO;
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
		MemberDTO member = memberDao.profileView(id);
		return member;
	}
	
	public ProfileDTO profileViewImage(String id) {
		ProfileDTO profile = memberDao.ProfileImage(id); // 프로필 정보 조회
		return profile;
	}
	
	public void profileUpdate(Map<String, String> params) {
		int row = memberDao.profileUpdate(params); // 회원 정보 업데이트
		logger.info("Update ID: {}", params.get("id"));
		logger.info("Updated rows in member table: {}", row);

		// 이미지 업데이트가 포함된 경우
		if (params.get("image") != null) {
			int profileUpdateRow = memberDao.updateProfileImage(params); // 프로필 이미지 업데이트
			logger.info("Updated rows in profile table: {}", profileUpdateRow);
		}
	}

	public MemberDTO findSessionId(String id) {
		return memberDao.findSessionId(id);
	}

	public void setUseY(String id) {
		memberDao.setUseY(id);
	}

}
