package com.erunjrun.board.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.board.service.RunBoardService;


@Controller
public class RunBoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired RunBoardService runBoardService;
	
	@GetMapping(value="/runBoard")
	public String list() {
		return "runBoard/runBoardList";
	}
	
	
	@GetMapping("/runBoardList")
	@ResponseBody
	public Map<String, Object> list(String page, String cnt, String opt, String keyword, String code_name,String use_yn,String is_map) {

	    int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);

	    int limit = cnt_;
	    int offset = (page_ - 1) * cnt_;
	    int totalpage; 
	   
	    
	    List<RunBoardDTO> resultList = new ArrayList<>(); // 불러온 리스트들을 담을 리스트 생성
	    
	    // 검색어가 있는 경우
	    if (keyword != null && !keyword.isEmpty()) {
	    	limit = 15;
	    	resultList = runBoardService.searchList(opt, keyword, limit, offset);  // 검색 결과 리스트
	    	totalpage = runBoardService.getSearchTotalPages(opt, keyword);  // 검색 결과에 따른 게시글 수 계산
	    	logger.info("검색 총 페이지 수"+totalpage);
	    }else {
	    	
	    	 totalpage = runBoardService.count(cnt_);// 검색 조건이 없는 경우의 전체 게시글 수
	    	 logger.info("총 페이지 수"+totalpage);
	    	 if (page_ == 1) { // 페이지가 1 일때
	    		 
	 	    	resultList.addAll(runBoardService.bHitList()); // 추천 게시물 3개 리스트에 담기
	 	    	limit = 12; // 이때 첫번째 페이지는 12개 보여줘
	 	    	offset = 0;
	 	    	
	 	    } else {
	 	    	
	 	    	limit = 15; // 2번째 페이지부터는 15개씩
	 	    	offset = (page_ - 1) * limit;
	 	    }
	    	
	    	 // 검색어가 없는 경우 일반 게시글 리스트 가져오기
	    	 resultList.addAll(runBoardService.list(limit, offset, code_name, use_yn, is_map));
	    }
	    
	    Map<String, Object> result = new HashMap<>();
	    result.put("totalpages", totalpage);
	    result.put("currPage", page_);
	    result.put("resultList", resultList);

	    return result;
	}
	
	@GetMapping(value="/runBoardWrite")
	public String write() {
		return "runBoard/runBoardWrite";
	}
	
//	@PostMapping(value="/runBoardWrite")
//	@ResponseBody
//    public ResponseEntity<String> mapWrite(@RequestBody RunBoardDTO boardDTO) {
//        try {
//            runBoardService.mapWrite(boardDTO);
//            return new ResponseEntity<>("게시글 등록 성공", HttpStatus.OK);
//        } catch (Exception e) {
//            return new ResponseEntity<>("게시글 등록 실패", HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
	
	
	
}
