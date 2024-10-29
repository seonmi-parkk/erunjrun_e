package com.erunjrun.report.dto;

import java.util.Date;

public class ReportDTO {
	
	// 신고 테이블
	private int report_idx;
	private String id;
	private String code_name;
	private String content;
	private Date create_date;
	private String unlike_id;
	private String use_yn;
	private int img_idx;
	
	
	// 게시판 테이블
	private String board_idx;
	
	
	
	
	

	public String getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(String board_idx) {
		this.board_idx = board_idx;
	}
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getUnlike_id() {
		return unlike_id;
	}
	public void setUnlike_id(String unlike_id) {
		this.unlike_id = unlike_id;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public int getImg_idx() {
		return img_idx;
	}
	public void setImg_idx(int img_idx) {
		this.img_idx = img_idx;
	}
	
	


	
	
	
	

}
