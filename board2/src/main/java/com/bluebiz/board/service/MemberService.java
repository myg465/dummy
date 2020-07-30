package com.bluebiz.board.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public interface MemberService {

	String login(HashMap<String, String> reqMap,HttpSession session);

	String idCheck(HashMap<String, String> reqMap);

	void joinOk(HttpServletRequest request, Model model);

}
