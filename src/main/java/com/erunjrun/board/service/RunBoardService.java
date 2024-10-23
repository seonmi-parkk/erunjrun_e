package com.erunjrun.board.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.board.dao.RunBoardDAO;
import com.erunjrun.board.dto.RunBoardDTO;


@Service
public class RunBoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired RunBoardDAO runBoardDAO;
	
	public int count(int cnt_) {
		
		return runBoardDAO.count(cnt_);
	}


	public List<RunBoardDTO> bHitList() {
		
		return runBoardDAO.bHitList();
	}

	public List<RunBoardDTO> list(int limit, int offset, String code_name, String use_yn, String is_map) {
		
		return runBoardDAO.list(limit, offset,code_name,use_yn,is_map);
	}

	public List<RunBoardDTO> searchList(String opt, String keyword, int limit, int offset) {

		return runBoardDAO.search(opt, keyword, limit, offset);
	}

	public int getSearchTotalPages(String opt, String keyword) {

		return runBoardDAO.getSearchTotalPages(opt, keyword);
	}
	
}
