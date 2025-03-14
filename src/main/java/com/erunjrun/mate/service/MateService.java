package com.erunjrun.mate.service;

import com.erunjrun.mate.dao.MateDAO;
import com.erunjrun.mate.dto.MateDTO;
import com.erunjrun.mate.dto.MateProfileDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.List;


@Service
public class MateService {
	private final MateDAO mateDAO;

	public MateService(MateDAO mateDAO) {
		this.mateDAO = mateDAO;
	}

	Logger logger = LoggerFactory.getLogger(getClass());

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

	public boolean checkMate(String fromUserId, String toUserId) {
        return mateDAO.checkMate(fromUserId, toUserId) > 0;
	}

	public boolean checkBlock(String fromUserId, String toUserId) {
        return mateDAO.checkBlock(fromUserId, toUserId) > 0;
	}

	public boolean checkLike(String fromUserId, String toUserId) {
        return mateDAO.checkLike(fromUserId, toUserId) > 0;
	}

	public MateProfileDTO getProfile(String toUserId) {
		MateProfileDTO profileDTO = mateDAO.getProfile(toUserId);
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
        return mateDAO.dislike(fromUserId, toUserId) > 0;
	}

	public boolean like(String fromUserId, String toUserId) {
        return mateDAO.like(fromUserId, toUserId) > 0;
	}

	public String checkMateAppl(String fromUserId, String toUserId) {
		String MateAppl = "none";		
		MateDTO mateDto = mateDAO.checkMateAppl(fromUserId,toUserId);

		if(mateDto == null) {
			return MateAppl;
		}
		if(mateDto.getCode_name().equals("M100")) {
			if(mateDto.getUnlike_id().equals(fromUserId)) {
				MateAppl = "apply";
			}else if(mateDto.getUnlike_id().equals(toUserId)) {
				MateAppl = "recieve";				
			}
		}else if(mateDto.getCode_name().equals("M101")){
			MateAppl = "mate";
		}

		return MateAppl;
	}

	public boolean mateBlock(String fromUserId, String toUserId) {
        return mateDAO.mateBlock(fromUserId, toUserId) > 0;
	}

	public boolean mateUnblock(String fromUserId, String toUserId) {
        return mateDAO.mateUnblock(fromUserId, toUserId) > 0;
	}

	public List<MateProfileDTO> searchMateList(MateProfileDTO userPos) {
		return mateDAO.searchMateList(userPos);
	}

	public MateProfileDTO getUserPos(String fromUserId) {
		return mateDAO.getUserPos(fromUserId);
	}

	public List<MateProfileDTO> getPosList(String fromUserId) {
		return mateDAO.getPosList(fromUserId);
	}

	public List<MateProfileDTO> moveMateList(List<String> users, String fromUserId) {
		return mateDAO.moveMateList(users, fromUserId);
	}

	public String getExerciseUse(String fromUserId) {
		return mateDAO.getExerciseUse(fromUserId);
	}

	public boolean mateOn(String userId) {
		return mateDAO.mateOn(userId) > 0;
	}

	public boolean hasProfile(String fromUserId) {
		return mateDAO.hasProfile(fromUserId) > 0;
	}
	

}
