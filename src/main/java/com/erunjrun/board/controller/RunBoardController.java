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
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.board.service.RunBoardService;
import com.erunjrun.image.dto.ImageDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@EnableScheduling
@Controller
public class RunBoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired RunBoardService runBoardService;
	
	@GetMapping(value="/runBoard")
	public String list() {
		return "runBoard/runBoardList";
	}
	
	// 러닝코스 게시판
	@PostMapping("/runBoardList")
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
	
    // 이미지 저장
    @PostMapping(value = "/image-upload")
    @ResponseBody
    public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile file) {
        logger.info("file : " + file.getOriginalFilename());

        try {
            // 파일을 저장하고 결과를 반환
            Map<String, Object> resultFileMap = runBoardService.saveFile(file);
            return ResponseEntity.ok(resultFileMap);
        } catch (Exception e) {
            // 오류 발생 시 500 에러 응답
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 실패");
        }
    }

    // 게시글 등록
    @PostMapping(value = "/runBoardWrite")
    @ResponseBody
    public Map<String, Object> submitPost(@RequestParam("imgsJson") String imgsJson,@RequestParam("routeData") String routeData,
                                          @ModelAttribute RunBoardDTO runBoardDto) {
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
        
        // 경로 데이터 파싱
        try {
            // routeData를 Map 형태의 리스트로 파싱
            List<Map<String, Object>> routeList = objectMapper.readValue(routeData, new TypeReference<List<Map<String, Object>>>() {});

            List<Double> latitudeList = new ArrayList<>();
            List<Double> longitudeList = new ArrayList<>();
            List<String> pathList = new ArrayList<>();
            List<Integer> orderNumList = new ArrayList<>();

            // 각 맵에서 데이터 추출하여 리스트에 추가
            for (Map<String, Object> route : routeList) {
                latitudeList.add((Double) route.get("latitude"));
                longitudeList.add((Double) route.get("longitude"));
                pathList.add((String) route.get("path"));
                orderNumList.add((Integer) route.get("order_num"));
            }

            // DTO에 리스트 설정
            runBoardDto.setLatitudeList(latitudeList);
            runBoardDto.setLongitudeList(longitudeList);
            runBoardDto.setPathList(pathList);
            runBoardDto.setOrderList(orderNumList);

        } catch (Exception e) {
            logger.error("경로 데이터 파싱 오류 : {}", e.getMessage());
            return Map.of("error", e.getMessage());
        }
        
        // 게시글 등록 서비스 호출
        if (runBoardService.submitPost(runBoardDto)) {
            logger.info("글 업로드 완료");
            resultMap.put("success", true);
            resultMap.put("page", "runBoardUpdate");
            logger.info("제목3 : "+runBoardDto.getSubject());
        }

        return resultMap;
    }
    
    // 주간 포인트 지급
    @Scheduled(cron = "0 0 0 * * MON") // 매주 월요일에 실행
    public void point() {
    	logger.info("월요일마다 실행되는 작업입니다.");
        runBoardService.point();
    }
	
    // 게시글 상세보기
    @RequestMapping(value="/runBoardDetail/{board_idx}")
    public String detail(@PathVariable int board_idx,Model model,HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	logger.info("로그인 아이디 : "+loginId);
    	boolean isLike = runBoardService.like(board_idx, loginId);
    	logger.info("조아요 여부 : "+isLike);
    	
    	RunBoardDTO run = runBoardService.detail(board_idx);
    	logger.info("내용 : "+run);
    	List<RunBoardDTO> mapData = runBoardService.mapData(board_idx);
    	logger.info("맵 : "+mapData);
    	
    	String mapDataJson = "[]";
    	
    	 // mapData를 JSON 문자열로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        try {
			mapDataJson = objectMapper.writeValueAsString(mapData);
			logger.info("파싱 : "+mapDataJson);
		} catch (JsonProcessingException e) {
			logger.info("파싱 오류 : "+ e);
			e.printStackTrace();
		}
        
    	model.addAttribute("isLike", isLike);
    	model.addAttribute("info", run);
    	model.addAttribute("mapData", mapDataJson);

    	return "runBoard/runBoardDetail";
    }
    
    // 추천 업데이트
    @PostMapping(value="/boardLike")
    @ResponseBody
    public Map<String, Object> like(int board_idx, HttpSession session){
    	String loginId = (String) session.getAttribute("loginId");
    	logger.info("로그인 아이디 : "+loginId);
    	boolean isLike = runBoardService.like(board_idx, loginId);
    	logger.info("아작스로 안조아요 여부 : "+isLike);
    	
    	
    	Map<String,Object> result = new HashMap<String, Object>();
		if(isLike) {
			if(runBoardService.disLike(board_idx, loginId)) {				
				result.put("like", false);
			}
		}else {
			if(runBoardService.addLike(board_idx, loginId)) {				
				result.put("like", true);
			}
		}
    	
    	return result;
    }
    
    // 게시글 수정
    @GetMapping(value="/runBoardUpdate/{board_idx}")
    public String runBoardUpdate(@PathVariable int board_idx, Model model,HttpSession session) {
    	
    	RunBoardDTO run = runBoardService.detail(board_idx);
    	logger.info("내용 : "+run);
    	List<RunBoardDTO> mapData = runBoardService.mapData(board_idx);
    	logger.info("맵 : "+mapData);
    	
    	String mapDataJson = "[]";
    	
   	 	// mapData를 JSON 문자열로 변환
    	ObjectMapper objectMapper = new ObjectMapper();
    	try {
			mapDataJson = objectMapper.writeValueAsString(mapData);
			logger.info("파싱 : "+mapDataJson);
		} catch (JsonProcessingException e) {
			logger.info("파싱 오류 : "+ e);
			e.printStackTrace();
		}
    	
         
         model.addAttribute("post", run);
         model.addAttribute("mapData", mapDataJson); // 경로 데이터도 함께 전달
    	
    	return "runBoard/runBoardUpdate";
    }
    
    //게시글 수정 요청
    @PostMapping(value="/runBoardUpdate")
    @ResponseBody
    public Map<String, Object> runUpdate(@RequestParam("imgsJson") String imgsJson,@RequestParam("routeData") String routeData,
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

        // 경로 데이터 파싱 및 설정
        try {
            List<Map<String, Object>> routeList = objectMapper.readValue(routeData, new TypeReference<List<Map<String, Object>>>() {});
            List<Double> latitudeList = new ArrayList<>();
            List<Double> longitudeList = new ArrayList<>();
            List<String> pathList = new ArrayList<>();
            List<Integer> orderNumList = new ArrayList<>();

            for (Map<String, Object> route : routeList) {
                latitudeList.add((Double) route.get("latitude"));
                longitudeList.add((Double) route.get("longitude"));
                pathList.add((String) route.get("path"));
                orderNumList.add((Integer) route.get("order_num"));
            }

            runBoardDto.setLatitudeList(latitudeList);
            runBoardDto.setLongitudeList(longitudeList);
            runBoardDto.setPathList(pathList);
            runBoardDto.setOrderList(orderNumList);

            success = runBoardService.runUpdate(runBoardDto); // 수정 서비스 호출
        } catch (Exception e) {
            logger.error("경로 데이터 파싱 오류 : {}", e.getMessage());
            resultMap.put("error", "경로 데이터 파싱 오류 발생");
            return resultMap;
        }

        if (success) {
        	resultMap.put("success", true);
        	resultMap.put("message", "게시글이 성공적으로 수정되었습니다.");
        }
        
        return resultMap;
    }
    
    @PostMapping(value="/runBoardDelete/{board_idx}")
    @ResponseBody
    public Map<String,Object> runBoardDelete(@PathVariable int board_idx){
    	
    	Map<String,Object> result = new HashMap<String, Object>();
    	
    	boolean success = runBoardService.runBoardDelete(board_idx);
    	logger.info("최종비활 : "+success);
    	
    	if(success) {
    		result.put("success", true);    		
    	}else {
    		result.put("success", false);    
    	}
    	
    	
    	return result;
    }
    
	

	
	
	
}
