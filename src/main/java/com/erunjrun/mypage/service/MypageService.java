package com.erunjrun.mypage.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.member.dto.MemberDTO;
import com.erunjrun.member.dto.ProfileDTO;
import com.erunjrun.mypage.dao.MypageDAO;
import com.erunjrun.mypage.dto.MypageDTO;

@Service
public class MypageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MypageDAO mypageDAO;
	
	public MemberDTO findSessionId(String id) {
		return mypageDAO.findSessionId(id);
	}
	
	public MemberDTO profileDetail(String id) {
		MemberDTO member = mypageDAO.profileDetail(id);
		return member;
	}
	
	public ProfileDTO ProfileImage(String id) {
		ProfileDTO profile = mypageDAO.ProfileImage(id); // 프로필 이미지 정보 조회
		return profile;
	}
	
	public void profileUpdate(Map<String, String> params) {
		int row = mypageDAO.profileUpdate(params); // 회원 정보 업데이트
		logger.info("Update ID: {}", params.get("id"));
		logger.info("Updated rows in member table: {}", row);

		// 이미지 업데이트가 포함된 경우
		if (params.get("image") != null) {
			int profileUpdateRow = mypageDAO.updateProfileImage(params); // 프로필 이미지 업데이트
			logger.info("Updated rows in profile table: {}", profileUpdateRow);
		}
	}

	public void setUseY(String id) {
		mypageDAO.setUseY(id);
	}

	public void updateProfile_use(String id, String Profile_use) {
		mypageDAO.updateProfile_use(id, Profile_use);
		
	}

	public void firstExerciseProfile(Map<String, String> params) {
		mypageDAO.firstExerciseProfile(params);
		
	}

	public MypageDTO mypageDetail(String id) {
	    return mypageDAO.mypageDetail(id);
	}
	
	public void updateProfileVisibility(String id, String profileVisibility) {
	    // DB에서 프로필 공개 여부 업데이트
	    mypageDAO.updateProfileVisibility(id, profileVisibility);
	}

	public void updateMateSearch(String id, String mateSearch) {
	    // DB에서 운동 메이트 찾기 여부 업데이트
	    mypageDAO.updateMateSearch(id, mateSearch);
	}

	public void ExerciseProfileUpdate(Map<String, String> params) {
		mypageDAO.ExerciseProfileUpdate(params);
		
	}
}
