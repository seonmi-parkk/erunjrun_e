package com.erunjrun.member.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MemberDTO {

    private String id;
    private String pw;
    private String name;
    private String nickname;
    private String address;
    private Date birth;
    private String gender;
    private String email;
    private String phone;
    private int point;
    private String use_yn;
    private String profile_use;
    
    private String image;
    private String icon_image;

    public String getProfile_use() {
        return profile_use;
    }
    
    public void setProfile_use(String profile_use) {
        this.profile_use = profile_use;
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
    
    public String getUse_yn() {
        return use_yn;
    }
    
    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getPw() {
        return pw;
    }
    
    public void setPw(String pw) {
        this.pw = pw;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getNickname() {
        return nickname;
    }
    
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public Date getBirth() {
        return birth;
    }
    
    public void setBirth(Date birth) { // 수정된 setter 메서드
        this.birth = birth;
    }
    
    public String getFormattedBirth() { // 포맷된 생년월일 반환
        if (birth != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            return sdf.format(birth);
        }
        return null; // 생년월일이 없을 경우 null 반환
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public int getPoint() {
        return point;
    }
    
    public void setPoint(int point) {
        this.point = point;
    }
}
