package com.erunjrun.icon.service;

import com.erunjrun.icon.dao.IconDAO;
import com.erunjrun.icon.dto.IconDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class IconService {

    private final IconDAO iconDAO;

    public IconService(IconDAO iconDAO) {
        this.iconDAO = iconDAO;
    }

    Logger logger = LoggerFactory.getLogger(getClass());
    @Value("${upload.path}")
    String paths;


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
        iconDAO.deductPoint(iconIdx, userId);
        iconDAO.updateMemberTable(userId);
        iconDAO.buyIcon(iconIdx, userId);
        success = true;
        return success;
    }

    public int checkPoint(String iconPrice, String userId) {
        return iconDAO.checkPoint(userId);
    }

    public List<IconDTO> adminIconList(int limit, int offset) {
        return iconDAO.adminIconList(limit, offset);
    }


    public Map<String, String> FileSave(MultipartFile file, Map<String, String> param) {
        String fileName = file.getOriginalFilename();
        String ext = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = UUID.randomUUID().toString() + ext;

        try {
            byte[] arr = file.getBytes();
            Path path = Paths.get(paths + newFileName);
            Files.write(path, arr);
            param.put("path", newFileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return param;
    }

    @Transactional
    public void adminIconWrite(MultipartFile file, Map<String, String> param) {
        param = FileSave(file, param);
        iconDAO.adminIconWrite(param);
    }

    public IconDTO adminIconData(String icon_idx) {
        return iconDAO.adminIconData(icon_idx);
    }

    @Transactional
    public void adminIconUpdate(MultipartFile file, Map<String, String> param) {
        if (file == null || file.isEmpty()) {
            param.put("path", param.get("bfImage"));
        } else {
            param = FileSave(file, param);
        }
        iconDAO.adminIconUpdate(param);
    }


    // 구매리스트
    public List<IconDTO> iconbuylist(int icon_idx, int limit, int offset) {
        return iconDAO.iconbuylist(icon_idx, limit, offset);
    }

    public int iconbuycount(int cnt_, String icon_idx) {
        return iconDAO.iconbuycount(cnt_, icon_idx);
    }


    // 아이콘 차트
    public List<IconDTO> iconchart(int limit, int offset, int startAge, int endAge) {
        return iconDAO.iconchart(limit, offset, startAge, endAge);
    }

    public int iconchartcount(int cnt_, int startAge, int endAge) {
        return iconDAO.iconchartcount(cnt_, startAge, endAge);
    }

    public List<IconDTO> getMonthlySalesData(Integer year) {
        return iconDAO.getMonthlySalesData(year);
    }

    public List<IconDTO> getWeeklySalesData(Integer year, Integer month) {
        return iconDAO.getWeeklySalesData(year, month);
    }

    public List<IconDTO> getDailySalesData(Integer year, Integer month) {
        return iconDAO.getDailySalesData(year, month);
    }

    public List<Integer> getAvailableYears() {
        return iconDAO.getAvailableYears();
    }


}
