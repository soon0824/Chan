package com.soon.chan.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.soon.chan.vo.Member;

@Repository("memberDao")
public class MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 회원가입
	public int insertMember(Member member) {
		return sqlSession.insert("Member.insertMember", member);
	}

	// 로그인
	public Member login(Member member) {
		return sqlSession.selectOne("Member.login", member);
	}
}
