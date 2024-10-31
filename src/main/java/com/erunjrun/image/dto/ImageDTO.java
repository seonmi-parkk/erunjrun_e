package com.erunjrun.image.dto;

public class ImageDTO {
	
	private int img_idx;
	private String code_name; // 어떤 게시글의 이미지인지의 코드
	private String img_ori;
	private String img_new;
	private int img_no; // 생성한 글의 넘버
	
	
	public int getImg_idx() {
		return img_idx;
	}
	public void setImg_idx(int img_idx) {
		this.img_idx = img_idx;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getImg_ori() {
		return img_ori;
	}
	public void setImg_ori(String img_ori) {
		this.img_ori = img_ori;
	}
	public String getImg_new() {
		return img_new;
	}
	public void setImg_new(String img_new) {
		this.img_new = img_new;
	}
	public int getImg_no() {
		return img_no;
	}
	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}
	
	@Override
	public String toString() {
		return "ImageDTO [img_idx=" + img_idx + ", code_name=" + code_name + ", img_ori=" + img_ori + ", img_new="
				+ img_new + ", img_no=" + img_no + "]";
	}
	
	
}
