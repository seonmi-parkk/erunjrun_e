package com.erunjrun.mypage.dto;

import java.math.BigDecimal;

public class MypageDTO {

	private String id; 
	private String content; 
	private int exercise_min; 
	private int exercise_dis; 
	private String exercise; 
	private String mate; 
	private BigDecimal latitude;
	private BigDecimal longitude;
	private String sido;
	private String dong;
	private String detail_address;
	private String shortsido;
	private String profile_use;
	private String exercise_use;
	
	public String getProfile_use() {
		return profile_use;
	}
	public void setProfile_use(String profile_use) {
		this.profile_use = profile_use;
	}
	public String getExercise_use() {
		return exercise_use;
	}
	public void setExercise_use(String exercise_use) {
		this.exercise_use = exercise_use;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getExercise_min() {
		return exercise_min;
	}
	public void setExercise_min(int exercise_min) {
		this.exercise_min = exercise_min;
	}
	public int getExercise_dis() {
		return exercise_dis;
	}
	public void setExercise_dis(int exercise_dis) {
		this.exercise_dis = exercise_dis;
	}
	public String getExercise() {
		return exercise;
	}
	public void setExercise(String exercise) {
		this.exercise = exercise;
	}
	public String getMate() {
		return mate;
	}
	public void setMate(String mate) {
		this.mate = mate;
	}
	public BigDecimal getLatitude() {
		return latitude;
	}
	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}
	public BigDecimal getLongitude() {
		return longitude;
	}
	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	public String getShortsido() {
		return shortsido;
	}
	public void setShortsido(String shortsido) {
		this.shortsido = shortsido;
	}
	
}
