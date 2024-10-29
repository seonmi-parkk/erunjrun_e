package com.erunjrun.report.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.report.dao.ReportDAO;
import com.erunjrun.report.dto.ReportDTO;

@Service
public class ReportService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReportDAO reportDAO;
	public int report(ReportDTO reportDto) {
		
		return reportDAO.report(reportDto);
	}

	
	
	
}
