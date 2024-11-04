package com.erunjrun.icon.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.icon.dao.IconDAO;
import com.erunjrun.icon.dto.IconDTO;

@Service
public class IconService {
	
	@Autowired IconDAO iconDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	// 구매리스트
	public List<IconDTO> iconbuylist(int icon_idx,int limit, int offset) {
		
		return iconDAO.iconbuylist(icon_idx,limit,offset);
	}

	public int iconbuycount(int cnt_) {
		
		return iconDAO.iconbuycount(cnt_);
	}


	// 아이콘 차트
	public List<IconDTO> iconchart(int limit, int offset, int startAge, int endAge) {
		
		return  iconDAO.iconchart(limit,offset,startAge,endAge);
	}

	public int iconchartcount(int cnt_) {
	
		return iconDAO.iconchartcount(cnt_);
	}

	// 아이콘 몰
	public List<IconDTO> getIconList(String userId) {
		return iconDAO.getIconList(userId);
	}

	public IconDTO getUserInfo(String userId) {
		return iconDAO.getUserInfo(userId);
	}

	@Transactional
	public boolean buyIcon(String iconIdx, String userId) {
		boolean success = false;
		iconDAO.deductPoint(iconIdx,userId);
		iconDAO.updateMemberTable(userId);
		iconDAO.buyIcon(iconIdx, userId);
		success = true;
		logger.info("success"+success);
		return success;
	}

	public int checkPoint(String iconPrice, String userId) {
		return iconDAO.checkPoint(userId);
	}

	public List<IconDTO> adminIconList(int limit, int offset) {
		return iconDAO.adminIconList(limit,offset);
	}

	public void adminIconWrite(MultipartFile file, Map<String, String> param) {
		String fileName = file.getOriginalFilename();
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = UUID.randomUUID().toString()+ext;
		
		try {
//			byte[] arr = file.getBytes();
//			Path path = Paths.get("/resources/img/icon/");
			String path = "/resources/img/icon/"+ newFileName;
			file.transferTo(new File(path));
			//Path path = Paths.get("C:/upload/"+newFileName);
			//Files.write(path, arr);
			param.put("newFileName", newFileName);
			param.put("path", path);
			iconDAO.adminIconWrite(param);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	

	
	
}
