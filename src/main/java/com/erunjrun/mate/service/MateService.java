package com.erunjrun.mate.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.erunjrun.mate.dao.MateDAO;

@Service
public class MateService {
	@Autowired MateDAO mateDAO;

	@Transactional
	public boolean mateApplication(String fromUserId, String toUserId) {
		boolean result = false;
		int appRst = mateDAO.mateApplication(fromUserId, toUserId);
		int historyRst = mateDAO.mateHistory(fromUserId, toUserId);
		if(appRst > 0 && historyRst > 0) {
			result = true;
		}
		return result;
	}

}
