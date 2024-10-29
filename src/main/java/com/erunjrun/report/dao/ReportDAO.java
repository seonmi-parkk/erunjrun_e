package com.erunjrun.report.dao;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.report.dto.ReportDTO;

@Mapper
public interface ReportDAO {

	int report(ReportDTO reportDto);



	

}
