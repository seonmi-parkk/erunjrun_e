package com.erunjrun.comment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.erunjrun.comment.dao.CommentDAO;
import com.erunjrun.comment.dto.CommentDTO;
import com.erunjrun.crew.dto.CrewNoticeDTO;
import com.erunjrun.member.dto.MemberDTO;

@Service
public class CommentService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommentDAO commentDao;
	public List<CommentDTO> list(int board_idx, String order) {
		
		return commentDao.list(board_idx,order);
	}
	
	public int addComment(int board_idx,String content, String nickname,String userId) {
		
		logger.info("받을 아이디? :"+userId);
		
		Map<String, Object> commPoint = new HashMap<String, Object>();
		commPoint.put("code_name", "P102");
        commPoint.put("id", userId);
        commPoint.put("point", 2);
        
        commentDao.commPoint(commPoint);
		
		return commentDao.addComment(board_idx,content,nickname);
	}
	public boolean update(CommentDTO commentDto) {
		
		return commentDao.update(commentDto) > 0;
	}
	public boolean delete(int comment_idx) {
		
		return commentDao.delete(comment_idx) > 0;
	}
	public List<CommentDTO> commentList(int notice_idx, String order) {
		
		return commentDao.commentList(notice_idx,order);
	}
	public MemberDTO nickName(String loginId) {
		
		return commentDao.nickName(loginId);
	}
	public int noticeComment(int notice_idx, String content, String loginId) {
		
		return commentDao.noticeComment(notice_idx,content,loginId);
	}
	public boolean updateNoticeComment(CrewNoticeDTO crewNoticeDto) {
		
		return commentDao.updateNoticeComment(crewNoticeDto) > 0;
	}
	public boolean nocoDel(int comment_idx) {
		
		return commentDao.nocoDel(comment_idx) >0;
	}
	
	@Transactional
	public int addFreeComment(int board_idx,String content, String nickname,HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		logger.info("받을 아이디? :"+userId);
		
		Map<String, Object> commPoint = new HashMap<String, Object>();
		commPoint.put("code_name", "P102");
        commPoint.put("id", userId);
        commPoint.put("point", 2);
        
        commentDao.commPoint(commPoint);
		
		return commentDao.addFreeComment(board_idx,content,nickname);
	}
	public int addAskComment(int board_idx, String content, String nickname) {
		
		commentDao.askYes(board_idx);
		
		return commentDao.addAskComment(board_idx,content,nickname);
	}

	public void updatePoint(String userId) {
		commentDao.updatePoint(userId);
		
	}
	
	
	
	
	
	
	
	
}
