package com.erunjrun.board.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.board.dao.AskBoardDAO;
import com.erunjrun.board.dto.RunBoardDTO;

@Service
public class AskBoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AskBoardDAO askDAO;
	public int askCount(int cnt_) {
		
		return askDAO.askCount(cnt_);
	}
	public List<RunBoardDTO> askList(int limit, int offset, String code_name) {
		
		return askDAO.askList(limit,offset,code_name);
	}

	
	
	
}
