package com.erunjrun.crew.dto;

import java.sql.Date;

public class CrewNoticeDTO {
    
    // ctew_notice
    private int notice_idx; // crew_notice_comment
    private int crew_idx;
    private String subject;
    private String content; // crew_notice_comment
    private Date create_date; // crew_notice_comment
    private Date udate_date; // crew_notice_comment
    private int hit;
    private String nickname; // crew_notice_comment
    private int priority;
    
    // crew_notice_comment
    private int comment_idx;
    private String use_yn;
	public int getNotice_idx() {
		return notice_idx;
	}
	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
	}
	public int getCrew_idx() {
		return crew_idx;
	}
	public void setCrew_idx(int crew_idx) {
		this.crew_idx = crew_idx;
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
	public Date getUdate_date() {
		return udate_date;
	}
	public void setUdate_date(Date udate_date) {
		this.udate_date = udate_date;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public int getComment_idx() {
		return comment_idx;
	}
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	
	@Override
	public String toString() {
		return "CrewNoticeDTO [notice_idx=" + notice_idx + ", crew_idx=" + crew_idx + ", subject=" + subject
				+ ", content=" + content + ", create_date=" + create_date + ", udate_date=" + udate_date + ", hit="
				+ hit + ", nickname=" + nickname + ", priority=" + priority + ", comment_idx=" + comment_idx
				+ ", use_yn=" + use_yn + "]";
	}
    
    

}
