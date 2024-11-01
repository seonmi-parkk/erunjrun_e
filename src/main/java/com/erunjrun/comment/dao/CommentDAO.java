package com.erunjrun.comment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.comment.dto.CommentDTO;
import com.erunjrun.crew.dto.CrewNoticeDTO;
import com.erunjrun.member.dto.MemberDTO;

@Mapper
public interface CommentDAO {

	List<CommentDTO> list(int board_idx);

	int addComment(int board_idx,String content, String nickname);

	int commPoint(Map<String, Object> commPoint);

	int update(CommentDTO commentDto);

	int delete(int comment_idx);

	List<CommentDTO> commentList(int notice_idx);

	MemberDTO nickName(String loginId);

	int noticeComment(int notice_idx, String content, String loginId);

	int updateNoticeComment(CrewNoticeDTO crewNoticeDto);

	int nocoDel(int comment_idx);

}
