package com.erunjrun.mate.dao;

import com.erunjrun.mate.dto.MateDTO;
import com.erunjrun.mate.dto.MateProfileDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MateDAO {

	int mateApplication(String fromUserId, String toUserId);

	int mateHistory(String fromUserId, String toUserId);

	int checkMate(String fromUserId, String toUserId);

	int checkBlock(String fromUserId, String toUserId);

	int checkLike(String fromUserId, String toUserId);

	MateProfileDTO getProfile(String toUserId);

	int dislike(String fromUserId, String toUserId);

	int like(String fromUserId, String toUserId);

	MateDTO checkMateAppl(String fromUserId, String toUserId);

	int mateBlock(String fromUserId, String toUserId);

	int mateUnblock(String fromUserId, String toUserId);

	List<MateProfileDTO> searchMateList(MateProfileDTO userPos);

	MateProfileDTO getUserPos(String fromUserId);

	List<MateProfileDTO> getPosList(String fromUserId);

	List<MateProfileDTO> moveMateList(List<String> users, String fromUserId);

	String getExerciseUse(String fromUserId);

	int mateOn(String userId);

	int hasProfile(String fromUserId);



}
