package com.erunjrun.mate.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.mate.dto.MateDTO;
import com.erunjrun.mate.dto.MateProfileDTO;

@Mapper
public interface MateDAO {

	int mateApplication(String fromUserId, String toUserId);

	int mateHistory(String fromUserId, String toUserId);

	int checkMate(String fromUserId, String toUserId);

	int checkBlock(String fromUserId, String toUserId);

	String profileOpen(String toUserId);

	int checkLike(String fromUserId, String toUserId);

	MateProfileDTO getProfile(String toUserId);

	int dislike(String fromUserId, String toUserId);

	int like(String fromUserId, String toUserId);

	MateDTO checkMateAppl(String fromUserId, String toUserId);

	int mateBlock(String fromUserId, String toUserId);

	int mateUnblock(String fromUserId, String toUserId);

	List<MateProfileDTO> getPos(String fromUserId);



}
