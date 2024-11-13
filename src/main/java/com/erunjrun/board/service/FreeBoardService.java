package com.erunjrun.board.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.admin.dto.RightDTO;
import com.erunjrun.board.dao.FreeBoardDAO;
import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.member.dto.MemberDTO;


@Service
public class FreeBoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired FreeBoardDAO freeBoardDAO;
	
	
	public int count(int cnt_) {
		
		return freeBoardDAO.freeCount(cnt_);
	}

	public List<RunBoardDTO> list(int limit, int offset, String code_name, String use_yn, String sortColumn, String sortOrder) {
		
		return freeBoardDAO.freeList(limit, offset,code_name,use_yn,sortColumn,sortOrder);
	}

	public List<RunBoardDTO> searchList(String opt, String keyword, int limit, int offset) {

		return freeBoardDAO.freeSearch(opt, keyword, limit, offset);
	}

	public int getSearchTotalPages(String opt, String keyword) {

		return freeBoardDAO.freeGetSearchTotalPages(opt, keyword);
	}

	// 파일 임시 저장
	public Map<String, Object> saveFile(MultipartFile file) throws IllegalStateException, IOException {
			 logger.info("file : " + file.getOriginalFilename());

		        Map<String, Object> resultFileMap = new HashMap<>();

		        // 파일 경로
		        String uploadDir = "/usr/local/tomcat/webapps/uploadTemporary/";
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
		
		// 게시글 등록
		public int submitPost(RunBoardDTO runBoard, HttpSession session) {
			
			int row = freeBoardDAO.insertFreeBoard(runBoard);
			
			String userId = (String) session.getAttribute("loginId");
			
			 try {
		            	            
		            // 게시글 정보 저장
				 	runBoard.setCode_name("B101");
		            logger.info("insertRunBoard 호출 전 - 제목: {}", runBoard.getSubject());
		            
		            logger.info("제목1 : "+runBoard.getSubject()); 
		           
		            
		            // 이미지 정보 저장 (이미지가 있을 경우 반복문 사용)
		            List<ImageDTO> imgs = runBoard.getImageList();
		            if (imgs != null && !imgs.isEmpty()) {
		                for (ImageDTO img : imgs) {
		                    img.setImg_no(runBoard.getBoard_idx());
		                    img.setCode_name("B101");
		                    fileWrite(img); // 게시글 이미지 파일 복사 저장
		                }
		            }
		            
		            Map<String, Object> boardPoint = new HashMap<String, Object>();
		            boardPoint.put("code_name", "P101");
		            boardPoint.put("id", runBoard.getId());
		            boardPoint.put("point", 5);
		            
		            freeBoardDAO.boardPoint(boardPoint);
		            
		            freeBoardDAO.updatePoint(userId);
		            
		            	              
		        } catch (Exception e) {
		            e.printStackTrace();	      
		        }
			 return row;
		  }
		
		 // 게시글 이미지 파일 복사 저장
	    private void fileWrite(ImageDTO img) {
	        logger.info("파일까지 가는 경로 가능하냐!!");

	        // 복사할 파일
	        File srcFile = new File("/usr/local/tomcat/webapps/uploadTemporary/" + img.getImg_new());
	        // 목적지 파일
	        File descDir = new File("/usr/local/tomcat/webapps/upload" + img.getImg_new());

	        try {
	            // 파일 복사
	            Files.copy(srcFile.toPath(), descDir.toPath());
	            logger.info("복사 되었니?");
	            freeBoardDAO.fileWrite(img);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    @Transactional
		public RunBoardDTO detail(int board_idx) {
			
	    	freeBoardDAO.bHit(board_idx);
			
			return freeBoardDAO.detail(board_idx);
			
		}

		public boolean like(int board_idx, String loginId) {
			boolean isLiked = false;
			int result = freeBoardDAO.like(board_idx,loginId);
			if(result>0) {
				logger.info("조아용 카운트 : "+result);
				isLiked = true;
			}
			return isLiked;
		}
		
		public MemberDTO nickName(String loginId) {
			
			return freeBoardDAO.nickName(loginId);
		}


		public int coun(int board_idx) {
			
			return freeBoardDAO.coun(board_idx);
		}
		
		public boolean disLike(int board_idx, String loginId) {
			boolean success = false;
			int result = freeBoardDAO.disLike(board_idx,loginId);
			if(result>0) {
				logger.info("안조아용 : "+result);
				freeBoardDAO.updateDelLike(board_idx);
				success = true;
			}
			return success;
		}


		public boolean addLike(int board_idx, String loginId) {
			boolean success = false;
			int result = freeBoardDAO.addLike(board_idx,loginId);
			if(result>0) {
				logger.info("조아용 : "+result);
				freeBoardDAO.updateLike(board_idx);
				success = true;
			}
			return success;
		}
		
		public boolean freeUpdate(RunBoardDTO runBoardDto) {
			
			logger.info("수정 서비스 => " + runBoardDto.toString());
			
			 try {
		            boolean success = false;

		            // 게시글 정보 저장
		            runBoardDto.setCode_name("B101");
		            logger.info("runUpdate 호출 전 - 제목: {}", runBoardDto.getSubject());
		            freeBoardDAO.freeUpdate(runBoardDto);
		            logger.info("제목1 : "+runBoardDto.getSubject()); 
		            	            
		            // 이미지 정보 저장 (이미지가 있을 경우 반복문 사용)
		            freeBoardDAO.deleteImg(runBoardDto.getBoard_idx());
		            List<ImageDTO> imgs = runBoardDto.getImageList();
		            if (imgs != null && !imgs.isEmpty()) {
		                for (ImageDTO img : imgs) {
		                    img.setImg_no(runBoardDto.getBoard_idx());
		                    img.setCode_name("B101");
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

		public boolean freeBoardDelete(int board_idx) {
			
			int row = freeBoardDAO.freeBoardDelete(board_idx);
			logger.info("비활 : "+row);
			
			return row > 0;
		}
		
		public RightDTO right(String userId) {
			
			return freeBoardDAO.right(userId);
		}


		public RightDTO ban(String loginId) {
			
			return freeBoardDAO.ban(loginId);
		}	

	
	





	
	
	
	
		
}

	

