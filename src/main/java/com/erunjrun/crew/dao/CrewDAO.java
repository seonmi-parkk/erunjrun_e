package com.erunjrun.crew.dao;

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

	
	

}