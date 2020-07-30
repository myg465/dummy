package com.bluebiz.board.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluebiz.board.service.MemberService;


@Controller
public class MemberController {

	@Inject
	MemberService memberService;
	
	@RequestMapping("login")
	public String login() {
		return "login";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "loginOk",method = RequestMethod.POST)
	public HashMap<String, String> loginOk(@RequestBody HashMap<String, String> reqMap,HttpSession session){
		
		HashMap<String, String> resMap=new HashMap<String, String>();
		
		resMap.put("result", memberService.login(reqMap,session));
		
		return resMap;
		
	}
	
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:login";
	}
	
	@RequestMapping("join")
	public String join() {
		
		return "join_view";
	}
	
	@ResponseBody
	@RequestMapping(value = "idCheck",method = RequestMethod.POST)
	public HashMap<String, String> idCheck(@RequestBody HashMap<String, String> reqMap){
		
		HashMap<String, String> resMap=new HashMap<String, String>();
		
		resMap.put("result", memberService.idCheck(reqMap));
		
		return resMap;
		
	}
	
	@RequestMapping("joinOk")
	public String joinOk(HttpServletRequest request, Model model) {
		
		memberService.joinOk(request,model);
		
		return "join_view";
	}
	
}
