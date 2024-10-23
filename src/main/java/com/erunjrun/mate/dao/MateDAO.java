package com.erunjrun.mate.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.mate.dto.MateDTO;

@Mapper
public interface MateDAO {

	int mateApplication(String fromUserId, String toUserId);

	int mateHistory(String fromUserId, String toUserId);

	int checkMate(String fromUserId, String toUserId);

	int checkBlock(String fromUserId, String toUserId);

	String profileOpen(String toUserId);

	int checkLike(String fromUserId, String toUserId);

	MateDTO getProfile(String toUserId, boolean isOpened);



}
