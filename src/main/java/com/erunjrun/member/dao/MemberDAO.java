package com.erunjrun.member.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.member.dto.MemberDTO;
import com.erunjrun.member.dto.ProfileDTO;

@Mapper
public interface MemberDAO {

	int join(Map<String, String> params);

	int idOverlay(String id);

	int nickNameOverlay(String nickName);

	int emailOverlay(String email);

	int login(String id, String pw);

	MemberDTO findMemberId(MemberDTO dto);

	MemberDTO findMemberPw(MemberDTO dto);

	void updatePw(String id, String tempPw);

	MemberDTO profileView(String id);
	
	ProfileDTO ProfileImage(String id);

	int profileUpdate(Map<String, String> params);

	int updateProfileImage(Map<String, String> params);

	MemberDTO findSessionId(String id);

	void setUseY(String id);

}
