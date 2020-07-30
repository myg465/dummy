package com.bluebiz.board.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public interface MemberDao {

	String login(HashMap<String, String> reqMap,HttpSession session);

	String idCheck(HashMap<String, String> reqMap);

	void joinOk(HashMap<String, String> joinMap, Model model);

}
