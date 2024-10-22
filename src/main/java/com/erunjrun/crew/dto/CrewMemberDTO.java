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

	@Override
	public String toString() {
		return "CrewMemberDTO [crew_idx=" + crew_idx + ", id=" + id + ", create_date=" + create_date + ", is_leader="
				+ is_leader + ", history_idx=" + history_idx + ", code_name=" + code_name + ", leader=" + leader
				+ ", is_agree=" + is_agree + ", update_date=" + update_date + ", application_idx=" + application_idx
				+ "]";
	}
	
	

}
