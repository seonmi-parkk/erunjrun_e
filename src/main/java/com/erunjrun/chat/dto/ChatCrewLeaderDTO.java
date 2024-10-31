package com.erunjrun.chat.dto;

import java.time.LocalDateTime;

public class ChatCrewLeaderDTO {
	private String firstOfDay;

	private String nickname;
	
	//crew_chat 테이블
	private String chat_idx;
	private String crew_idx;
	private String code_cp;
	
	//crew_chat_link 테이블
	private String id;
	private String use_yn;
	private String is_reader;
	
	//crew_chat_content 테이블
	private String content_idx;
	private LocalDateTime create_date;
	private LocalDateTime end_date;
	private String sender;
	private String content;

	public String getFirstOfDay() {
		return firstOfDay;
	}
	public void setFirstOfDay(String firstOfDay) {
		this.firstOfDay = firstOfDay;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getChat_idx() {
		return chat_idx;
	}
	public void setChat_idx(String chat_idx) {
		this.chat_idx = chat_idx;
	}
	public String getCrew_idx() {
		return crew_idx;
	}
	public void setCrew_idx(String crew_idx) {
		this.crew_idx = crew_idx;
	}
	public LocalDateTime getCreate_date() {
		return create_date;
	}
	public void setCreate_date(LocalDateTime create_date) {
		this.create_date = create_date;
	}
	public String getCode_cp() {
		return code_cp;
	}
	public void setCode_cp(String code_cp) {
		this.code_cp = code_cp;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getIs_reader() {
		return is_reader;
	}
	public void setIs_reader(String is_reader) {
		this.is_reader = is_reader;
	}
	public String getContent_idx() {
		return content_idx;
	}
	public void setContent_idx(String content_idx) {
		this.content_idx = content_idx;
	}
	public LocalDateTime getEnd_date() {
		return end_date;
	}
	public void setEnd_date(LocalDateTime end_date) {
		this.end_date = end_date;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
