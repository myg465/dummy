package com.bluebiz.board.service;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bluebiz.board.dao.BoardDao;
import com.bluebiz.board.dto.BoardDto;


@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDao boardDao;
	
	@Override
	public void boardList(HttpServletRequest request, Model model) {
		
		int page=0;
		if(request.getParameter("page")==null) {
			page=1;
		}
		
		else {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		int limit=5;
		int listcount=boardDao.boardListCount();
		
		int startRow_=pageCal(listcount, limit, page, model);
		String endRow=startRow_+5+"";
		String startRow=startRow_+"";
		HashMap<String, String> listMap=new HashMap<String, String>();
		listMap.put("startRow", startRow);
		listMap.put("endRow", endRow);
		
		boardDao.boardList(listMap,model);
	}

	@Override
	public void detail(HttpServletRequest request, Model model) {
		
		String board_id=request.getParameter("board_id");
		boardDao.detail(board_id,model);
		
	}
	
	@Override
	public void writeOk(HttpServletRequest request, Model model) {
		
		HashMap<String, String> boardMap= new HashMap<String, String>();
		boardMap.put("title", request.getParameter("title"));
		boardMap.put("content", request.getParameter("content"));
		boardMap.put("id", request.getParameter("id"));
		
		boardDao.writeOk(boardMap,model);
		
	}
	
	@Override
	public void modify_view(HttpServletRequest request, Model model) {
		
		String board_id=request.getParameter("board_id");
		boardDao.modify_view(board_id,model);
		
	}


	@Override
	public void modifyOk(HttpServletRequest request, Model model) {
		
		HashMap<String, String> boardMap= new HashMap<String, String>();
		boardMap.put("title", request.getParameter("title"));
		boardMap.put("content", request.getParameter("content"));
		boardMap.put("board_id", request.getParameter("board_id"));
		boardDao.modifyOk(boardMap,model);
		
	}

	@Override
	public void delete(HttpServletRequest request, RedirectAttributes redirect) {

		String board_id=request.getParameter("board_id");
		boardDao.delete(board_id,redirect);
		
	}

	@Override
	public String reply_write(HashMap<String, String> reqMap) {
		
		return boardDao.reply_write(reqMap);
	}

	@Override
	public String reply_delete(HashMap<String, String> reqMap) {
		
		return boardDao.reply_delete(reqMap);
	}

	@Override
	public String reply_modify(HashMap<String, String> reqMap) {

		return boardDao.reply_modify(reqMap);
	}
	
	public static int pageCal(int listCount, int limit, int page, Model model) {
		
		int pageNum=5;//한줄에 5페이지씩 이동
		//최대 페이지수
		int maxPage = (int)((double)listCount/limit+0.9);
		//처음 페이지
		int startPage = ((int)((double)page/pageNum+0.9)-1)*pageNum+1;
		//마지막 페이지
		int endPage = maxPage;//1~5까지는 maxpage가 endpage가 되야함
		if(endPage>startPage+pageNum-1) endPage=startPage+pageNum-1;//만약에 6이상의 수가 endpage라면
		
		//페이징을 위한 변수세팅
		model.addAttribute("listCount", listCount);
		model.addAttribute("page", page);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		return (page-1)*limit;
	  }//pageCal


	
	
}
