package com.soon.chan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soon.chan.dao.BoardDao;
import com.soon.chan.vo.Board;

@Service("BoardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao BoardDao;

	// 게시판 리스트
	@Override
	public int listCount() {
		return BoardDao.listCount();
	}

	// 페이징처리
	@Override
	public List<Board> selectList(int currentPage, int limit) {
		List<Board> list = null;
		try{
			list = BoardDao.selectList(currentPage, limit);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 게시판 글쓰기
	@Override
	public int insertBoard(Board vo) {
		return BoardDao.insertBoard(vo);
	}

	// 게시판 상세보기
	@Override
	public Board detail(int boardNo) {
		return BoardDao.detail(boardNo);
	}

	// 조회수
	@Override
	public Board boardCnt(int i, int boardNo) {
		
		if(i == 0) {
			BoardDao.addReadCount(boardNo);
		}
		return BoardDao.selectOne(boardNo);
	}

	// 게시판 삭제
	@Override
	public void delete(int boardNo) {
		BoardDao.delete(boardNo);
	}

	// 게시글 수정
	@Override
	public void updateBoard(Board b) {
		BoardDao.update(b);
	}
	
}
