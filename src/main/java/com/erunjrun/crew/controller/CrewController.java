package com.erunjrun.crew.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.crew.dto.CrewDTO;
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
	public Map<String, Object> submitPost(@ModelAttribute CrewDTO crewDto, @RequestParam("imgsJson") String imgsJson) { // boardDto랑 이름이 같으면 착각하고 에러나서 이름 다르게!
		
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

		if(crew_service.sumbitPost(crewDto)) {
			// 저장 완료 후 응답 반환
			// return ResponseEntity.ok("글 저장 성공");
			
			logger.info("글 업로드 완료");
			
		}

		return null;
	}

}