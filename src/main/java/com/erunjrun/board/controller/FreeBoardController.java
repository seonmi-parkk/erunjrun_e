package com.erunjrun.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.admin.dto.RightDTO;
import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.board.service.FreeBoardService;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.member.dto.MemberDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class FreeBoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired FreeBoardService freeBoardService;
	
	@GetMapping(value="/freeBoard")
	public String list(HttpSession session,Model model) {
		String userId = (String) session.getAttribute("loginId");
		RightDTO right = freeBoardService.right(userId);
		
		logger.info("권한정지된 : "+right);
		
		model.addAttribute("right", right);
		
		return "freeBoard/freeBoardList";
	}
	
	// 프리 게시판 리스트
	@PostMapping("/freeBoardList")
	@ResponseBody
	public Map<String, Object> list(String page, String cnt, String opt, String keyword, String code_name,String use_yn,
			@RequestParam(defaultValue = "create_date") String sortColumn,@RequestParam(defaultValue = "ASC") String sortOrder) {

	    int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);

	    int limit = cnt_;
	    int offset = (page_ - 1) * cnt_;
	    int totalpage; 
	   
	    
	    List<RunBoardDTO> resultList = new ArrayList<>(); // 불러온 리스트들을 담을 리스트 생성
	    
	    // 검색어가 있는 경우
	    if (keyword != null && !keyword.isEmpty()) {
	    	limit = 15;
	    	resultList = freeBoardService.searchList(opt, keyword, limit, offset);  // 검색 결과 리스트
	    	totalpage = freeBoardService.getSearchTotalPages(opt, keyword);  // 검색 결과에 따른 게시글 수 계산
	    	logger.info("검색 총 페이지 수"+totalpage);
	    }else {
	    	
	    	 totalpage = freeBoardService.count(cnt_);// 검색 조건이 없는 경우의 전체 게시글 수
	    	 logger.info("총 페이지 수"+totalpage);
	    	    	
	    	 // 검색어가 없는 경우 일반 게시글 리스트 가져오기
	    	 resultList.addAll(freeBoardService.list(limit, offset, code_name, use_yn,sortColumn,sortOrder));
	    }
	    
	    Map<String, Object> result = new HashMap<>();
	    result.put("totalpages", totalpage);
	    result.put("currPage", page_);
	    result.put("resultList", resultList);

	    return result;
	}
	
	@GetMapping(value="/freeBoardWrite")
	public String write(HttpSession session) {
		
		String page ="";
 		String userId = (String) session.getAttribute("loginId");
 		if(userId == null) {
 			page = "member/login";
 		}else {
 			page ="freeBoard/freeBoardWrite";
 		}
 		
 		return page;
	}
	
	 // 이미지 저장
    @PostMapping(value = "/image-free")
    @ResponseBody
    public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile file) {
        logger.info("file : " + file.getOriginalFilename());

        try {
            // 파일을 저장하고 결과를 반환
            Map<String, Object> resultFileMap = freeBoardService.saveFile(file);
            return ResponseEntity.ok(resultFileMap);
        } catch (Exception e) {
            // 오류 발생 시 500 에러 응답
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 실패");
        }
    }
    
    // 게시글 등록
    @PostMapping(value = "/freeBoardWrite")
    @ResponseBody
    public Map<String, Object> submitPost(@RequestParam("imgsJson") String imgsJson, @ModelAttribute RunBoardDTO runBoardDto,HttpSession session) {
        Map<String, Object> resultMap = new HashMap<>();
        

        // JSON 문자열을 ImageDTO 리스트로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        List<ImageDTO> imgs = null;
        try {
            // TypeFactory를 사용하여 제네릭 타입을 처리하여 변환
            imgs = objectMapper.readValue(imgsJson, objectMapper.getTypeFactory().constructCollectionType(List.class, ImageDTO.class));
            runBoardDto.setImageList(imgs);  // 변환한 이미지 리스트를 RunBoardDTO에 설정
        } catch (Exception e) {
            logger.error("파싱 오류 : {}", e.getMessage());
            return Map.of("error", e.getMessage());
        }

        // 변환된 이미지 리스트 확인
        if (imgs != null && !imgs.isEmpty()) {
            for (ImageDTO img : imgs) {
                logger.info("Original Filename: " + img.getImg_ori());
                logger.info("New Filename: " + img.getImg_new());
            }
        }
        
        logger.info("imgDTO : " + runBoardDto.toString());
                
        // 게시글 등록 서비스 호출
        int ask_idx = freeBoardService.submitPost(runBoardDto,session);
        
        // 게시글 등록 서비스 호출
        if (ask_idx > 0) {
            logger.info("글 업로드 완료");
            resultMap.put("success", true);
            resultMap.put("board_idx", runBoardDto.getBoard_idx());
            logger.info("제목3 : "+runBoardDto.getSubject());
        }

        return resultMap;
    }
    
    // 게시글 상세보기
    @RequestMapping(value="/freeBoardDetail/{board_idx}")
    public String detail(@PathVariable int board_idx,Model model,HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	logger.info("로그인 아이디 : "+loginId);
    	boolean isLike = freeBoardService.like(board_idx, loginId);
    	logger.info("조아요 여부 : "+isLike);
    	MemberDTO nickname = null;
    	if(loginId != null) {
    		nickname = freeBoardService.nickName(loginId);
    		logger.info("닉네임 맞냐 :"+nickname);
    	}
   
    	RunBoardDTO run = freeBoardService.detail(board_idx);
    	logger.info("내용 : "+run.toString());
    	
    	RightDTO ban = freeBoardService.ban(loginId);
       
        int countComment = freeBoardService.coun(board_idx);
        logger.info("댓글수 : "+countComment);
        
    	model.addAttribute("isLike", isLike);
    	model.addAttribute("info", run);
    	model.addAttribute("nickname", nickname);
    	model.addAttribute("coun", countComment);
    	model.addAttribute("ban", ban);

    	return "freeBoard/freeBoardDetail";
    }
    
    // 추천 업데이트
    @PostMapping(value="/freeBoardLike")
    @ResponseBody
    public Map<String, Object> like(int board_idx, HttpSession session){
    	String loginId = (String) session.getAttribute("loginId");
    	logger.info("로그인 아이디 : "+loginId);
    	boolean isLike = freeBoardService.like(board_idx, loginId);
    	logger.info("아작스로 안조아요 여부 : "+isLike);
    	
    	
    	Map<String,Object> result = new HashMap<String, Object>();
		if(isLike) {
			if(freeBoardService.disLike(board_idx, loginId)) {				
				result.put("like", false);
			}
		}else {
			if(freeBoardService.addLike(board_idx, loginId)) {				
				result.put("like", true);
			}
		}
    	
    	return result;
    }
    
    @GetMapping(value="/freeBoardUpdate/{board_idx}")
    public String runBoardUpdate(@PathVariable int board_idx, Model model,HttpSession session) {
    	
    	RunBoardDTO run = freeBoardService.detail(board_idx);
    	logger.info("내용 : "+run);    	
        
        model.addAttribute("post", run);
         
        String page ="";
		String userId = (String) session.getAttribute("loginId");
		if(userId != null && userId.equals(run.getId())) {
			page ="freeBoard/freeBoardUpdate";
 		}else {
 			page = "redirect:/loginView";
 		}
  		
  		return page;
    	
    }
    
    //게시글 수정 요청
    @PostMapping(value="/freeBoardUpdate")
    @ResponseBody
    public Map<String, Object> freeUpdate(@RequestParam("imgsJson") String imgsJson,
            @ModelAttribute RunBoardDTO runBoardDto, HttpSession session){
    	
    	String loginId = (String) session.getAttribute("loginId");
        runBoardDto.setId(loginId);
        logger.info("수정할 작성자 : "+loginId);
        
        
        Map<String, Object> resultMap = new HashMap<>();
        boolean success = false;

        // JSON 파싱 및 DTO에 설정
        ObjectMapper objectMapper = new ObjectMapper();
        List<ImageDTO> imgs = null;
        try {
            imgs = objectMapper.readValue(imgsJson, objectMapper.getTypeFactory().constructCollectionType(List.class, ImageDTO.class));
            runBoardDto.setImageList(imgs);
        } catch (Exception e) {
            logger.error("이미지 파싱 오류 : {}", e.getMessage());
            resultMap.put("error", "이미지 파싱 오류 발생");
            return resultMap;
        }

        success = freeBoardService.freeUpdate(runBoardDto); // 수정 서비스 호출
        
        if (success) {
        	resultMap.put("success", true);
        	resultMap.put("message", "게시글이 성공적으로 수정되었습니다.");
        }
        
        return resultMap;
    }
    
    @PostMapping(value="/freeBoardDelete/{board_idx}")
    @ResponseBody
    public Map<String,Object> runBoardDelete(@PathVariable int board_idx){
    	
    	Map<String,Object> result = new HashMap<String, Object>();
    	
    	boolean success = freeBoardService.freeBoardDelete(board_idx);
    	logger.info("최종비활 : "+success);
    	
    	if(success) {
    		result.put("success", true);    		
    	}else {
    		result.put("success", false);    
    	}
    	
    	
    	return result;
    }
    
    
	
	
	
	
	
	
	
	
	
	
	
	
}
