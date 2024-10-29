package com.erunjrun.chat.dto;

import java.sql.Date;

public class ChatPersonalDTO {
	private String content_idx;
	private String chat_idx;
	private String content;
	private Date start_date;
	private Date end_date;
	private String sender;
	private String recipient;
	private String use_yn;
	
	private String image;
	private String icon_image;
	private String nickname;
	
	
	public String getContent_idx() {
		return content_idx;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getIcon_image() {
		return icon_image;
	}
	public void setIcon_image(String icon_image) {
		this.icon_image = icon_image;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public void setContent_idx(String content_idx) {
		this.content_idx = content_idx;
	}
	public String getChat_idx() {
		return chat_idx;
	}
	public void setChat_idx(String chat_idx) {
		this.chat_idx = chat_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	
	
}
