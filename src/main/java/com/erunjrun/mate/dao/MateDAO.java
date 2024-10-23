package com.erunjrun.mate.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MateDAO {

	int mateApplication(String fromUserId, String toUserId);

	int mateHistory(String fromUserId, String toUserId);

}
