package com.bluebiz.board.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bluebiz.board.dto.BoardDto;
import com.bluebiz.board.service.BoardService;


@Controller
public class BoardController {

	@Inject
	BoardService boardService;
	
	@RequestMapping("list")
	public String boardList(HttpServletRequest request, Model model) {
		
		boardService.boardList(request,model);
		return "board_list";
	}
	
	@RequestMapping("detail")
	public String detail(HttpServletRequest request, Model model) {
		
		boardService.detail(request,model);
		return "detail";
	}
	
	@RequestMapping("write")
	public String write() {
		return "write_view";
		
	}
	
	@RequestMapping("writeOk")
	public String writeOk(HttpServletRequest request,Model model) {
		boardService.writeOk(request,model);
		
		return "write_view";
	}
	
	@RequestMapping("modify")
	public String modify(HttpServletRequest request, Model model) {
		
		boardService.modify_view(request, model);
		
		return "modify_view";
		
	}
	
	
	
	@RequestMapping("modifyOk")
	public String modifyOk(HttpServletRequest request, Model model) {
		
		boardService.modifyOk(request,model);
		
		return "modify_view";
	}
	
	@RequestMapping("delete")
	public String delete(HttpServletRequest request, RedirectAttributes redirect) {
		
		boardService.delete(request,redirect);
		
		return "redirect:list";
	}
	
	@ResponseBody
	@RequestMapping("reply_write")
	public HashMap<String, String> reply_write(@RequestBody HashMap<String, String> reqMap){
		
		HashMap<String, String> resMap= new HashMap<String, String>();
		resMap.put("result", boardService.reply_write(reqMap));
		
		return resMap;
	}
	
	@ResponseBody
	@RequestMapping("reply_modify")
	public HashMap<String, String> reply_modify(@RequestBody HashMap<String, String> reqMap){
		
		HashMap<String, String> resMap= new HashMap<String, String>();
		resMap.put("result",boardService.reply_modify(reqMap));
		
		return resMap;
	}
	
	@ResponseBody
	@RequestMapping("reply_delete")
	public HashMap<String, String> reply_delete(@RequestBody HashMap<String, String> reqMap){
		
		HashMap<String, String> resMap= new HashMap<String, String>();
		resMap.put("result",boardService.reply_delete(reqMap));
		
		return resMap;
	}
	
	
}
