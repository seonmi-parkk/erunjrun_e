package com.erunjrun.board.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.board.dao.AskBoardDAO;
import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.image.dto.ImageDTO;

@Service
public class AskBoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AskBoardDAO askDAO;
	
    @Value("${upload.path}") String paths;
    @Value("${uploadTem.path}") String tem_path;
	
	public int askCount(int cnt_) {
		
		return askDAO.askCount(cnt_);
	}
	
	public List<RunBoardDTO> askList(int limit, int offset, String code_name) {
		
		return askDAO.askList(limit,offset,code_name);
	}
	
	public RunBoardDTO detail(int ask_idx) {
		
		return askDAO.detail(ask_idx);
	}
	
	// 게시글 등록
		public int submitPost(RunBoardDTO runBoard) {
			
			int row = askDAO.insertAskBoard(runBoard);
			
			 try {
		            	            
		            // 게시글 정보 저장
		            runBoard.getCode_name();
		            logger.info("insertRunBoard 호출 전 - 제목: {}", runBoard.getSubject());
		            
		            logger.info("제목1 : "+runBoard.getSubject()); 
		           
		            
		            // 이미지 정보 저장 (이미지가 있을 경우 반복문 사용)
		            List<ImageDTO> imgs = runBoard.getImageList();
		            if (imgs != null && !imgs.isEmpty()) {
		                for (ImageDTO img : imgs) {
		                    img.setImg_no(runBoard.getAsk_idx());
		                    img.setCode_name(runBoard.getCode_name());
		                    fileWrite(img); // 게시글 이미지 파일 복사 저장
		                }
		            }
		            	       
		            
		            
		            
		        } catch (Exception e) {
		            e.printStackTrace();	      
		        }
			 return row;
		  }
	
	
	 // 파일 임시 저장
    public Map<String, Object> saveFile(MultipartFile file) throws IllegalStateException, IOException {
        logger.info("file : " + file.getOriginalFilename());

        Map<String, Object> resultFileMap = new HashMap<>();

        // 파일 경로
        String uploadDir = paths;
        File dir = new File(uploadDir);

        if (!dir.exists()) {
            dir.mkdirs();
        }

        String imgOri = file.getOriginalFilename();
        String ext = imgOri.substring(imgOri.lastIndexOf("."));
        String imgNew = UUID.randomUUID().toString() + ext;

        resultFileMap.put("img_ori", imgOri);
        resultFileMap.put("img_new", "/photo-temp/" + imgNew);

        File targetFile = new File(uploadDir + imgNew);
        file.transferTo(targetFile);

        logger.info(resultFileMap.toString());

        return resultFileMap;
    }
    
    public boolean askUpdate(RunBoardDTO runBoardDto, String code_name) {
		
		logger.info("수정 서비스 => " + runBoardDto.toString());
		logger.info("코드네임 : "+code_name);
		
		 try {
	            boolean success = false;

	            // 게시글 정보 저장
	            runBoardDto.setCode_name(code_name);
	            logger.info("runUpdate 호출 전 - 제목: {}", runBoardDto.getSubject());
	            askDAO.askUpdate(runBoardDto);
	            logger.info("제목1 : "+runBoardDto.getSubject()); 
	            // 경로 정보 저장 (경로가 있을 경우 반복문 사용)
	            
	            
	            // 이미지 정보 저장 (이미지가 있을 경우 반복문 사용)
	            askDAO.deleteImg(runBoardDto.getAsk_idx());
	            List<ImageDTO> imgs = runBoardDto.getImageList();
	            if (imgs != null && !imgs.isEmpty()) {
	                for (ImageDTO img : imgs) {
	                    img.setImg_no(runBoardDto.getAsk_idx());
	                    img.setCode_name(code_name);
	                    fileWrite(img); // 게시글 이미지 파일 복사 저장
	                }
	            }
	       
	            success = true;
	            
	            return success;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	//게시글 이미지 파일 복사 저장
	private void fileWrite(ImageDTO img) {
	    logger.info("파일까지 가는 경로 가능하냐!!");
	
	    // 복사할 파일
	    File srcFile = new File(tem_path + img.getImg_new());
	    // 목적지 파일
	    File descDir = new File(paths + img.getImg_new());
	
	    try {
	        // 파일 복사
	        Files.copy(srcFile.toPath(), descDir.toPath());
	        logger.info("복사 되었니?");
	        askDAO.fileWrite(img);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}

	public boolean askBoardDelete(int ask_idx) {
		
		return askDAO.askBoardDelete(ask_idx) > 0;
	}
	
	

	
	
	
}
