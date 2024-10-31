package com.erunjrun.admin.dto;

import java.sql.Date;

public class PopupDTO {

	private int popup_idx;
	private String admin_idx;
	private String subject;
	private String content;

	private Date create_date;
	private String use_yn;
	private String x;
	private String y;
	private String width;
	private String height;
	private Date start_date;
	private Date end_date;
	private String priority;
	private String code_name;
	
	
	
	
	
	
	public String getAdmin_idx() {
		return admin_idx;
	}
	public int getPopup_idx() {
		return popup_idx;
	}
	public void setPopup_idx(int popup_idx) {
		this.popup_idx = popup_idx;
	}
	public void setAdmin_idx(String admin_idx) {
		this.admin_idx = admin_idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
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
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	
	
	
}
