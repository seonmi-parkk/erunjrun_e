package com.erunjrun.crew.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.crew.dto.CrewDTO;
import com.erunjrun.crew.dto.CrewMemberDTO;
import com.erunjrun.crew.dto.CrewNoticeDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.member.dto.MemberDTO;

@Mapper
public interface CrewDAO {

	int submitPost(CrewDTO crewDto);

	int fileWrite(ImageDTO img);

	int memberUpload(CrewMemberDTO crewMemberDto);

	int tagUpload(CrewDTO crewDto);

	int fileUpload(ImageDTO imageDto);

	int crewDelete(int crew_idx);

	int crewMemberDelete(int crew_idx);

	int crewTagDelete(int crew_idx);
	
	int crewImgDelete(int img_no);

//	Map<String, Object> crewUpdateView(int crew_idx);
	
	CrewDTO crewUpdateView(int crew_idx);

	int crewUpdate(CrewDTO crewDto);

//	int tagUpdate(CrewDTO crewDto);

	int fileUpdate(ImageDTO imageDto);

	int fileTemUpdate(ImageDTO img);

	CrewDTO crewDetail(int crew_idx);

	List<CrewMemberDTO> crewMemberList(int crew_idxs);

	List<CrewMemberDTO> crewApplicationList(Map<String, Object> parmeterMap);

	int crewApplicationWrite(Map<String, Object> parmeterMap);

	int crewApplicationCancel(Map<String, Object> parmeterMap);

	int crewMemberCencel(Map<String, Object> parmeterMap);

	int crewHistoryWrite(Map<String, Object> parmeterMap);

	int likeIs(Map<String, Object> parmeterMap);

	int likeRequest(Map<String, Object> parmeterMap);

	int likeCencel(Map<String, Object> parmeterMap);

	List<Map<String, Object>> crewList(List<String> filtering, int offset, int pageSize);

	List<CrewMemberDTO> applicationAdminList(Map<String, Object> parmeterMap);

	int crewMemberApproval(Map<String, Object> parmeterMap);

	int crewMemberRefusal(Map<String, Object> parmeterMap);

	int crewChatInsert(int img_no);

	int crewAdminUpdate(Map<String, Object> parmeterMap);

	int crewExpel(Map<String, Object> params);

	int crewExpelHistoryWrite(Map<String, Object> params);

	Map<String, Object> crewPriorityOverlay(CrewNoticeDTO crewNoticeDto);

	int crewNoticeWrite(CrewNoticeDTO crewNoticeDto);

	int crewNoticePriorityUpdate(String crew_idx, String priority);

	List<CrewNoticeDTO> crewNoticeList(Map<String, Object> parmeterMap);

	CrewNoticeDTO crewNoticeUpdateView(int notice_idx);

	int crewNoticeUpdate(CrewNoticeDTO crewNoticeDto);

	CrewNoticeDTO crewNoticeDetail(int notice_idx);

	int crewNoticeHit(int notice_idx);

	int crewNoticeDelete(int notice_idx);

	int crewCurrentMemberUpdate(int crew_idx);

	MemberDTO nickName(String loginId);

	String crewLeaderCheck(int crew_idx);

	List<CrewMemberDTO> crewLikeCrew(String id);

	int crewMemberAdminUpdate(Map<String, Object> param);

	int crewLeaderUpdate(Map<String, Object> param);

	int crewLeaderChange(Map<String, Object> param);

	Date crewNoticeDate(int crew_idx);

	Integer crewChatMin(int crew_idx);
	
	

}