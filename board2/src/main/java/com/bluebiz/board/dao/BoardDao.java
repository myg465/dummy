package com.bluebiz.board.dao;

import java.util.HashMap;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bluebiz.board.dto.BoardDto;

public interface BoardDao {

	void boardList(HashMap<String, String>listMap,Model model);
	void writeOk(HashMap<String, String> boardMap, Model model);
	void modify_view(String board_id, Model model);
	void modifyOk(HashMap<String, String> boardMap, Model model);
	void delete(String board_id, RedirectAttributes redirect);
	void detail(String board_id, Model model);
	String reply_write(HashMap<String, String> reqMap);
	String reply_delete(HashMap<String, String> reqMap);
	String reply_modify(HashMap<String, String> reqMap);
	int boardListCount();

}
