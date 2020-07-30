package com.bluebiz.board.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bluebiz.board.dto.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public void boardList(HashMap<String, String>listMap,Model model) {
		
		model.addAttribute("boardList",sqlSession.selectList("BoardDao.boardList",listMap));
		
	}
	
	
	
	@Override
	public void detail(String board_id, Model model) {
		
		model.addAttribute("detail_view",sqlSession.selectOne("BoardDao.detail",board_id));
		model.addAttribute("reply_view",sqlSession.selectList("BoardDao.reply_list",board_id));
		
		
	}
	



	@Override
	public void writeOk(HashMap<String, String> boardMap, Model model) {
		
		model.addAttribute("writeResult",sqlSession.insert("BoardDao.writeOk",boardMap));
		
	}


	
	@Override
	public void modify_view(String board_id,Model model) {
		
		
		model.addAttribute("modify_view",sqlSession.selectOne("BoardDao.modify_view",board_id));
		
	}

	
	@Override
	public void modifyOk(HashMap<String, String> boardMap, Model model) {
		
		model.addAttribute("modifyResult",sqlSession.update("BoardDao.modifyOk",boardMap));
		
	}





	@Override
	public void delete(String board_id, RedirectAttributes redirect) {

		redirect.addAttribute("deleteResult",sqlSession.delete("BoardDao.boardDelete",board_id));
		
		
	}



	@Override
	public String reply_write(HashMap<String, String> reqMap) {
	    
		String result="";
		if(sqlSession.insert("BoardDao.reply_write",reqMap)==1) {
			result="ok";
		}
		else {
			result="no";
		}
		
		return result;
	}



	@Override
	public String reply_delete(HashMap<String, String> reqMap) {
		
		String result="";
		if(sqlSession.update("BoardDao.reply_delete",reqMap)==1) {
			result="ok";
		}
		else {
			result="no";
		}
		
		return result;
	}



	@Override
	public String reply_modify(HashMap<String, String> reqMap) {
		
		String result="";
		if(sqlSession.update("BoardDao.reply_modify",reqMap)==1) {
			result="ok";
		}
		else {
			result="no";
		}
		
		return result;
	}



	@Override
	public int boardListCount() {
		
		return sqlSession.selectOne("BoardDao.listCount");
	}




	
	
	
	
	

	
	
}
