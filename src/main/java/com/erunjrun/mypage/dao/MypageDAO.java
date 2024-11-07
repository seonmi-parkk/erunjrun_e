package com.erunjrun.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.member.dto.MemberDTO;
import com.erunjrun.member.dto.ProfileDTO;
import com.erunjrun.mypage.dto.MypageDTO;

@Mapper
public interface MypageDAO {

	MemberDTO findSessionId(String id);

	MemberDTO profileDetail(String id);

	ProfileDTO ProfileImage(String id);

	int profileUpdate(Map<String, String> params);

	int updateProfileImage(Map<String, String> params);

	void setUseY(String id);

	void updateProfile_use(String id, String Profile_use);

	void firstExerciseProfile(Map<String, String> params);

	MypageDTO mypageDetail(String id);

	void updateProfileVisibility(String id, String profileVisibility);
	
	void updateMateSearch(String id, String mateSearch);

	void ExerciseProfileUpdate(Map<String, String> params);

	void addPoint(String id, int point);

	void updateTotalPoints(String id);

	// List 메서드 정의
	List<MypageDTO> list(int limit, int offset, String id);

	// Count 메서드 정의
	int count(String id, int cnt);

	List<Map<String, Object>> getFriendRequests(int limit, int offset, String id);

	int countFriendRequests(String id, int cnt);

	void acceptFriendRequest(String id, String unlikeId);

	void rejectFriendRequest(String id, String unlikeId);

	void insertMateHistory(String id, String code_name, String unlikeId);

	void deleteFriendRequest(String id, String unlikeId);
	
	List<Map<String, Object>> getAppliedMates(int limit, int offset, String id);
	
	void cancelMateApplication(String id, String unlikeId);

	int countMyIconList(String id, int cnt);

	List<Map<String, Object>> myIconList(int limit, int offset, String id);
	
	boolean iconImageUpdate(Long iconId, String id);
	
	boolean iconImageUpdateToDefault(String userId);

	Map<String, Object> getProfileData(String toUserId);
	
	List<Map<String, Object>> myMateList(int limit, int offset, String id);

	int countFriends(String id, int cnt);

	List<Map<String, Object>> myBoardList(int limit, int offset, String id);

	int countBoard(String id, int cnt);
	
	List<Map<String, Object>> myCommentList(int limit, int offset, String id);

	int countComment(String id, int cnt);

	List<Map<String, Object>> likedBoardList(int limit, int offset, String id);

	int countLike(String id, int cnt);
	
	List<Map<String, Object>> messageList(int limit, int offset, String id);

	int countMessage(String id, int cnt);
	
	List<Map<String, Object>> crewMasterMessageList(int limit, int offset, String id);

	int countCrewMessage(String id, int cnt);

	List<Map<String, Object>> memberCrewList(int limit, int offset, String id);

	int countMemberCrewList(String id, int cnt);

	List<Map<String, Object>> requestedCrewList(int limit, int offset, String id);

	int countRequestedCrewList(String id, int cnt);

	List<Map<String, Object>> likedCrewList(int limit, int offset, String id);
	
	int countLikedCrewList(String id, int cnt);

	List<Map<String, Object>> likedMemberList(int limit, int offset, String id);

	int countLikedMemberList(String id, int cnt);

	List<Map<String, Object>> blockMemberList(int limit, int offset, String id);

	int countBlockMemberList(String id, int cnt);

	int cancel(String unlikeId, String id);

	String getSelectedIcon(String id);

}
