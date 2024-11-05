package com.erunjrun.comment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erunjrun.comment.dto.CommentDTO;
import com.erunjrun.comment.service.CommentService;
import com.erunjrun.crew.dto.CrewNoticeDTO;
import com.erunjrun.member.dto.MemberDTO;

import com.erunjrun.main.controller.*;

@Controller
public class CommentController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommentService commentService;
	@Autowired AlarmController alarm_controller;
	
	@PostMapping(value="/comment/{board_idx}")
	@ResponseBody
	public Map<String,Object> comment(@PathVariable int board_idx,String order){
		
		logger.info("글번호 : "+board_idx);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<CommentDTO> list = commentService.list(board_idx,order);
		
		result.put("list", list);
		
		return result;
	}
	
	@PostMapping(value="/addComment")
	@ResponseBody
	public Map<String, Object> addComment(int board_idx,String content,HttpSession session,String nickname){
			
		Map<String,Object> result = new HashMap<String, Object>();
		
		String userId = (String) session.getAttribute("loginId");
		int add = commentService.addComment(board_idx,content,nickname, userId);
		
		result.put("add", add);
		
		String board_name = "Y";		
		alarm_controller.boardComment(board_idx, userId, board_name);
		
		return result;
	}
	
	@PostMapping(value="/updateComment")
	@ResponseBody
	public Map<String, Object> update(@RequestBody CommentDTO commentDto){
		
		Map<String,Object> result = new HashMap<String, Object>();
		  
	    boolean success = commentService.update(commentDto);
	    
	    if(success) {
	    	result.put("success", success);
	    }
	    
		return result;
	}
	
	@PostMapping(value="/deleteComment/{comment_idx}")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable int comment_idx){
		
		Map<String,Object> result = new HashMap<String, Object>();
		
		
	    boolean success = commentService.delete(comment_idx);
	    
	    if(success) {
	    	result.put("success", success);
	    }
	    
		return result;
	}
	
	// 크루 공지사항 댓글
	@PostMapping(value="/crewComment/{notice_idx}")
	@ResponseBody
	public Map<String,Object> crewComment(@PathVariable int notice_idx,HttpSession session,String order){
		
		String loginId = (String) session.getAttribute("loginId");
		MemberDTO nickname = null;
    	if(loginId != null) {
    		nickname = commentService.nickName(loginId);
    		logger.info("닉네임 맞냐 :"+nickname);
    	}
		
		logger.info("글번호 : "+notice_idx);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<CommentDTO> list = commentService.commentList(notice_idx,order);
		
		result.put("list", list);
		result.put("nickname", nickname);
		
		return result;
	}
	
	@PostMapping(value="/noticeComment")
	@ResponseBody
	public Map<String, Object> noticeComment(int notice_idx,String content,HttpSession session,String nickname){
			
		Map<String,Object> result = new HashMap<String, Object>();
		
		String loginId = (String) session.getAttribute("loginId");
		
		int add = commentService.noticeComment(notice_idx,content, loginId);
		
		result.put("add", add);
		
		alarm_controller.crewNoticeComment(notice_idx, loginId);
		
		
		return result;
	}
	
	@PostMapping(value="/updateNoticeComment")
	@ResponseBody
	public Map<String, Object> updateNoticeComment(@RequestBody CrewNoticeDTO crewNoticeDto){
		
		Map<String,Object> result = new HashMap<String, Object>();
		  
	    boolean success = commentService.updateNoticeComment(crewNoticeDto);
	    logger.info("했어? : "+success);
	    
	    if(success) {
	    	result.put("success", success);
	    }
	    
		return result;
	}
	
	@PostMapping(value="/noticeCommentDel/{comment_idx}")
	@ResponseBody
	public Map<String, Object> nocoDel(@PathVariable int comment_idx){
		
		logger.info("삭제할 번호 : "+comment_idx);
		boolean success = commentService.nocoDel(comment_idx);
		logger.info("받아 왔어? : "+success);
		Map<String,Object> result = new HashMap<String, Object>();
		
		result.put("success", success);
		
		return result;
	}
	
	// 자유주제 댓글 등록
		@PostMapping(value="/addFreeComment")
		
		@ResponseBody
		public Map<String, Object> addFreeComment(int board_idx,String content,HttpSession session,String nickname){
				
			Map<String,Object> result = new HashMap<String, Object>();
			
			int add = commentService.addFreeComment(board_idx,content,nickname, session);
			
			result.put("add", add);
			
			
			return result;
		}
		
		
		@PostMapping(value="/addAskComment")	
		@ResponseBody
		public Map<String, Object> addAskComment(int board_idx,String content,HttpSession session){
				
			String nickname = (String) session.getAttribute("loginId");
			
			Map<String,Object> result = new HashMap<String, Object>();
			
			int add = commentService.addAskComment(board_idx,content, nickname);
			
			result.put("add", add);
			
			
			return result;
		}
	
	
	
	
	

}
