package com.erunjrun.crew.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.image.dto.ImageDTO;


public class CrewDTO {
    
    // crew 테이블
    private Integer crew_idx=0; // crew_tag, crew_chat
    private String crew_name;
    private Integer member = 0;
    private Integer current_member = 0;
    private Date create_date; // tag, crew_chat, crew_chat_content 
    private Date update_date; // tag
    private Integer minute = 0;
    private Integer distance = 0;
    private String content;
    private String days;
    private String address;
    private String sido;
    private String sigungu;
    private String shortsido;
    private String is_recruit; // 모집여부
    private String use_yn; // 활성여부 tag
    
//    private String crew_img;
    
    private List<ImageDTO> imgs;
    
    private String img_new;
    
	private String id;
    
	// tag 테이블
    private int tag_idx; // crew_tag
    private String tag_idx_list;
    private String tag_name;

    // crew_chat 테이블
    private int chat_idx = 0; // crew_chat_content 
    private String code_cp;
    
    // crew_chat_content 테이블
    private int content_idx = 0;
    private Date end_date;
    private String nickname;
    
    public String getId() {
    	return id;
    }
    public void setId(String id) {
    	this.id = id;
    }
//    public String getCrew_img() {
//		return crew_img;
//	}
//	public void setCrew_img(String crew_img) {
//		this.crew_img = crew_img;
//	}
	public void setCrew_idx(Integer crew_idx) {
    	this.crew_idx = crew_idx;
    }
    public void setMember(Integer member) {
    	this.member = member;
    }
    public void setCurrent_member(Integer current_member) {
    	this.current_member = current_member;
    }
    public void setMinute(Integer minute) {
    	this.minute = minute;
    }
    public void setDistance(Integer distance) {
    	this.distance = distance;
    }
    
    public List<ImageDTO> getImgs() {
    	return imgs;
    }
    public void setImgs(List<ImageDTO> imgs) {
    	this.imgs = imgs;
    }
    
	public int getCrew_idx() {
		return crew_idx;
	}
	public void setCrew_idx(int crew_idx) {
		this.crew_idx = crew_idx;
	}
	public String getCrew_name() {
		return crew_name;
	}
	public void setCrew_name(String crew_name) {
		this.crew_name = crew_name;
	}
	public int getMember() {
		return member;
	}
	public void setMember(int member) {
		this.member = member;
	}
	public int getCurrent_member() {
		return current_member;
	}
	public void setCurrent_member(int current_member) {
		this.current_member = current_member;
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
	public int getMinute() {
		return minute;
	}
	public void setMinute(int minute) {
		this.minute = minute;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getSigungu() {
		return sigungu;
	}
	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}
	public String getShortsido() {
		return shortsido;
	}
	public void setShortsido(String shortsido) {
		this.shortsido = shortsido;
	}
	public String getIs_recruit() {
		return is_recruit;
	}
	public void setIs_recruit(String is_recruit) {
		this.is_recruit = is_recruit;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public int getTag_idx() {
		return tag_idx;
	}
	public void setTag_idx(int tag_idx) {
		this.tag_idx = tag_idx;
	}
	public String getTag_idx_list() {
		return tag_idx_list;
	}
	public void setTag_idx_list(String tag_idx_list) {
		this.tag_idx_list = tag_idx_list;
	}
	public String getTag_name() {
		return tag_name;
	}
	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}
	public int getChat_idx() {
		return chat_idx;
	}
	public void setChat_idx(int chat_idx) {
		this.chat_idx = chat_idx;
	}
	public String getCode_cp() {
		return code_cp;
	}
	public void setCode_cp(String code_cp) {
		this.code_cp = code_cp;
	}
	public int getContent_idx() {
		return content_idx;
	}
	public void setContent_idx(int content_idx) {
		this.content_idx = content_idx;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getImg_new() {
		return img_new;
	}
	public void setImg_new(String img_new) {
		this.img_new = img_new;
	}
	@Override
	public String toString() {
		return "CrewDTO [crew_idx=" + crew_idx + ", crew_name=" + crew_name + ", member=" + member + ", current_member="
				+ current_member + ", create_date=" + create_date + ", update_date=" + update_date + ", minute="
				+ minute + ", distance=" + distance + ", content=" + content + ", days=" + days + ", address=" + address
				+ ", sido=" + sido + ", sigungu=" + sigungu + ", shortsido=" + shortsido + ", is_recruit=" + is_recruit
				+ ", use_yn=" + use_yn + ", imgs=" + imgs.toString() + ", id=" + id + ", tag_idx="
				+ tag_idx + ", tag_idx_list=" + tag_idx_list + ", tag_name=" + tag_name + ", chat_idx=" + chat_idx
				+ ", code_cp=" + code_cp + ", content_idx=" + content_idx + ", end_date=" + end_date + ", nickname="
				+ nickname + "]";
	}
	
	

	
	
    
}
