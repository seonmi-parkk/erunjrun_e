package com.erunjrun.admin.dto;

import java.sql.Date;

public class RightDTO {
	
	private String id;
	private String nickname;
	private String admin_id;
	
	private Date start_date;
	private Date end_date;
	private String is_right;
	private String content;
	private String ban_content;
	private String code_name;
	private Date process_date;
	
	
	
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	public Date getProcess_date() {
		return process_date;
	}
	public void setProcess_date(Date process_date) {
		this.process_date = process_date;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getBan_content() {
		return ban_content;
	}
	public void setBan_content(String ban_content) {
		this.ban_content = ban_content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	
	
	public String getIs_right() {
		return is_right;
	}
	public void setIs_right(String is_right) {
		this.is_right = is_right;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
