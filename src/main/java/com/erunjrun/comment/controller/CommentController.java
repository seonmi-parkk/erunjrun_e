package com.erunjrun.comment.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.erunjrun.comment.service.CommentService;

@Controller
public class CommentController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommentService commentService;

}
