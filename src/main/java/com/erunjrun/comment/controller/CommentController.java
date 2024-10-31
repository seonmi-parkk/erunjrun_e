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

@Controller
public class CommentController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommentService commentService;
	
	@PostMapping(value="/comment/{board_idx}")
	@ResponseBody
	public Map<String,Object> comment(@PathVariable int board_idx){
		
		logger.info("글번호 : "+board_idx);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<CommentDTO> list = commentService.list(board_idx);
		
		result.put("list", list);
		
		return result;
	}
	
	@PostMapping(value="/addComment")
	@ResponseBody
	public Map<String, Object> addComment(int board_idx,String content,HttpSession session,String nickname){
			
		Map<String,Object> result = new HashMap<String, Object>();
		
		int add = commentService.addComment(board_idx,content,nickname, session);
		
		result.put("add", add);
		
		
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
	
	
	
	
	
	

}
