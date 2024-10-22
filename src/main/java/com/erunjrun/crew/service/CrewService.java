package com.erunjrun.crew.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.crew.dao.CrewDAO;
import com.erunjrun.crew.dto.CrewDTO;
import com.erunjrun.crew.dto.CrewMemberDTO;
import com.erunjrun.image.dto.ImageDTO;



@Service
public class CrewService {

    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired CrewDAO crew_dao;
	public Map<String, Object> saveFile(MultipartFile file) throws IllegalStateException, IOException {
		
		logger.info("file : " + file.getOriginalFilename());
		
		Map<String, Object> resultFileMap = new HashMap<>();
		
		// 파일 경로
		String uploadDir = "C:/uploadTemporary/";
		File dir = new File(uploadDir);
		
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		String img_ori = file.getOriginalFilename();
		String ext = img_ori.substring(img_ori.lastIndexOf("."));
		String img_new = UUID.randomUUID().toString() + ext;
		
		resultFileMap.put("img_ori", img_ori);
		resultFileMap.put("img_new", "/photo-temp/" + img_new);
		
		File targetFile = new File(uploadDir + img_new);
		file.transferTo(targetFile);
		
		logger.info(resultFileMap.toString());
		
		return resultFileMap;
	}

	public boolean sumbitPost(CrewDTO crewDto) {
		
		boolean success = false;
		
		int row = crew_dao.submitPost(crewDto);
		
		if(row>0) {
			int img_no = crewDto.getCrew_idx();
				
			List<ImageDTO> imgs = crewDto.getImgs();
			if(imgs.size() > 0) {
				for (ImageDTO img : imgs) {
//					String cleanedImg = img.replaceAll("[\\[\\]\"]", "");
//					String new_filename = img.getNew_filename();

					img.setImg_no(img_no);
					img.setCode_name("I101");
					fileWrite(img);
					
				}
			}
			
			success= true;
			
			CrewMemberDTO crewMemberDto = new CrewMemberDTO();
			crewMemberDto.setCrew_idx(img_no);
			crewMemberDto.setId(crewDto.getId());
			crewMemberDto.setIs_leader("Y");
			
			crew_dao.memberUpdate(crewMemberDto);
			
		}
		
		return success;
		
	}

	private void fileWrite(ImageDTO img) {
		
		logger.info("파일까지 가는 경로 가능하냐!!");
		
		// 복사할 파일
		File srcFile = new File("C:/uploadTemporary/"+img.getImg_new());
		// 목적지 (파일명을 그대로 복사하기 위해 파일명 붙여줌
		File descDir = new File("C:/upload/"+img.getImg_new());
		
		try {
			// Directory 는 폴더 복사 , File 은 파일 복사
			FileUtils.copyFile(srcFile, descDir);
			logger.info("복사 되었니?");
			
			
			crew_dao.fileWrite(img);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
    
}