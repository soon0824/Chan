package com.soon.chan.service;

import java.util.List;
import com.soon.chan.vo.Board;

public interface BoardService {

	int listCount(); // 게시판리스트
	
	List<Board> selectList(int currentPage, int limit); // 페이징처리

	int insertBoard(Board vo); // 게시판 글쓰기

	Board detail(int boardNo); // 게시글 상세보기

	Board boardViews(int i, int boardNo); // 조회수

	void delete(int boardNo); // 게시글 삭제

	void updateBoard(Board b); // 게시글 수정

	int checklike(int boardNo, String boardId); // 게시글 추천 여부 검사

	int insertLike(int boardNo, String boardId); // 게시글 추천수

	int deleteLike(int boardNo, String boardId); // 게시글 추천 취소

	int likecnt(int boardNo); // 총 추천수


	
}
