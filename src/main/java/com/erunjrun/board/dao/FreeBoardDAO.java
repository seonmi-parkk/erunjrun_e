package com.erunjrun.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.admin.dto.RightDTO;
import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.member.dto.MemberDTO;


@Mapper
public interface FreeBoardDAO {

	int freeCount(int cnt_);

	List<RunBoardDTO> freeList(int limit, int offset, String code_name, String use_yn, String sortColumn, String sortOrder);

	List<RunBoardDTO> freeSearch(String opt, String keyword, int limit, int offset);

	int freeGetSearchTotalPages(String opt, String keyword);

	int insertFreeBoard(RunBoardDTO runBoard);

	int fileWrite(ImageDTO img);

	int bHit(int board_idx);

	RunBoardDTO detail(int board_idx);

	int like(int board_idx, String loginId);

	MemberDTO nickName(String loginId);

	int coun(int board_idx);

	int boardPoint(Map<String, Object> boardPoint);

	int disLike(int board_idx, String loginId);

	int updateDelLike(int board_idx);

	int addLike(int board_idx, String loginId);

	int updateLike(int board_idx);

	int freeUpdate(RunBoardDTO runBoardDto);

	int deleteImg(int board_idx);

	int freeBoardDelete(int board_idx);

	RightDTO right(String userId);

	RightDTO ban(String loginId);
	
	





}
