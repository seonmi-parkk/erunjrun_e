package com.erunjrun.report.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.comment.dto.CommentDTO;
import com.erunjrun.crew.dto.CrewNoticeDTO;
import com.erunjrun.image.dto.ImageDTO;
import com.erunjrun.report.dao.ReportDAO;
import com.erunjrun.report.dto.ReportDTO;

@Service
public class ReportService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReportDAO reportDAO;
	public boolean report(ReportDTO reportDto, MultipartFile report_img) {
		
		 boolean report = reportDAO.report(reportDto) > 0; // 신고 테이블에 저장
		 
		 
	        if (report && report_img != null && !report_img.isEmpty()) {
	            String originalFilename = report_img.getOriginalFilename();
	            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
	            String newFileName = UUID.randomUUID().toString() + ext;

	            try {
	                // 파일 저장
	                Path path = Paths.get("C:/upload/" + newFileName);
	                Files.write(path, report_img.getBytes());

	                // 이미지 정보 DTO 생성 및 설정
	                ImageDTO imageDTO = new ImageDTO();
	                imageDTO.setImg_ori(originalFilename);
	                imageDTO.setImg_new(newFileName);
	                imageDTO.setCode_name("R100"); // 이미지 코드 설정
	                imageDTO.setImg_no(reportDto.getReport_idx()); // 신고 ID를 이미지 번호로 설정

	                reportDAO.fileWrite(imageDTO); // 이미지 테이블에 저장

	                return true;
	            } catch (IOException e) {
	                e.printStackTrace();
	                return false;
	            }
	        }
	        return report;
		
	}
	
	public RunBoardDTO reput(int board_idx) {
		
		return reportDAO.reput(board_idx);
	}

	public CommentDTO comment(int comment_idx) {
		
		logger.info("서비스에서 : "+comment_idx);
		CommentDTO row = reportDAO.comment(comment_idx);
		logger.info("서비스 : "+row);
		
		return row;
	}

	public boolean reportComment(ReportDTO reportDto, MultipartFile report_img) {
		
		boolean report = reportDAO.reportComment(reportDto) > 0; // 신고 테이블에 저장
		
		if (report && report_img != null && !report_img.isEmpty()) {
            String originalFilename = report_img.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString() + ext;

            try {
                // 파일 저장
                Path path = Paths.get("C:/upload/" + newFileName);
                Files.write(path, report_img.getBytes());

                // 이미지 정보 DTO 생성 및 설정
                ImageDTO imageDTO = new ImageDTO();
                imageDTO.setImg_ori(originalFilename);
                imageDTO.setImg_new(newFileName);
                imageDTO.setCode_name("R101"); // 이미지 코드 설정
                imageDTO.setImg_no(reportDto.getReport_idx()); // 신고 ID를 이미지 번호로 설정

                reportDAO.fileWrite(imageDTO); // 이미지 테이블에 저장

                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return report;
		
	}

	
	public boolean reportNoticeComment(ReportDTO reportDto, MultipartFile report_img) {
		
		boolean report = reportDAO.reportNoticeComment(reportDto) > 0; // 신고 테이블에 저장
		
		if (report && report_img != null && !report_img.isEmpty()) {
            String originalFilename = report_img.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString() + ext;

            try {
                // 파일 저장
                Path path = Paths.get("C:/upload/" + newFileName);
                Files.write(path, report_img.getBytes());

                // 이미지 정보 DTO 생성 및 설정
                ImageDTO imageDTO = new ImageDTO();
                imageDTO.setImg_ori(originalFilename);
                imageDTO.setImg_new(newFileName);
                imageDTO.setCode_name("R101"); // 이미지 코드 설정
                imageDTO.setImg_no(reportDto.getReport_idx()); // 신고 ID를 이미지 번호로 설정

                reportDAO.fileWrite(imageDTO); // 이미지 테이블에 저장

                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return report;
		
	}



	
	
		
	
				
	
}
