package com.erunjrun.report.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.board.dto.RunBoardDTO;
import com.erunjrun.report.dto.ReportDTO;
import com.erunjrun.report.service.ReportService;

@Controller
public class ReportController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReportService reportService;
	
	@GetMapping(value="/reportForm/{board_idx}")
	public String report(@PathVariable int board_idx,Model model) {
		
		RunBoardDTO repoter = reportService.reput(board_idx);
		
		model.addAttribute("report", repoter);
		
		return "report/reportForm";
	}
	
	@PostMapping(value="/reportForm")
	@ResponseBody
	public Map<String,Object> report(@RequestParam("report_img")MultipartFile report_img,@ModelAttribute ReportDTO reportDto){
				
		
		Map<String,Object> result = new HashMap<String, Object>();
				
		if(reportService.report(reportDto,report_img)) {
			logger.info("글 업로드 완료");
			result.put("result", true);
		}
		
		
		return result;
	}
	
	
	
		

}
