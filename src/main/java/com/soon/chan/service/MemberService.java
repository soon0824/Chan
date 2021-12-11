package com.soon.chan.service;

import com.soon.chan.vo.Member;

public interface MemberService {

	int insertMember(Member member); // 회원가입

	Member login(Member member); // 로그인

}
