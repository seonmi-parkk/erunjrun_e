package com.erunjrun.crew.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.crew.dto.CrewDTO;
import com.erunjrun.crew.dto.CrewMemberDTO;
import com.erunjrun.crew.service.CrewService;
import com.erunjrun.image.dto.ImageDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;



@RestController
@RequestMapping("/crew")
@RequiredArgsConstructor
public class CrewController {
    
    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired CrewService crew_service;
    

    
	@PostMapping(value="/image-upload")
	public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile file){
		
		logger.info("file : " + file.getOriginalFilename());
		
		
		try {
			Map<String, Object> resultFileMap = crew_service.saveFile(file);
			return ResponseEntity.ok(resultFileMap);
			
		}catch(Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 실패");
		}
	}
	
	@PostMapping(value="/write")
	public Map<String, Object> submitPost(@RequestParam("crew_img") MultipartFile crew_img, 
			@ModelAttribute CrewDTO crewDto, @RequestParam("imgsJson") String imgsJson) { // boardDto랑 이름이 같으면 착각하고 에러나서 이름 다르게!
		
		Map<String, Object> resultMap = new HashMap<>();
		
		logger.info("ori_name =>" + crew_img.getOriginalFilename());
		
		// JSON -> List<FileDto> 변환
		ObjectMapper objectMapper = new ObjectMapper();
		List<ImageDTO> imgs = null;
		try {
			// TypeFactory를 사용하여 제네릭 타입을 처리
	        imgs = objectMapper.readValue(imgsJson, objectMapper.getTypeFactory().constructCollectionType(List.class, ImageDTO.class));
	        crewDto.setImgs(imgs);  // 변환한 리스트를 BoardDTO에 설정
		} catch (Exception e) {
			logger.error("파싱 오류 : {}", e.getMessage());
			return Map.of("error", e.getMessage());
		}
		
		if (imgs != null && !imgs.isEmpty()) {
		    for (ImageDTO img : imgs) {
		        logger.info("Original Filename: " + img.getImg_ori());
		        logger.info("New Filename: " + img.getImg_new());
		    }
		}
		
		logger.info("DTO : " + crewDto.toString());

		if(crew_service.sumbitPost(crewDto, crew_img)) {
			// 저장 완료 후 응답 반환
			// return ResponseEntity.ok("글 저장 성공");
			
			logger.info("글 업로드 완료");
			
			resultMap.put("success", true);
			resultMap.put("page", "crewUpdate");
			
		}

		return resultMap;
	}

	@DeleteMapping(value="/delete")
	public Map<String, Object> crewDelete(int crew_idx){
		
		logger.info("cres_idx => "+crew_idx);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		if(crew_service.crewDelete(crew_idx)) {
			resultMap.put("success", true);
		}else {
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@PutMapping(value="/update")
	public Map<String, Object> crewUpdate(@RequestParam("crew_img") MultipartFile crew_img, 
			@ModelAttribute CrewDTO crewDto, @RequestParam("imgsJson") String imgsJson){
		
		// 나중에 빼줘야 함
		int crew_idx = 39;
		crewDto.setCrew_idx(crew_idx);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		logger.info("ori_name =>" + crew_img.getOriginalFilename());
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<ImageDTO> imgs = null;
		try {
	        imgs = objectMapper.readValue(imgsJson, objectMapper.getTypeFactory().constructCollectionType(List.class, ImageDTO.class));
	        crewDto.setImgs(imgs);  
		} catch (Exception e) {
			logger.error("파싱 오류 : {}", e.getMessage());
			return Map.of("error", e.getMessage());
		}
		
		if (imgs != null && !imgs.isEmpty()) {
		    for (ImageDTO img : imgs) {
		        logger.info("Original Filename: " + img.getImg_ori());
		        logger.info("New Filename: " + img.getImg_new());
		    }
		}
		
		logger.info("수정하는 DTO : " + crewDto.toString());

		if(crew_service.crewUpdate(crewDto, crew_img)) {
			logger.info("글 업로드 완료");
			
			String page = "crewUpdateView";
			
			resultMap.put("success", true);
			resultMap.put("page", page);
			
		}

		return resultMap;
		
	}
	
	@PostMapping(value="/detail")
	public Map<String, Object> crewDetail(String crew_idx) {
		
		logger.info("idx => " + crew_idx);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int crew_idxs = Integer.parseInt(crew_idx); 
		
		CrewDTO crewDto = crew_service.crewDetail(crew_idxs);
		
		resultMap.put("result", crewDto);
		resultMap.put("success", true);
		
		
		return resultMap;
	}
	
	@PostMapping(value="/memberList")
	public Map<String, Object> crewMemberList(String crew_idx){
		logger.info("memver crew_idx =>" + crew_idx);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int crew_idxs = Integer.parseInt(crew_idx); 
		
		List<CrewMemberDTO> crewMemberList = crew_service.crewMemberList(crew_idxs);
		
		List<CrewMemberDTO> crewApplicationList = crew_service.crewApplicationList(crew_idxs);
		
		resultMap.put("result", crewMemberList);
		resultMap.put("application", crewApplicationList);
		resultMap.put("success", true);
		
		return resultMap;
		
	}
	
	@PostMapping(value="/applicationWrite")
	public Map<String, Object> crewApplicationWrite(String loginId, String crew_idx, String code_name){
		
		logger.info("loginId =>" + loginId);
		logger.info("crew_idx =>" + crew_idx);
		logger.info("code_name =>" + code_name);

		Map<String, Object> resultMap = new HashMap<>();
		int crew_idxs = Integer.parseInt(crew_idx);
		
		Map<String, Object> parmeterMap = new HashMap<>();
		parmeterMap.put("id", loginId);
		parmeterMap.put("crew_idx", crew_idxs);
		parmeterMap.put("code_name", code_name);

		boolean success = false;
		String msg = "";
		
		// 크루 신청
		if(code_name.equals("C100")) {
			success = crew_service.crewApplicationWrite(parmeterMap);
			msg = "크루 신청";
			logger.info("크루신청");
		// 크루 신청 취소
		}else if(code_name.equals("C104")) {
			success = crew_service.crewApplicationCancel(parmeterMap);
			msg = "신청 취소";
			logger.info("크루신청 취소");
		// 크루 탈퇴
		}else if(code_name.equals("C105")) {
			success = crew_service.crewMemberCencel(parmeterMap);
			msg = "크루 탈퇴";
			logger.info("크루탈퇴");
			
		// 크루 승인
		}else if(code_name.equals("C101")) {
			logger.info("크루승인");
		// 크루 미승인
		}else if(code_name.equals("C102")) {
			logger.info("크루 미승인");
		// 크루 퇴출
		}else{
			logger.info("크루퇴출");
		}
		
		resultMap.put("success", success);
		resultMap.put("msg", msg);
		
		return resultMap;
	}
	
	@PostMapping(value="/likeIs")
	public Map<String, Object> likeIs(String loginId, String crew_idx){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		logger.info("crew_idx =>"+crew_idx);
		logger.info("loginId =>"+loginId);
		
		if(loginId != null && loginId != "") {
			int crew_idxs = Integer.parseInt(crew_idx);
			
			Map<String, Object> parmeterMap = new HashMap<>();
			
			parmeterMap.put("id", loginId);
			parmeterMap.put("crew_idx", crew_idxs);
			
			int count = crew_service.likeIs(parmeterMap);
			
			if(count > 0) {
				resultMap.put("like", count);
				resultMap.put("success", true);
			}
			
			
			return resultMap;
		}else{
			resultMap.put("seccess", false);
		}
		
		
		return resultMap;
	}
	
	@PostMapping(value="/likeRequest")
	public Map<String, Object> likeRequest(String loginId, String crew_idx, String likeCrew){
		Map<String, Object> resultMap = new HashMap<>();
		
		logger.info("crew_idx =>"+crew_idx);
		logger.info("loginId =>"+loginId);
		logger.info("likeCrew =>"+likeCrew);

		String msg = "";
		boolean success = false;
		
		int crew_idxs = Integer.parseInt(crew_idx);
		
		Map<String, Object> parmeterMap = new HashMap<>();
		
		parmeterMap.put("id", loginId);
		parmeterMap.put("crew_idx", crew_idxs);
		
		if(likeCrew.equals("N")) {
			success = crew_service.likeRequest(parmeterMap);
			
		}else {
			success = crew_service.likeCencel(parmeterMap);
		}
		
		if(success) {
			msg = "좋아요 성공";
		}else {
			msg="좋아요 실패";
		}
		
		resultMap.put("success", success);
		resultMap.put("msg", msg);
		
		return resultMap;
	}
	
	@GetMapping(value="/list")
	public Map<String, Object> crewList(@RequestParam(value = "filtering", required = false) List<String> filtering,
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "pageSize", defaultValue = "10") int pageSize){
		
	    if (filtering == null) {
	        logger.info("필터 없음");
	    }else {
	    	logger.info("필터 => " +filtering);
	    	
	    }
	    
	    logger.info("page : pageSize" + page + ":" + pageSize);
	    
		Map<String, Object> resultMap = new HashMap<>();
		List<Map<String, Object>> crewList = crew_service.crewList(filtering, page, pageSize);
	    resultMap.put("result", crewList);
		
		return resultMap;
	}
	
	
}