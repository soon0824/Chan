package com.soon.chan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soon.chan.dao.MemberDao;
import com.soon.chan.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;

	// 회원가입
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}
	
	// 로그인
	@Override
	public Member login(Member member) {
		return memberDao.login(member);
	}

	// 아이디찾기
	@Override
	public Member findId(Member me) {
		return memberDao.findId(me);
	}
	
	// 비밀번호찾기
	@Override
	public Member findPwd(Member me) {
		return memberDao.findPwd(me);
	}

}
