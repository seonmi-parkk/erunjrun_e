package com.erunjrun.admin.dto;

import java.sql.Date;

import com.erunjrun.icon.dto.IconDTO;
import com.erunjrun.image.dto.ImageDTO;

public class AdminDTO {
   private String id;
   private String nickname;
   private String email;
   private String report_status;
   private int report_count;
   private Date join_date;
   private String admin_id;
   private String name;
   private String code_name;
   private String use_yn;
   private Date create_date;
   private Date update_date;
   private Date start_date;
   private Date end_date;
   private Date process_date;
   private String address;
   private String gender;
   private Date birth;
   private String unlike_id;
   private String content;
   private String ban_content;
   private String category;
   private String process;
   private String report_idx;
   private String ban_idx;
   private String tag_idx;
   private String tag_name;
   private String code_use;
   private PopupDTO popupdto;
   private ImageDTO image;
   private IconDTO icondto;
   private String status;
   private String subject;
   
   
   
   
   
   public String getSubject() {
      return subject;
   }
   public void setSubject(String subject) {
      this.subject = subject;
   }
   public ImageDTO getImage() {
      return image;
   }
   public void setImage(ImageDTO image) {
      this.image = image;
   }
   public PopupDTO getPopupdto() {
      return popupdto;
   }
   public void setPopupdto(PopupDTO popupdto) {
      this.popupdto = popupdto;
   }
   public String getCode_use() {
      return code_use;
   }
   public void setCode_use(String code_use) {
      this.code_use = code_use;
   }
   public String getTag_name() {
      return tag_name;
   }
   public void setTag_name(String tag_name) {
      this.tag_name = tag_name;
   }
   public Date getUpdate_date() {
      return update_date;
   }
   public void setUpdate_date(Date update_date) {
      this.update_date = update_date;
   }
   public String getTag_idx() {
      return tag_idx;
   }
   public void setTag_idx(String tag_idx) {
      this.tag_idx = tag_idx;
   }
   
   public String getBan_idx() {
      return ban_idx;
   }
   public void setBan_idx(String ban_idx) {
      this.ban_idx = ban_idx;
   }
   public String getReport_idx() {
      return report_idx;
   }
   public void setReport_idx(String report_idx) {
      this.report_idx = report_idx;
   }
   public String getCategory() {
      return category;
   }
   public void setCategory(String category) {
      this.category = category;
   }
   public String getProcess() {
      return process;
   }
   public void setProcess(String process) {
      this.process = process;
   }
   public String getBan_content() {
      return ban_content;
   }
   public void setBan_content(String ban_content) {
      this.ban_content = ban_content;
   }
   
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getUnlike_id() {
      return unlike_id;
   }
   public void setUnlike_id(String unlike_id) {
      this.unlike_id = unlike_id;
   }
   public Date getBirth() {
      return birth;
   }
   public void setBirth(Date birth) {
      this.birth = birth;
   }
   private String phone;
   
   public String getAddress() {
      return address;
   }
   public void setAddress(String address) {
      this.address = address;
   }
   public String getGender() {
      return gender;
   }
   public void setGender(String gender) {
      this.gender = gender;
   }
   
   public String getPhone() {
      return phone;
   }
   public void setPhone(String phone) {
      this.phone = phone;
   }
   public Date getProcess_date() {
      return process_date;
   }
   public void setProcess_date(Date process_date) {
      this.process_date = process_date;
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
   public String getCode_name() {
      return code_name;
   }
   public void setCode_name(String code_name) {
      this.code_name = code_name;
   }
   public String getUse_yn() {
      return use_yn;
   }
   public void setUse_yn(String use_yn) {
      this.use_yn = use_yn;
   }

   
   public Date getCreate_date() {
      return create_date;
   }
   public void setCreate_date(Date create_date) {
      this.create_date = create_date;
   }
   public String getAdmin_id() {
      return admin_id;
   }
   public void setAdmin_id(String admin_id) {
      this.admin_id = admin_id;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getNickname() {
      return nickname;
   }
   public void setNickname(String nickname) {
      this.nickname = nickname;
   }
   public String getEmail() {
      return email;
   }
   public void setEmail(String email) {
      this.email = email;
   }
   public String getReport_status() {
      return report_status;
   }
   public void setReport_status(String report_status) {
      this.report_status = report_status;
   }
   public int getReport_count() {
      return report_count;
   }
   public void setReport_count(int report_count) {
      this.report_count = report_count;
   }
   public Date getJoin_date() {
      return join_date;
   }
   public void setJoin_date(Date join_date) {
      this.join_date = join_date;
   }
   public IconDTO getIcondto() {
      return icondto;
   }
   public void setIcondto(IconDTO icondto) {
      this.icondto = icondto;
   }
   public String getStatus() {
      return status;
   }
   public void setStatus(String status) {
      this.status = status;
   }
   
   
   
   
} 