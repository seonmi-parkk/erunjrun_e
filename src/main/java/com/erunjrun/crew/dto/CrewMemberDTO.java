package com.erunjrun.crew.dto;

import java.sql.Date;

public class CrewMemberDTO {
    
    // crew_member 테이블
    private int crew_idx; // crew_like, crew_history, crew_application_history, crew_application, crew_like
    private String id; // crew_like, crew_history, crew_application_history, crew_application, crew_like
    private Date create_date; // crew_history, crew_application_history, crew_application
    private String is_leader;
    
    // crew_history
    private int history_idx; // crew_application_history
    private String code_name;
    
    // crew_application_history
    private String leader;
    private String is_agree;
    private Date update_date;
    
    // crew_application
    private int application_idx;
    
    private int totalpage;
    
    private Date birth;
    
    
    // 회원 리스트를 위해 추가
    private String nickname;
    private String gender;
    private String image;
    
    private String like;
    
    
    // 권한기록 
    private String member_id;
    private String member_nickname;
    private String member_image;
    private String leader_id;
    private String leader_nickname;
    private String leader_image;
    
    
    private String icon_image;
    
    private String member_icon_image;
    
    private String leader_icon_image;

	public int getCrew_idx() {
		return crew_idx;
	}

	public void setCrew_idx(int crew_idx) {
		this.crew_idx = crew_idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public String getIs_leader() {
		return is_leader;
	}

	public void setIs_leader(String is_leader) {
		this.is_leader = is_leader;
	}

	public int getHistory_idx() {
		return history_idx;
	}

	public void setHistory_idx(int history_idx) {
		this.history_idx = history_idx;
	}

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	public String getLeader() {
		return leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}

	public String getIs_agree() {
		return is_agree;
	}

	public void setIs_agree(String is_agree) {
		this.is_agree = is_agree;
	}

	public Date getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}

	public int getApplication_idx() {
		return application_idx;
	}

	public void setApplication_idx(int application_idx) {
		this.application_idx = application_idx;
	}

	
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	
	
	
	public String getLike() {
		return like;
	}

	public void setLike(String like) {
		this.like = like;
	}
	
	public int getTotalpage() {
		return totalpage;
	}

	public void setTotalpage(int totalpage) {
		this.totalpage = totalpage;
	}
	
	

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}
	
	

	public String getLeader_nickname() {
		return leader_nickname;
	}

	public void setLeader_nickname(String leader_nickname) {
		this.leader_nickname = leader_nickname;
	}
	
	
	

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getMember_image() {
		return member_image;
	}

	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}

	public String getLeader_id() {
		return leader_id;
	}

	public void setLeader_id(String leader_id) {
		this.leader_id = leader_id;
	}

	public String getLeader_image() {
		return leader_image;
	}

	public void setLeader_image(String leader_image) {
		this.leader_image = leader_image;
	}
	
	
	

	public String getIcon_image() {
		return icon_image;
	}

	public void setIcon_image(String icon_image) {
		this.icon_image = icon_image;
	}
	
	

	public String getMember_icon_image() {
		return member_icon_image;
	}

	public void setMember_icon_image(String member_icon_image) {
		this.member_icon_image = member_icon_image;
	}
	
	

	public String getLeader_icon_image() {
		return leader_icon_image;
	}

	public void setLeader_icon_image(String leader_icon_image) {
		this.leader_icon_image = leader_icon_image;
	}

	@Override
	public String toString() {
		return "CrewMemberDTO [crew_idx=" + crew_idx + ", id=" + id + ", create_date=" + create_date + ", is_leader="
				+ is_leader + ", history_idx=" + history_idx + ", code_name=" + code_name + ", leader=" + leader
				+ ", is_agree=" + is_agree + ", update_date=" + update_date + ", application_idx=" + application_idx
				+ ", totalpage=" + totalpage + ", birth=" + birth + ", nickname=" + nickname + ", gender=" + gender
				+ ", image=" + image + ", like=" + like + ", member_id=" + member_id + ", member_nickname="
				+ member_nickname + ", member_image=" + member_image + ", leader_id=" + leader_id + ", leader_nickname="
				+ leader_nickname + ", leader_image=" + leader_image + "]";
	}








	

	
    
    

}
