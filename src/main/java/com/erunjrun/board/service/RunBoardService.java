package com.erunjrun.board.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.board.dao.RunBoardDAO;
import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.member.dto.MemberDTO;


@Service
public class RunBoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired RunBoardDAO runBoardDAO;
	
	public int count(int cnt_) {
		
		return runBoardDAO.count(cnt_);
	}


	public List<RunBoardDTO> bHitList() {
		
		return runBoardDAO.bHitList();
	}

	public List<RunBoardDTO> list(int limit, int offset, String code_name, String use_yn, String is_map) {
		
		return runBoardDAO.list(limit, offset,code_name,use_yn,is_map);
	}

	public List<RunBoardDTO> searchList(String opt, String keyword, int limit, int offset) {

		return runBoardDAO.search(opt, keyword, limit, offset);
	}

	public int getSearchTotalPages(String opt, String keyword) {

		return runBoardDAO.getSearchTotalPages(opt, keyword);
	}

	 // 파일 임시 저장
    public Map<String, Object> saveFile(MultipartFile file) throws IllegalStateException, IOException {
        logger.info("file : " + file.getOriginalFilename());

        Map<String, Object> resultFileMap = new HashMap<>();

        // 파일 경로
        String uploadDir = "C:/uploadTemporary/";
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

    // 게시글 등록 로직 구현
    @Transactional
    public boolean submitPost(RunBoardDTO runBoard) {
    	 	
    	
        try {
            boolean success = false;
            
            // 게시글 정보 저장
            runBoard.setCode_name("B100");
            logger.info("insertRunBoard 호출 전 - 제목: {}", runBoard.getSubject());
            runBoardDAO.insertRunBoard(runBoard);
            logger.info("제목1 : "+runBoard.getSubject()); 
            // 경로 정보 저장 (경로가 있을 경우 반복문 사용)
            
            
            if (runBoard.getLatitudeList() != null && runBoard.getLongitudeList() != null) {
                for (int i = 0; i < runBoard.getLatitudeList().size(); i++) {
                	
//                    logger.info("게시글 ID: " + runBoard.getBoard_idx());
//                    logger.info("위도: " + runBoard.getLatitudeList().get(i));
//                    logger.info("경도: " + runBoard.getLongitudeList().get(i));
//                    logger.info("경로 구분: " + runBoard.getPathList().get(i));
//                    logger.info("경로 순서: " + (i + 1));
                    
                	runBoardDAO.insertRouteData(
                			runBoard.getBoard_idx(), 
                			runBoard.getLatitudeList().get(i),
                			runBoard.getLongitudeList().get(i),
                			runBoard.getPathList().get(i), i + 1);
                }
            }


            // 이미지 정보 저장 (이미지가 있을 경우 반복문 사용)
            List<ImageDTO> imgs = runBoard.getImageList();
            if (imgs != null && !imgs.isEmpty()) {
                for (ImageDTO img : imgs) {
                    img.setImg_no(runBoard.getBoard_idx());
                    img.setCode_name("B100");
                    fileWrite(img); // 게시글 이미지 파일 복사 저장
                }
            }
            
            Map<String, Object> boardPoint = new HashMap<String, Object>();
            boardPoint.put("code_name", "P101");
            boardPoint.put("id", runBoard.getId());
            boardPoint.put("point", 5);
            
            runBoardDAO.boardPoint(boardPoint);
       
            success = true;
            
            return success;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 게시글 이미지 파일 복사 저장
    private void fileWrite(ImageDTO img) {
        logger.info("파일까지 가는 경로 가능하냐!!");

        // 복사할 파일
        File srcFile = new File("C:/uploadTemporary/" + img.getImg_new());
        // 목적지 파일
        File descDir = new File("C:/upload/" + img.getImg_new());

        try {
            // 파일 복사
            Files.copy(srcFile.toPath(), descDir.toPath());
            logger.info("복사 되었니?");
            runBoardDAO.fileWrite(img);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


	public void point() {
        // 이번 주 최다 추천 게시글 목록을 가져옴
        List<RunBoardDTO> likes = runBoardDAO.bHitList();
        logger.info("목록"+likes);
        for (RunBoardDTO post : likes) {

        	RunBoardDTO point = new RunBoardDTO();
            point.setCode_name("P101"); // 포인트 코드명
            point.setId(post.getId()); // 포인트 받을 회원
            point.setPoint(100); // 지급할 포인트 
            
            logger.info("코드 네임: " + point.getCode_name());
            logger.info("회원 ID: " + point.getId());
            
            
            // 포인트 테이블에 삽입
            runBoardDAO.point(point);
        }
    }

	@Transactional
	public RunBoardDTO detail(int board_idx) {
		
		runBoardDAO.bHit(board_idx);
		
		return runBoardDAO.detail(board_idx);
		
	}


	public List<RunBoardDTO> mapData(int board_idx) {
		
		return runBoardDAO.mapData(board_idx);
	}


	public boolean like(int board_idx, String loginId) {
		boolean isLiked = false;
		int result = runBoardDAO.like(board_idx,loginId);
		if(result>0) {
			logger.info("조아용 카운트 : "+result);
			isLiked = true;
		}
		return isLiked;
	}


	public boolean disLike(int board_idx, String loginId) {
		boolean success = false;
		int result = runBoardDAO.disLike(board_idx,loginId);
		if(result>0) {
			logger.info("안조아용 : "+result);
			runBoardDAO.updateDelLike(board_idx);
			success = true;
		}
		return success;
	}


	public boolean addLike(int board_idx, String loginId) {
		boolean success = false;
		int result = runBoardDAO.addLike(board_idx,loginId);
		if(result>0) {
			logger.info("조아용 : "+result);
			runBoardDAO.updateLike(board_idx);
			success = true;
		}
		return success;
	}


	public boolean runUpdate(RunBoardDTO runBoardDto) {
		
		logger.info("수정 서비스 => " + runBoardDto.toString());
		
		 try {
	            boolean success = false;

	            // 게시글 정보 저장
	            runBoardDto.setCode_name("B100");
	            logger.info("runUpdate 호출 전 - 제목: {}", runBoardDto.getSubject());
	            runBoardDAO.runUpdate(runBoardDto);
	            logger.info("제목1 : "+runBoardDto.getSubject()); 
	            // 경로 정보 저장 (경로가 있을 경우 반복문 사용)
	            
	            runBoardDAO.deleteRouteData(runBoardDto.getBoard_idx());
	            if (runBoardDto.getLatitudeList() != null && runBoardDto.getLongitudeList() != null) {
	                for (int i = 0; i < runBoardDto.getLatitudeList().size(); i++) {
	                	
//	                    logger.info("게시글 ID: " + runBoard.getBoard_idx());
//	                    logger.info("위도: " + runBoard.getLatitudeList().get(i));
//	                    logger.info("경도: " + runBoard.getLongitudeList().get(i));
//	                    logger.info("경로 구분: " + runBoard.getPathList().get(i));
//	                    logger.info("경로 순서: " + (i + 1));
	                    
	                	runBoardDAO.insertRouteData(
	                			runBoardDto.getBoard_idx(), 
	                			runBoardDto.getLatitudeList().get(i),
	                			runBoardDto.getLongitudeList().get(i),
	                			runBoardDto.getPathList().get(i), i + 1);
	                }
	            }

	            // 이미지 정보 저장 (이미지가 있을 경우 반복문 사용)
	            runBoardDAO.deleteImg(runBoardDto.getBoard_idx());
	            List<ImageDTO> imgs = runBoardDto.getImageList();
	            if (imgs != null && !imgs.isEmpty()) {
	                for (ImageDTO img : imgs) {
	                    img.setImg_no(runBoardDto.getBoard_idx());
	                    img.setCode_name("B100");
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


	public boolean runBoardDelete(int board_idx) {
		
		int row = runBoardDAO.runBoardDelete(board_idx);
		logger.info("비활 : "+row);
		
		return row > 0;
	}


	public MemberDTO nickName(String loginId) {
		
		return runBoardDAO.nickName(loginId);
	}


	public int coun(int board_idx) {
		
		return runBoardDAO.coun(board_idx);
	}





	
	
	
	
		
}

	

