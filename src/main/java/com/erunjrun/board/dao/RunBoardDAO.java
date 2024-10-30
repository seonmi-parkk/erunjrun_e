package com.erunjrun.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.member.dto.MemberDTO;


@Mapper
public interface RunBoardDAO {
	
	int count(int cnt_);

	List<RunBoardDTO> bHitList();

	List<RunBoardDTO> list(int limit, int offset, String code_name, String use_yn, String is_map);

	List<RunBoardDTO> search(String opt, String keyword, int limit, int offset);

	int getSearchTotalPages(String opt, String keyword);

	int insertRunBoard(RunBoardDTO runBoard);

	int insertRouteData(int board_idx, Double latitude, Double longitude, String path, int order_num);

	int fileWrite(ImageDTO img);

	int point(RunBoardDTO point);

	RunBoardDTO detail(int board_idx);

	List<RunBoardDTO> mapData(int board_idx);

	int bHit(int board_idx);

	int like(int board_idx, String loginId);

	int disLike(int board_idx, String loginId);

	int addLike(int board_idx, String loginId);

	int updateDelLike(int board_idx);

	int updateLike(int board_idx);

	int runUpdate(RunBoardDTO runBoardDto);

	int deleteRouteData(int board_idx);

	int deleteImg(int board_idx);

	int runBoardDelete(int board_idx);

	int boardPoint(Map<String, Object> boardPoint);

	MemberDTO nickName(String loginId);





}
