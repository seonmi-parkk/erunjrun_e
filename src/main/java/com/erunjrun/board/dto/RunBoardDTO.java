package com.erunjrun.board.dto;

import java.math.BigDecimal;
import java.util.Date;

public class RunBoardDTO {
	
	private int board_idx;
	private String id;
	private String code_name;
	private String subject;
	private String content;
	private Date create_date;
	private Date update_date;
	private int bHit;
	private int likes;
	private String use_yn;
	private String is_map;
	private BigDecimal latitude;
	private BigDecimal longtude;
	private String path;
	private int order_num;
	private String nickname;
	
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
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
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getIs_map() {
		return is_map;
	}
	public void setIs_map(String is_map) {
		this.is_map = is_map;
	}
	public BigDecimal getLatitude() {
		return latitude;
	}
	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}
	public BigDecimal getLongtude() {
		return longtude;
	}
	public void setLongtude(BigDecimal longtude) {
		this.longtude = longtude;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	
	
	
}
