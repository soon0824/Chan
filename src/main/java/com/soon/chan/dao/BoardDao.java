package com.soon.chan.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.soon.chan.vo.Board;

@Repository("BoardDao")
public class BoardDao {

	@Autowired
	private SqlSession SqlSession;

	// 게시판 리스트
	public int listCount()  {
		return SqlSession.selectOne("Board.listCount");
	}
	
	// 페이징 처리
	public List<Board> selectList(int currentPage, int limit) {
		int startRow = (currentPage - 1) * limit;
		RowBounds row = new RowBounds(startRow, limit);
		return SqlSession.selectList("Board.selectList" , null, row);
	}

	// 게시판 글쓰기
	public int insertBoard(Board vo) {
		return SqlSession.insert("Board.insertBoard", vo);
	}
	
	// 게시판 상세보기
	public Board detail(int boardNo) {
		return SqlSession.selectOne("Board.detail", boardNo);
	}

	// 조회수
	public int addReadCount(int boardNo) {
		return SqlSession.update("Board.addReadCount", boardNo);
		
	}
	
	public Board selectOne(int boardNo) {
		return SqlSession.selectOne("Board.selectOne", boardNo);
	}
	
	// 게시판 삭제
	public int delete(int boardNo) {
		return SqlSession.delete("Board.delete", boardNo);
	}

	// 게시글 수정
	public Object update(Board b) {
		return SqlSession.update("Board.update", b);
	}







}
