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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.board.dao.RunBoardDAO;
import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.image.dto.ImageDTO;


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
            runBoardDAO.insertRunBoard(runBoard);

            // 경로 정보 저장 (경로가 있을 경우 반복문 사용)
            if (runBoard.getLatitudeList() != null && runBoard.getLongitudeList() != null) {
                for (int i = 0; i < runBoard.getLatitudeList().size(); i++) {
                	runBoardDAO.insertRouteData(runBoard.getBoard_idx(), runBoard.getLatitudeList().get(i), runBoard.getLongitudeList().get(i), runBoard.getPathList().get(i), i + 1);
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

	
}
