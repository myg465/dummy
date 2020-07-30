package com.bluebiz.board.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bluebiz.board.dto.BoardDto;

public interface BoardService {

	void boardList(HttpServletRequest request, Model model);
	void writeOk(HttpServletRequest request, Model model);
	void modify_view(HttpServletRequest request, Model model);
	void modifyOk(HttpServletRequest request, Model model);
	void delete(HttpServletRequest request,RedirectAttributes redirect);
	void detail(HttpServletRequest request, Model model);
	String reply_write(HashMap<String, String> reqMap);
	String reply_delete(HashMap<String, String> reqMap);
	String reply_modify(HashMap<String, String> reqMap);

}
