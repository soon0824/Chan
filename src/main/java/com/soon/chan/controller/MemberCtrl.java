package com.soon.chan.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.soon.chan.service.MemberService;
import com.soon.chan.vo.Member;

@Controller
@RequestMapping("/member")
public class MemberCtrl {
	
	@Autowired
	private MemberService memberService;

	// 회원가입 페이지
	@RequestMapping(value = "/join", method = RequestMethod.GET)  
	public String join() {
		System.out.println("회원가입페이지 들어옴");
		return "member/join";
	}

	// 회원가입 처리
	@ResponseBody
	@RequestMapping(value = "/doJoin", method = RequestMethod.POST)  
	public void doJion(Member member) {
		System.out.println("회원가입 성공");
		int result = 0;
		result = memberService.insertMember(member);
		System.out.println("Member : " + result);
		
	}
	
	// 로그인페이지로 이동
	@RequestMapping(value = "/login") 
	public String login() {
		System.out.println("로그인 페이지 들어옴");
		return "/member/login";
	}
	
	// 로그인
	@RequestMapping(value = "/loginPost", method = RequestMethod.POST) 
	public String loginPost(Member member, HttpServletResponse response, HttpSession session) throws Exception {
		Member loginMember = memberService.login(member);
		PrintWriter pw = response.getWriter();
		
		if(loginMember != null) {
			String id1 = member.getUserId();
			String id2 = loginMember.getUserId();
			String pwd1 = member.getUserPwd();
			String pwd2 = member.getUserPwd();
			
			if(id2.equals("")&&pwd2.equals("")) {
				pw.println("<script type='text/javascript'>"); 
				pw.println("alert('아이디와 비밀번호를 확인해주세요.');"); 
				pw.println("</script>");
				pw.flush();
			}else {
				session.setAttribute("member", loginMember);
				System.out.println("정상 로그인");
			}
		}
		System.out.println("로그인 성공");
		return "board/list";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		// 세션 삭제
		System.out.println("로그아웃");
		session.removeAttribute("member");
		
		return "/member/login";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "/findId")
	public String findId() {
		return "/member/findId";
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "/findPwd")
	public String findPwd() {
		return "/member/findPwd";
	}
}
