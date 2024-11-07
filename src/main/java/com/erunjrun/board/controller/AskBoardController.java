package com.erunjrun.board.controller;

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

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.board.service.AskBoardService;
import com.erunjrun.image.dto.ImageDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class AskBoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AskBoardService askService;
	
	@GetMapping(value="/askBoard")
	public String list() {
		return "askBoard/askBoardList";
	}

	// 문의하기 게시판 리스트
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
		public String write(HttpSession session) {
			
			String userId = (String) session.getAttribute("loginId");
			String page ="";
			
			if(userId == null) {
				page = "member/login";
			}else {
				page ="askBoard/askBoardWrite";
			}
			
			
			return page;
		}
		
		 // 게시글 등록
	    @PostMapping(value = "/askBoardWrite")
	    @ResponseBody
	    public Map<String, Object> submitPost(@RequestParam("imgsJson") String imgsJson, @ModelAttribute RunBoardDTO runBoardDto) {
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
	        
	        int ask_idx = askService.submitPost(runBoardDto);
	        
	        // 게시글 등록 서비스 호출
	        if (ask_idx > 0) {
	            logger.info("글 업로드 완료");
	            resultMap.put("success", true);
	            resultMap.put("ask_idx", runBoardDto.getAsk_idx());
	            logger.info("제목3 : "+runBoardDto.getSubject());
	        }

	        return resultMap;
	    }
		
		
		// 집에서 작업한거 추가할거임 
		
		@RequestMapping(value="/askBoardDetail/{ask_idx}")
		public String detail(@PathVariable int ask_idx,Model model,HttpSession session) {
			
			RunBoardDTO info = askService.detail(ask_idx);
			
			model.addAttribute("info", info);
			
			String page ="";
			String userId = (String) session.getAttribute("loginId");
			String admin = (String) session.getAttribute("adminYn");
			if(userId != null && userId.equals(info.getId()) || admin.equals("Y")) {
				page ="askBoard/askBoardDetail";
	 		}else {
	 			page = "redirect:/loginView";
	 		}
			
			return page;
		}
		
		@GetMapping(value="/askBoardUpdate/{ask_idx}")
		public String update(@PathVariable int ask_idx,Model model,HttpSession session) {
			
			RunBoardDTO post = askService.detail(ask_idx);
			
			model.addAttribute("post", post);
			
			String page ="";
			String userId = (String) session.getAttribute("loginId");
			if(userId != null && post.getId() == userId) {
	 			page ="askBoard/askBoardUpdate";
	 		}else {
	 			page = "redirect:/loginView";
	 		}
			
			return page;
						
		}
		
		@PostMapping(value="/askBoardUpdate")
		@ResponseBody
		public Map<String, Object> runUpdate(@RequestParam("imgsJson") String imgsJson,String code_name,
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
	      
	        success = askService.askUpdate(runBoardDto,code_name); // 수정 서비스 호출

	        if (success) {
	        	resultMap.put("success", true);
	        	resultMap.put("message", "게시글이 성공적으로 수정되었습니다.");
	        }
	        
	        return resultMap;
	    }
		
		 // 이미지 저장
	    @PostMapping(value = "/image-ask")
	    @ResponseBody
	    public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile file) {
	        logger.info("file : " + file.getOriginalFilename());

	        try {
	            // 파일을 저장하고 결과를 반환
	            Map<String, Object> resultFileMap = askService.saveFile(file);
	            return ResponseEntity.ok(resultFileMap);
	        } catch (Exception e) {
	            // 오류 발생 시 500 에러 응답
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 실패");
	        }
	    }
	    
	    // 게시글 삭제
	    @PostMapping(value="/askBoardDelete/{ask_idx}")
		@ResponseBody
		public Map<String,Object> delete(@PathVariable int ask_idx){
	    	
	    	Map<String,Object> result = new HashMap<String, Object>(); 
	    	
	    	boolean success = askService.askBoardDelete(ask_idx);
	    	logger.info("최종비활 : "+success);
	    	
	    	if(success) {
	    		result.put("success", true);    		
	    	}else {
	    		result.put("success", false);    
	    	}
	    	
	    	return result;
	    }
		
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
