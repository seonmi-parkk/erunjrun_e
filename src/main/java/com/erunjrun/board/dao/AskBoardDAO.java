package com.erunjrun.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.board.dto.RunBoardDTO;

@Mapper
public interface AskBoardDAO {

	int askCount(int cnt_);

	List<RunBoardDTO> askList(int limit, int offset, String code_name);

	

}
