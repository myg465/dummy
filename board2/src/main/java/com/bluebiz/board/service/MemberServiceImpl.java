package com.bluebiz.board.service;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.bluebiz.board.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDao memberDao;
	
	@Override
	public String login(HashMap<String, String> reqMap,HttpSession session) {
		
		return memberDao.login(reqMap,session);
	}

	@Override
	public String idCheck(HashMap<String, String> reqMap) {
		
		return memberDao.idCheck(reqMap);
	}

	@Override
	public void joinOk(HttpServletRequest request, Model model) {
		
		HashMap<String, String> joinMap= new HashMap<String, String>();
		joinMap.put("id", request.getParameter("id"));
		joinMap.put("pw", request.getParameter("pw"));
		joinMap.put("name", request.getParameter("name"));
		
		memberDao.joinOk(joinMap,model);
	}

}
