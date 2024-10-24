package com.erunjrun.mate.service;

import java.util.Calendar;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.erunjrun.mate.dao.MateDAO;
import com.erunjrun.mate.dto.MateDTO;
import com.erunjrun.mate.dto.MateProfileDTO;


@Service
public class MateService {
	@Autowired MateDAO mateDAO;
	Logger logger = LoggerFactory.getLogger(getClass());

	@Transactional
	public boolean mateApplication(String fromUserId, String toUserId) {
		boolean result = false;
		int appRst = mateDAO.mateApplication(fromUserId, toUserId);
		int historyRst = mateDAO.mateHistory(fromUserId, toUserId);

		logger.info("appRst: {}, historyRst: {}", appRst, historyRst); 
		if(appRst > 0 && historyRst > 0) { result = true; }
		
		return result;
	}

	public boolean checkMate(String fromUserId, String toUserId) {
		boolean isMate = false;
		if(mateDAO.checkMate(fromUserId,toUserId)>0) {
			isMate = true;
		}
		return isMate;
	}

	public boolean checkBlock(String fromUserId, String toUserId) {
		boolean isBlocked = false;
		if(mateDAO.checkBlock(fromUserId,toUserId)>0) {
			isBlocked = true;
		}
		return isBlocked;
	}

//	public boolean profileOpen(String toUserId) {
//		boolean isOpened = false;
//		if(mateDAO.profileOpen(toUserId) != null) {
//			isOpened = true;
//		}
//		return isOpened;
//	}

	public boolean checkLike(String fromUserId, String toUserId) {
		boolean isLiked = false;
		if(mateDAO.checkLike(fromUserId,toUserId)>0) {
			isLiked = true;
		}
		return isLiked;
	}

	public MateProfileDTO getProfile(String toUserId) {
		boolean isOpened = false;
		if(mateDAO.profileOpen(toUserId).equals("Y")) {
			isOpened = true;
		}
		logger.info("isOpend:"+isOpened);
		MateProfileDTO profileDTO = mateDAO.getProfile(toUserId,isOpened);
		int birthYear = Integer.parseInt(profileDTO.getBirth().split("-")[0]);
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int age = year - birthYear;
		String ageArea = "";
		for(int numMin=20, numMax=24; numMin<=50; numMin+=5, numMax+=5){
		 	if(age>=numMin && age<=numMax){
		 		ageArea = numMin+"~"+numMax+"세";
		 	}
	 	}
		profileDTO.setBirth(ageArea);
		
		return profileDTO;
	}

	public boolean dislike(String fromUserId, String toUserId) {
		boolean success = false;
		if(mateDAO.dislike(fromUserId,toUserId)>0) {
			success = true;
		}
		return success;
	}

	public boolean like(String fromUserId, String toUserId) {
		boolean success = false;
		if(mateDAO.like(fromUserId,toUserId)>0) {
			success = true;
		}
		return success;
	}

	public String checkMateAppl(String fromUserId, String toUserId) {
		String MateAppl = "";		
		MateDTO mateDto = mateDAO.checkMateAppl(fromUserId,toUserId);
		if(mateDto.getCode_name().equals("M100")) {
			if(mateDto.getUnlike_id().equals(fromUserId)) {
				MateAppl = "apply";
			}else if(mateDto.getUnlike_id().equals(toUserId)) {
				MateAppl = "recieve";				
			}
		}else if(mateDto.getCode_name().equals("M101")){
			MateAppl = "mate";
		}else{
			MateAppl = "none";
		}
		logger.info("MateAppl"+MateAppl);
		return MateAppl;
	}

	public boolean mateBlock(String fromUserId, String toUserId) {
		boolean success = false;
		if(mateDAO.mateBlock(fromUserId, toUserId)>0) {
			success = true;
		}
		return success;
	}

	public boolean mateUnblock(String fromUserId, String toUserId) {
		boolean success = false;
		if(mateDAO.mateUnblock(fromUserId, toUserId)>0) {
			success = true;
		}
		return success;
	}
	

}
