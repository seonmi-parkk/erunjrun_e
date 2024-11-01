package com.erunjrun.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.board.service.AskBoardService;

@Controller
public class AskBoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AskBoardService askService;
	
	@GetMapping(value="/askBoard")
	public String list() {
		return "askBoard/askBoardList";
	}

	// 러닝코스 게시판
		@PostMapping("/askBoardList")
		@ResponseBody
		public Map<String, Object> list(String page, String cnt, String code_name) {

		    int page_ = Integer.parseInt(page);
		    int cnt_ = Integer.parseInt(cnt);

		    int limit = cnt_;
		    int offset = (page_ - 1) * cnt_;
		    int totalpage; 
		   
		    List<RunBoardDTO> resultList = askService.askList(limit, offset, code_name); // 불러온 리스트들을 담을 리스트 생성
		      	
		    totalpage = askService.askCount(cnt_);// 검색 조건이 없는 경우의 전체 게시글 수
		    logger.info("총 페이지 수"+totalpage);
		    	 
		    Map<String, Object> result = new HashMap<>();
		    result.put("totalpages", totalpage);
		    result.put("currPage", page_);
		    result.put("resultList", resultList);

		    return result;
		}
		
		@GetMapping(value="/askBoardWrite")
		public String write(Model model) {
			
			int row = askService.ask();
			
			model.addAttribute("ask", row);
			
			return "askBoard/askBoardWrite";
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
