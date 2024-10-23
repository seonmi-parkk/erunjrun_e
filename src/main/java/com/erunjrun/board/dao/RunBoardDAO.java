package com.erunjrun.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.board.dto.RunBoardDTO;


@Mapper
public interface RunBoardDAO {
	
	int count(int cnt_);

	List<RunBoardDTO> bHitList();

	List<RunBoardDTO> list(int limit, int offset, String code_name, String use_yn, String is_map);

	List<RunBoardDTO> search(String opt, String keyword, int limit, int offset);

	int getSearchTotalPages(String opt, String keyword);

}
