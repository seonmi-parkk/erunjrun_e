package com.erunjrun.report.dao;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.comment.dto.CommentDTO;
import com.erunjrun.crew.dto.CrewNoticeDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.report.dto.ReportDTO;

@Mapper
public interface ReportDAO {

	int report(ReportDTO reportDto);

	RunBoardDTO reput(int board_idx);

	int fileWrite(ImageDTO imageDTO);

	CommentDTO comment(int comment_idx);

	int reportComment(ReportDTO reportDto);

	int reportNoticeComment(ReportDTO reportDto);

	CrewNoticeDTO crew(int comment_idx);



	

	

	



	

}
