package com.erunjrun.crew.dao;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.crew.dto.CrewDTO;
import com.erunjrun.crew.dto.CrewMemberDTO;
import com.erunjrun.image.dto.ImageDTO;

@Mapper
public interface CrewDAO {

	int submitPost(CrewDTO crewDto);

	void fileWrite(ImageDTO img);

	void memberUpdate(CrewMemberDTO crewMemberDto);

	void tagUpdate(CrewDTO crewDto);

	void fileUpload(ImageDTO imageDto);

	int crewDelete(int crew_idx);

	int crewMemberDelete(int crew_idx);

	int crewTagDelete(int crew_idx);

}