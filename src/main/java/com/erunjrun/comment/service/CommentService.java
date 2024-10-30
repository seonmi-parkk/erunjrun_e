package com.erunjrun.comment.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erunjrun.comment.dao.CommentDAO;

@Service
public class CommentService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommentDAO commentDao;
	
}
