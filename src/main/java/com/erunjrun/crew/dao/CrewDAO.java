package com.erunjrun.crew.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.crew.dto.CrewDTO;
import com.erunjrun.crew.dto.CrewMemberDTO;
import com.erunjrun.image.dto.ImageDTO;

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

	Map<String, Object> crewUpdateView(int crew_idx);

	int crewUpdate(CrewDTO crewDto);

	int tagUpdate(CrewDTO crewDto);

	int fileUpdate(ImageDTO imageDto);

	int fileTemUpdate(ImageDTO img);

	CrewDTO crewDetail(int crew_idx);

	List<CrewMemberDTO> crewMemberList(int crew_idxs);

	List<CrewMemberDTO> crewApplicationList(int crew_idxs);

	int crewApplicationWrite(Map<String, Object> parmeterMap);

	int crewApplicationCancel(Map<String, Object> parmeterMap);

	int crewMemberCencel(Map<String, Object> parmeterMap);

	int crewHistoryWrite(Map<String, Object> parmeterMap);

	int likeIs(Map<String, Object> parmeterMap);

	int likeRequest(Map<String, Object> parmeterMap);

	int likeCencel(Map<String, Object> parmeterMap);

	List<Map<String, Object>> crewList(List<String> filtering, int offset, int pageSize);
	
	

}