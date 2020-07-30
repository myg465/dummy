package com.bluebiz.board.dao;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.bluebiz.board.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public String login(HashMap<String, String> reqMap,HttpSession session) {
		
		String result="";
		String name=sqlSession.selectOne("MemberDao.login",reqMap);
		System.out.println(name);
		if(name!=null) {
			session.setAttribute("name", name);
			session.setAttribute("authId", reqMap.get("id"));
			result="ok";
		}
		
		
		return result;
	}

	@Override
	public String idCheck(HashMap<String, String> reqMap) {
		
		String result="";
		String name=sqlSession.selectOne("MemberDao.idCheck",reqMap);
		if(!(name==null || name.equals(""))) {
			result="no";
		}
		else {
			result="ok";
		}
		return result;
	}

	@Override
	public void joinOk(HashMap<String, String> joinMap, Model model) {

		model.addAttribute("joinResult",sqlSession.insert("MemberDao.joinOk",joinMap));
		
	}

}
