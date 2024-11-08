package com.erunjrun.board.dto;


import java.sql.Date;
import java.util.List;

import com.erunjrun.image.dto.ImageDTO;

public class RunBoardDTO {
	
	// 러닝코스 게시판 테이블
	private int board_idx;
	private String id; // 회원 테이블 fk
	private String nickname; // 회원테이블의 닉네임
	private String code_name;
	private String subject;
	private String content;
	private Date create_date;
	private Date update_date;
	private int bHit;
	private int likes;
	private String use_yn; // 활성여부
	private String is_map; // 지도 사용 여부
	
	// 지도 테이블
	private double latitude;
	private double longitude;
	private String path;
	private int order_num;
	
    // 지도 데이터 (경로 정보)
    private List<Double> latitudeList;
    private List<Double> longitudeList;
    private List<String> pathList;
    private List<Integer> orderList;
    
    // 이미지 리스트
    private List<ImageDTO> imageList;
    
    
    // 포인트 테이블
    private int point_idx;
    private int point;
    
    //문의하기 테이블
    private int ask_idx;
    private String is_ask;
    
    // 아이콘
    private String icon_image;
    private String image;
    
    
    
    
    
    
    
    

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
	public int getAsk_idx() {
		return ask_idx;
	}
	public void setAsk_idx(int ask_idx) {
		this.ask_idx = ask_idx;
	}
	public String getIs_ask() {
		return is_ask;
	}
	public void setIs_ask(String is_ask) {
		this.is_ask = is_ask;
	}
	public int getPoint_idx() {
		return point_idx;
	}
	public void setPoint_idx(int point_idx) {
		this.point_idx = point_idx;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public List<Integer> getOrderList() {
		return orderList;
	}
	public void setOrderList(List<Integer> orderList) {
		this.orderList = orderList;
	}
	
	
	public List<Double> getLatitudeList() {
		return latitudeList;
	}
	public void setLatitudeList(List<Double> latitudeList) {
		this.latitudeList = latitudeList;
	}
	public List<Double> getLongitudeList() {
		return longitudeList;
	}
	public void setLongitudeList(List<Double> longitudeList) {
		this.longitudeList = longitudeList;
	}
	public List<String> getPathList() {
		return pathList;
	}
	public void setPathList(List<String> pathList) {
		this.pathList = pathList;
	}
	public List<ImageDTO> getImageList() {
		return imageList;
	}
	public void setImageList(List<ImageDTO> imageList) {
		this.imageList = imageList;
	}
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
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longtude) {
		this.longitude = longtude;
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
