package com.erunjrun.crew.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.crew.dao.CrewDAO;
import com.erunjrun.crew.dto.CrewDTO;
import com.erunjrun.crew.dto.CrewMemberDTO;
import com.erunjrun.crew.dto.CrewNoticeDTO;
import com.erunjrun.image.dto.ImageDTO;



@Service
public class CrewService {

    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired CrewDAO crew_dao;
    
    // 파일 임시저장
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

	// 크루 등록
	@Transactional
	public boolean sumbitPost(CrewDTO crewDto, MultipartFile crew_img) {
		
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
					img.setCode_name("I100");
					fileWrite(img); // 크루 설명글
					
				}
			}
			
			success= true;
			
			// 크루장 crew_member 테이블에 insert
			CrewMemberDTO crewMemberDto = new CrewMemberDTO();
			crewMemberDto.setCrew_idx(img_no);
			crewMemberDto.setId(crewDto.getId());
			crewMemberDto.setIs_leader("Y");
			
			crew_dao.memberUpload(crewMemberDto);
			
			String[] tag_idx_list = crewDto.getTag_idx_list().split(",");
			for(String tag_idx : tag_idx_list) {
				crewDto.setTag_idx(Integer.parseInt(tag_idx));
				crew_dao.tagUpload(crewDto);
			}
			
			
			fileUpload(img_no, crew_img);
			
			int chatRow = crew_dao.crewChatInsert(img_no);
			
		}
		
		return success;
		
	}

	// 크루 대표 이미지 
	private void fileUpload(int img_no, MultipartFile crew_img) {
		
		String img_ori = crew_img.getOriginalFilename();
		String ext = img_ori.substring(img_ori.lastIndexOf("."));
		String img_new = UUID.randomUUID().toString() + ext;
		
		
		ImageDTO imageDto = new ImageDTO();
		
		imageDto.setCode_name("I101");
		imageDto.setImg_ori(img_ori);
		imageDto.setImg_new(img_new);
		imageDto.setImg_no(img_no);
		
		byte[] arr;
		try {
			arr = crew_img.getBytes();
			Path path = Paths.get("C:/upload/"+img_new);
			Files.write(path, arr);
			crew_dao.fileUpload(imageDto);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}

	// 게시글 업로드 (파일 복사)
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

	// 크루 삭제
	@Transactional
	public boolean crewDelete(int crew_idx) {
		
		int deleteRow = crew_dao.crewDelete(crew_idx);
		
		if(deleteRow > 0) {
			int memberDeleteRow = crew_dao.crewMemberDelete(crew_idx);
			int tagDeleteRow = crew_dao.crewTagDelete(crew_idx);
			
			// image code_name List 처리 가능한지 확인 필요 (프로젝트 내에서)
//			ImageDTO imageDto = new ImageDTO();
//			imageDto.setImg_no(tagDeleteRow);
			
			int img_no = crew_idx;
			int fileDeleteRow = crew_dao.crewImgDelete(img_no);
			
			if(memberDeleteRow > 0 && tagDeleteRow > 0 && fileDeleteRow > 0) {
				return true;
			}
		}
		
		return false;
	}

	
	// crewUpdate 페이지 데이터 전달 (select)
	public Map<String, Object> crewUpdateView(int crew_idx) {
		
		return crew_dao.crewUpdateView(crew_idx);
	}

	// 크루 수정 내용 update
	@Transactional
	public boolean crewUpdate(CrewDTO crewDto, MultipartFile crew_img) {
		
		logger.info("수정 서비스 => " + crewDto.toString());
		
		boolean success = false;
		
		int row = crew_dao.crewUpdate(crewDto); // 크루 정보 update
		
		if(row>0) {
			int img_no = crewDto.getCrew_idx();
			logger.info("idx 값은 ? => " + img_no);
			
			List<ImageDTO> imgs = crewDto.getImgs();
			logger.info("imgs =>", imgs); // x
			if(imgs.size() > 0) {
				crew_dao.crewImgDelete(img_no);
				for (ImageDTO img : imgs) {
					img.setImg_no(img_no);
					img.setCode_name("I100"); // 게시글 이미지
					fileWrite(img); // 파일 복사 (임시 -> 저장소)
				}
			}
			
			
			String[] tag_idx_list = crewDto.getTag_idx_list().split(",");
			
			for(String tag_idx : tag_idx_list) {
				crewDto.setTag_idx(Integer.parseInt(tag_idx));
				
				int tagDelete = crew_dao.crewTagDelete(crewDto.getCrew_idx());
				// 삭제 성공 시 insert
				if(tagDelete > 0) {
					int tagUploadRow = crew_dao.tagUpload(crewDto);
					logger.info("tag insert =>" + tagUploadRow);
				}
				
				
//				int tag_row = crew_dao.tagUpdate(crewDto); // 태그 정보 업데이트
//				logger.info("tag_row =>" + tag_row);
//				logger.info("tag_idx ==>" + tag_idx);
			}
			
			fileUpdate(img_no, crew_img);
			
			success = true;
		}

		return success;
	}

	// 크루 대표 이미지 insert = code_name = 'I101'
	private void fileUpdate(int img_no, MultipartFile crew_img) {
		
		String img_ori = crew_img.getOriginalFilename();
		String ext = img_ori.substring(img_ori.lastIndexOf("."));
		String img_new = UUID.randomUUID().toString() + ext;
		
		
		ImageDTO imageDto = new ImageDTO();
		
		imageDto.setCode_name("I101"); // 크루 대표 이미지
		imageDto.setImg_ori(img_ori);
		imageDto.setImg_new(img_new);
		imageDto.setImg_no(img_no);
		
		logger.info("img_no => " + imageDto.getImg_no());
		logger.info("ori =>" + imageDto.getImg_ori());
		logger.info("new =>" + imageDto.getImg_new());
		logger.info("code_name I101 =>" + imageDto.getCode_name());
		
		byte[] arr;
		try {
			arr = crew_img.getBytes();
			Path path = Paths.get("C:/upload/"+img_new);
			Files.write(path, arr);
			int file_row = crew_dao.fileUpload(imageDto);
			logger.info("file_row =>" + file_row);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public CrewDTO crewDetail(int crew_idx) {
		
		return crew_dao.crewDetail(crew_idx);
	}

	public List<CrewMemberDTO> crewMemberList(int crew_idxs) {
		
		List<CrewMemberDTO> crewMemberList = crew_dao.crewMemberList(crew_idxs);
		
		return crewMemberList;
	}
	
	// 크루 신청자 리스트
	public List<CrewMemberDTO> crewApplicationList(int crew_idxs, int page, int cnt, String keyword) {
		
		int limit = cnt; // 15
		int offset = (page -1) * cnt; // 0
		
		Map<String, Object> parmeterMap = new HashMap<>();
		parmeterMap.put("limit", limit);
		parmeterMap.put("offset", offset);
		parmeterMap.put("keyword", keyword);
		parmeterMap.put("crew_idx", crew_idxs);
		
		return crew_dao.crewApplicationList(parmeterMap);
	}

	// 크루 신청
	public boolean crewApplicationWrite(Map<String, Object> parmeterMap) {
		
		int row = crew_dao.crewApplicationWrite(parmeterMap);
		
		if(row > 0) {
			logger.info("크루 신청 =>" + row);
			crewHistoryWrite(parmeterMap);
			
			return true;
		}
		
		return false;
	}

	// 크루 신청 취소
	public boolean crewApplicationCancel(Map<String, Object> parmeterMap) {
		
		int row = crew_dao.crewApplicationCancel(parmeterMap);
		
		if(row > 0) {
			logger.info("크루 신청 취소 => " + row);
			crewHistoryWrite(parmeterMap);
			return true;
		}
		
		return false;
	}


	// 기존 크루 탈퇴
	public boolean crewMemberCencel(Map<String, Object> parmeterMap) {
		
		int row = crew_dao.crewMemberCencel(parmeterMap);
		
		if(row>0) {
			logger.info("크루 탈퇴 =>" + row);
			crewHistoryWrite(parmeterMap);
			return true;
		}
		
		return false;
	}

	
	// 크루 멤버 히스토리
	private void crewHistoryWrite(Map<String, Object> parmeterMap) {
		int row = crew_dao.crewHistoryWrite(parmeterMap);
		logger.info("크루 히스토리 => " + row);
		
		
	}

	public int likeIs(Map<String, Object> parmeterMap) {
		return crew_dao.likeIs(parmeterMap);
	}

	public boolean likeRequest(Map<String, Object> parmeterMap) {
		
		int row = crew_dao.likeRequest(parmeterMap);
		if(row>0) {
			return true;
		}
		
		return false;
	}

	public boolean likeCencel(Map<String, Object> parmeterMap) {
		
		int row = crew_dao.likeCencel(parmeterMap);
		if(row>0) {
			return true;
		}
		
		return false;
	}

	public List<Map<String, Object>> crewList(List<String> filtering, int page, int pageSize) {
		int offset = (page - 1) * pageSize; // 0 -> 10 -> 20 .. 10씩 증가
	    return crew_dao.crewList(filtering, offset, pageSize);
	}

	
	public List<CrewMemberDTO> applicationAdminList(int crew_idxs, int page, int cnt, String keyword) {
		int limit = cnt;
		int offset = (page -1) * cnt;
		
		Map<String, Object> parmeterMap = new HashMap<>();
		parmeterMap.put("limit", limit);
		parmeterMap.put("offset", offset);
		parmeterMap.put("keyword", keyword);
		parmeterMap.put("crew_idx", crew_idxs);
		
		return crew_dao.applicationAdminList(parmeterMap);
	}

	// 크루 승인
	public boolean crewMemberApproval(Map<String, Object> parmeterMap) {
		int row = crew_dao.crewMemberApproval(parmeterMap);
		int crew_idx = (int) parmeterMap.get("crew_idx");
		
		if(row>0) {
			logger.info("크루 승인 =>" + row);
			int deleteRow = crew_dao.crewApplicationCancel(parmeterMap);
			logger.info("크루 승인 후 신청 리스트에서 삭제 =>" + deleteRow);
			crewHistoryWrite(parmeterMap);
			crew_dao.crewCurrentMemberUpdate(crew_idx);
			return true;
		}
		
		return false;
	}

	public boolean crewMemberRefusal(Map<String, Object> parmeterMap) {
		int row = crew_dao.crewMemberRefusal(parmeterMap);
		
		if(row>0) {
			logger.info("크루 미승인 =>" + row);
			
			crewHistoryWrite(parmeterMap);
			return true;
		}
		
		return false;
	}

	public boolean crewAdminUpdate(String id, String leader, int crew_idxs) {
		
		Map<String, Object> parmeterMap = new HashMap<>();
		parmeterMap.put("id", id);
		parmeterMap.put("leader", leader);
		parmeterMap.put("crew_idx", crew_idxs);
		
		int row = crew_dao.crewAdminUpdate(parmeterMap);
		if(row > 0) {
			return true;
		}
		
		return false;
	}

	public boolean crewExpel(Map<String, Object> params) {

		int row = crew_dao.crewExpel(params);
		
		if(row>0) {
			logger.info("크루 퇴출 =>" + row);
			
			int historyrow = crew_dao.crewExpelHistoryWrite(params);
			logger.info("퇴출 히스토리 insert=> " + historyrow);
			return true;
		}
		
		return false;
	}

	public Map<String, Object> crewPriorityOverlay(CrewNoticeDTO crewNoticeDto) {
		
//		int crew_idxs = Integer.parseInt(crew_idx);
		
//		Map<String, Object> params = new HashMap<>();
//		params.put("priority", priority);
//		params.put("crew_idx", crew_idxs);
		
		return crew_dao.crewPriorityOverlay(crewNoticeDto);
	}

	public boolean crewNoticeWrite(CrewNoticeDTO crewNoticeDto) {
		
		int row = crew_dao.crewNoticeWrite(crewNoticeDto);
		
		if(row > 0) {
			int img_no = crewNoticeDto.getNotice_idx();
			
			List<ImageDTO> imgs = crewNoticeDto.getImgs();
			if(imgs.size() > 0) {
				for (ImageDTO img : imgs) {

					img.setImg_no(img_no);
					img.setCode_name("B104");
					fileWrite(img); // 크루 공지사항
					
				}
			}
			return true;
		}
		
		return false;
	}

	public boolean crewNoticePriorityUpdate(String crew_idx, String priority) {
		
		if(crew_dao.crewNoticePriorityUpdate(crew_idx, priority) > 0) {
			return true;
		}
		
		return false;
	}

	public List<CrewNoticeDTO> crewNoticeList(int crew_idxs, int page, int cnt, String option, String keyword) {
		
		int limit = cnt; // 15
		int offset = (page -1) * cnt; // 0
		
		Map<String, Object> parmeterMap = new HashMap<>();
		parmeterMap.put("limit", limit);
		parmeterMap.put("offset", offset);
		parmeterMap.put("option", option);
		parmeterMap.put("keyword", keyword);
		parmeterMap.put("crew_idx", crew_idxs);
		
		return crew_dao.crewNoticeList(parmeterMap);
	}

	public CrewNoticeDTO crewNoticeUpdateView(int notice_idx) {
		return crew_dao.crewNoticeUpdateView(notice_idx);
	}

	public boolean crewNoticeUpdate(CrewNoticeDTO crewNoticeDto) {
		
		
//		logger.info(crewNoticeDto.getNotice_idx());
		
		int row = crew_dao.crewNoticeUpdate(crewNoticeDto);
		
		if(row > 0) {
			int img_no = crewNoticeDto.getNotice_idx();
			
			List<ImageDTO> imgs = crewNoticeDto.getImgs();
			if(imgs.size() > 0) {
				for (ImageDTO img : imgs) {

					img.setImg_no(img_no);
					img.setCode_name("B104");
					fileWrite(img); // 크루 공지사항
					
				}
			}
			return true;
		}
		
		return false;
	}

	@Transactional
	public CrewNoticeDTO crewNoticeDetail(int notice_idx) {
		
		int row = crew_dao.crewNoticeHit(notice_idx);
		
		CrewNoticeDTO noticeDto = null;
		
		if(row>0) {
			noticeDto = crew_dao.crewNoticeDetail(notice_idx);
		}
		return noticeDto;
	}

	public boolean crewNoticeDelete(int notice_idx) {
		if(crew_dao.crewNoticeDelete(notice_idx) > 0) {
			return true;
		}
		return false;
	}

	
}