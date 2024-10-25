package com.erunjrun.mypage.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.member.dto.MemberDTO;
import com.erunjrun.member.dto.ProfileDTO;

@Mapper
public interface MypageDAO {

	MemberDTO findSessionId(String id);

	MemberDTO profileDetail(String id);

	ProfileDTO ProfileImage(String id);

	int profileUpdate(Map<String, String> params);

	int updateProfileImage(Map<String, String> params);

	void setUseY(String id);

	void updateProfile_use(String id, String Profile_use);

	void firstExerciseProfile(Map<String, String> params);

}
