package com.erunjrun.mate.dto;

public class MateDTO {
	//mate_history 테이블
	private int mate_history_idx;
	private String id;
	private String code_name;
	private String unlike_id;
	private String create_date;
	
	public int getMate_history_idx() {
		return mate_history_idx;
	}
	public void setMate_history_idx(int mate_history_idx) {
		this.mate_history_idx = mate_history_idx;
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
	public String getUnlike_id() {
		return unlike_id;
	}
	public void setUnlike_id(String unlike_id) {
		this.unlike_id = unlike_id;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	
	
	
}
