package com.erunjrun.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.image.dto.ImageDTO;

@Mapper
public interface AskBoardDAO {

	int askCount(int cnt_);

	List<RunBoardDTO> askList(int limit, int offset, String code_name);

	RunBoardDTO detail(int ask_idx);

	int askUpdate(RunBoardDTO runBoardDto);

	int deleteImg(int board_idx);

	int fileWrite(ImageDTO img);

	int askBoardDelete(int ask_idx);

	int insertAskBoard(RunBoardDTO runBoard);

	

}
