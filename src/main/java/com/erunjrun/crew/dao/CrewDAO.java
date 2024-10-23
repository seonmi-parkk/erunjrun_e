package com.erunjrun.crew.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.crew.dto.CrewDTO;
import com.erunjrun.crew.dto.CrewMemberDTO;
import com.erunjrun.image.dto.ImageDTO;

@Mapper
public interface CrewDAO {

	int submitPost(CrewDTO crewDto);

	void fileWrite(ImageDTO img);

	void memberUpload(CrewMemberDTO crewMemberDto);

	void tagUpload(CrewDTO crewDto);

	void fileUpload(ImageDTO imageDto);

	int crewDelete(int crew_idx);

	int crewMemberDelete(int crew_idx);

	int crewTagDelete(int crew_idx);

	Map<String, Object> crewUpdateView(int crew_idx);

	int crewUpdate(CrewDTO crewDto);

	void tagUpdate(CrewDTO crewDto);
	
	

}