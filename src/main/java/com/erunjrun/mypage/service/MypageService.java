package com.erunjrun.mypage.service;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.member.dto.MemberDTO;
import com.erunjrun.member.dto.ProfileDTO;
import com.erunjrun.mypage.dao.MypageDAO;
import com.erunjrun.mypage.dto.MypageDTO;

@Service
public class MypageService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MypageDAO mypageDAO;

	public MemberDTO findSessionId(String id) {
		return mypageDAO.findSessionId(id);
	}

	public MemberDTO profileDetail(String id) {
		MemberDTO member = mypageDAO.profileDetail(id);
		return member;
	}

	public ProfileDTO ProfileImage(String id) {
		ProfileDTO profile = mypageDAO.ProfileImage(id); // 프로필 이미지 정보 조회
		return profile;
	}

	public void profileUpdate(Map<String, String> params) {
		int row = mypageDAO.profileUpdate(params); // 회원 정보 업데이트
		logger.info("Update ID: {}", params.get("id"));
		logger.info("Updated rows in member table: {}", row);

		// 이미지 업데이트가 포함된 경우
		if (params.get("image") != null) {
			int profileUpdateRow = mypageDAO.updateProfileImage(params); // 프로필 이미지 업데이트
			logger.info("Updated rows in profile table: {}", profileUpdateRow);
		}
	}

	public void setUseY(String id) {
		mypageDAO.setUseY(id);
	}

	public void updateProfile_use(String id, String Profile_use) {
		mypageDAO.updateProfile_use(id, Profile_use);

	}

	public void firstExerciseProfile(Map<String, String> params) {
		mypageDAO.firstExerciseProfile(params);

	}

	public MypageDTO mypageDetail(String id) {
		return mypageDAO.mypageDetail(id);
	}

	public void updateProfileVisibility(String id, String profileVisibility) {
		// DB에서 프로필 공개 여부 업데이트
		mypageDAO.updateProfileVisibility(id, profileVisibility);
	}

	public void updateMateSearch(String id, String mateSearch) {
		// DB에서 운동 메이트 찾기 여부 업데이트
		mypageDAO.updateMateSearch(id, mateSearch);
	}

	public void addPoint(String id, int point) {
		logger.info("Adding points: {} to user: {}", point, id);
		mypageDAO.addPoint(id, point);
		mypageDAO.updateTotalPoints(id); // member 테이블의 총 포인트 업데이트
	}

	public void ExerciseProfileUpdate(Map<String, String> params) {
		mypageDAO.ExerciseProfileUpdate(params);

	}

	public Map<String, Object> list(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.count(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.list(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}

	public Map<String, Object> getFriendRequests(int page, int cnt, String id) {
		logger.info("Service getFriendRequests called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
	    int totalCount = mypageDAO.countFriendRequests(id, cnt); // ID를 이용해 전체 수 계산
	    logger.info("Total friend requests count: {}", totalCount);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalCount", totalCount);
		result.put("currPage", page);
		result.put("list", mypageDAO.getFriendRequests(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result from getFriendRequests: {}", result); // 데이터 확인
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> getProfileData(String toUserId) {
	    return mypageDAO.getProfileData(toUserId);
	}

	public void acceptFriendRequest(String id, String unlikeId) {
	    mypageDAO.acceptFriendRequest(id, unlikeId); // 요청 수락 처리
	    mypageDAO.insertMateHistory(id, "M101", unlikeId); // mate_history에 수락 기록 추가
	    mypageDAO.deleteFriendRequest(id, unlikeId); // 요청 정보 삭제

	}

	public void rejectFriendRequest(String id, String unlikeId) {
	    mypageDAO.rejectFriendRequest(id, unlikeId); // 요청 거절 처리
	    mypageDAO.insertMateHistory(id, "M102", unlikeId); // mate_history에 거절 기록 추가
	}

	public Map<String, Object> getAppliedMates(int page, int cnt, String id) {
		logger.info("Service getAppliedMates 호출됨: page={}, cnt={}, id={}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
	    int totalCount = mypageDAO.countFriendRequests(id, cnt); // ID를 이용해 전체 수 계산
	    logger.info("Total friend requests count: {}", totalCount);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalCount", totalCount);
		result.put("currPage", page);
		result.put("list", mypageDAO.getAppliedMates(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result from getAppliedMates: {}", result); // 데이터 확인
		logger.info("Result map: {}", result);

		return result;
	}

	public void cancelMateApplication(String id, String unlikeId) {
	    logger.info("Cancelling mate application for user ID: {}, unlikeId: {}", id, unlikeId);
		mypageDAO.cancelMateApplication(id, unlikeId);
	}

	public Map<String, Object> myIconList(int page, int cnt, String id) {
		logger.info("Service getAppliedMates 호출됨: page={}, cnt={}, id={}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
	    int totalCount = mypageDAO.countMyIconList(id, cnt); // ID를 이용해 전체 수 계산
	    logger.info("Total friend requests count: {}", totalCount);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalCount", totalCount);
		result.put("currPage", page);
		result.put("list", mypageDAO.myIconList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result from getAppliedMates: {}", result); // 데이터 확인
		logger.info("Result map: {}", result);

		return result;
	}

	public Map<String, Object> myMateList(int page, int cnt, String id) {
		logger.info("Service getAppliedMates 호출됨: page={}, cnt={}, id={}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
	    int totalCount = mypageDAO.countFriends(id, cnt); // ID를 이용해 전체 수 계산
	    logger.info("Total friend requests count: {}", totalCount);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalCount", totalCount);
		result.put("currPage", page);
		result.put("list", mypageDAO.myMateList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result from getAppliedMates: {}", result); // 데이터 확인
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> myBoardList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countBoard(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.myBoardList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}

	public Map<String, Object> myCommentList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countComment(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.myCommentList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> likedBoardList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countLike(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.likedBoardList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> messageList(Map<String, Object> params) {
		logger.info("Params: {}", params);
		 // Map에서 필요한 값 추출
	    int page = (Integer) params.get("page");
	    int cnt = (Integer) params.get("cnt");
	    String id = (String) params.get("id"); // userId를 params에서 가져옴
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countMessage(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.messageList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}

	public Map<String, Object> crewMasterMessageList(Map<String, Object> params) {
		logger.info("Params: {}", params);
		 // Map에서 필요한 값 추출
	    int page = (Integer) params.get("page");
	    int cnt = (Integer) params.get("cnt");
	    String id = (String) params.get("id"); // userId를 params에서 가져옴
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countCrewMessage(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.crewMasterMessageList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> memberCrewList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countMemberCrewList(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.memberCrewList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> requestedCrewList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countRequestedCrewList(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.requestedCrewList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> likedCrewList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);

		int limit = cnt;
		int offset = (page - 1) * cnt;

		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countLikedCrewList(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);

		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.likedCrewList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);

		return result;
	}
	
	public Map<String, Object> likedMemberList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);
		
		int limit = cnt;
		int offset = (page - 1) * cnt;
		
		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countLikedMemberList(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);
		
		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.likedMemberList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);
		
		return result;
	}
	
	public Map<String, Object> blockMemberList(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);
		
		int limit = cnt;
		int offset = (page - 1) * cnt;
		
		// 전체 페이지 수 계산
		int totalPages = mypageDAO.countBlockMemberList(id, cnt); // ID를 이용해 전체 페이지 수 계산
		logger.info("Total pages: {}", totalPages);
		
		// 결과 맵 생성
		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", mypageDAO.blockMemberList(limit, offset, id)); // ID를 이용해 리스트 가져오기
		logger.info("Result map: {}", result);
		
		return result;
	}
}
