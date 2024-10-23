package com.erunjrun.mate.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.erunjrun.mate.dao.MateDAO;
import com.erunjrun.mate.dto.MateDTO;


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

	public MateDTO getProfile(String toUserId) {
		boolean isOpened = false;
		if(mateDAO.profileOpen(toUserId).equals("Y")) {
			isOpened = true;
		}
		logger.info("isOpend:"+isOpened);
		return mateDAO.getProfile(toUserId,isOpened);
	}
	

}
