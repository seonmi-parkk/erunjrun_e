package com.erunjrun.main.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class AlarmDTO {
	
	private int alarm_idx;
	private String id; // 알림 받는 사람 id
	private String from_id; // 알림 보내는 사람 id
	
	private String code_name;
	private String subject;
	private String content;
	private Date create_date;
	private String url;
	private String is_url; // Y / N
	private String confirm_use; // Y / N
	
	private int idx;
	
	
	private int alarmCount;
	
	public int getAlarm_idx() {
		return alarm_idx;
	}
	public void setAlarm_idx(int alarm_idx) {
		this.alarm_idx = alarm_idx;
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
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIs_url() {
		return is_url;
	}
	public void setIs_url(String is_url) {
		this.is_url = is_url;
	}
	public String getConfirm_use() {
		return confirm_use;
	}
	public void setConfirm_use(String confirm_use) {
		this.confirm_use = confirm_use;
	}
	
	
	
	public String getFrom_id() {
		return from_id;
	}
	public void setFrom_id(String from_id) {
		this.from_id = from_id;
	}
	
	
	
	
	public int getAlarmCount() {
		return alarmCount;
	}
	public void setAlarmCount(int alarmCount) {
		this.alarmCount = alarmCount;
	}
	
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	
	@Override
	public String toString() {
		return "AlarmDTO [alarm_idx=" + alarm_idx + ", id=" + id + ", from_id=" + from_id + ", code_name=" + code_name
				+ ", subject=" + subject + ", content=" + content + ", create_date=" + create_date + ", url=" + url
				+ ", is_url=" + is_url + ", confirm_use=" + confirm_use + ", idx=" + idx + ", alarmCount=" + alarmCount
				+ "]";
	}

	
	
	
	
	
	
	
	
	

}
