package com.erunjrun.report.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.report.dto.ReportDTO;
import com.erunjrun.report.service.ReportService;

@Controller
public class ReportController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReportService reportService;
	
	@GetMapping(value="/reportForm")
	public String report() {
		return "report/reportForm";
	}
	
	@PostMapping(value="/reportForm")
	@ResponseBody
	public Map<String,Object> report(@ModelAttribute ReportDTO reportDto){
		
		Map<String,Object> result = new HashMap<String, Object>();
		int row = reportService.report(reportDto);
		result.put("result", row);
		
		
		return result;
	}
	
	

}
