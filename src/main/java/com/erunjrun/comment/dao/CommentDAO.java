package com.erunjrun.comment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.erunjrun.comment.dto.CommentDTO;

@Mapper
public interface CommentDAO {

	List<CommentDTO> list(int board_idx);

	int addComment(int board_idx,String content, String nickname);

	int commPoint(Map<String, Object> commPoint);

}
