package com.soon.chan.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.soon.chan.service.BoardService;
import com.soon.chan.vo.Board;

@Controller
@RequestMapping(value = "/board")
public class BoardCtrl {

	@Autowired
	private BoardService BoardService; 
	
	public static final int LIMIT = 10;
	
	// 게시판 리스트
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list(ModelAndView mv, @RequestParam(name = "page", defaultValue = "1") int page) {
	try {
		int listCount = BoardService.listCount(); // 게시판 리스트
		int currentPage = page; // 한 페이지당 출력할 목록 갯수
		int maxPage = (int) ((double) listCount / LIMIT + 0.9); // 페이징 처리
		ArrayList<Board> list = new ArrayList<Board>(BoardService.selectList(currentPage, LIMIT));
				
		mv.addObject("list", list);
		mv.addObject("listCount", listCount);
		mv.addObject("currentPage", currentPage);
		mv.addObject("maxPage", maxPage);
		mv.setViewName("board/list");
		
	}catch(Exception e) {
		e.printStackTrace();
		}
		return mv;
	}
	
	// 게시판 글쓰기 페이지로 이동
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		return "board/write";
	}
	
	// 게시판 글쓰기
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public ModelAndView insert(ModelAndView mv
			,@RequestParam("boardTitle") String boardTitle
			,@RequestParam("userId") String userId
			,@RequestParam("boardContent") String boardContent) {
		int result = 0;
		
		Board vo = new Board();
		vo.setBoardTitle(boardTitle);
		vo.setBoardId(userId);
		vo.setBoardContent(boardContent);
		result = BoardService.insertBoard(vo);
		
		try {
			if (result != 0) {
				mv.setViewName("redirect:list");
			} else {
				mv.addObject("msg", "글 등록 실패");
				mv.setViewName("errorPage");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage());
			mv.setViewName("errorPage");
		}
		return mv;
	}
	
	// 게시판 상세보기
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(@RequestParam(name = "boardNo") int boardNo, Model model) {
		Board boardCnt = BoardService.boardCnt(0, boardNo);
		model.addAttribute("boardCnt", boardCnt);
		
		Board b = BoardService.detail(boardNo);
		model.addAttribute("b", b);
		return "board/detail";
	}
	
	// 게시글 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ModelAndView delete(int boardNo, ModelAndView mv) {
		BoardService.delete(boardNo);
		mv.setViewName("redirect:list");
		return mv;
	}
	
	// 게시글 수정 페이지 이동
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(int boardNo, Model model) {
		Board b = BoardService.detail(boardNo);
		model.addAttribute("b", b);
		return "board/update";
	}
	
	// 게시글 수정
	@RequestMapping(value = "update2", method = RequestMethod.POST)
	public String update2(Board b) { // 게시글 수정
		BoardService.updateBoard(b);
		return "redirect:list";
	}
	
	// 추천 ajax
	@RequestMapping(value = "clickLike", method = RequestMethod.POST)
	@ResponseBody
	public int clickLike(@RequestParam("boardNo") int boardNo, @RequestParam("boardId") String boardId, ModelAndView mv) {
		int result = -1;
		int likecnt = 0;
		
		try {
			result = BoardService.checklike(boardNo, boardId); // 게시글 추천 여부검사
			if(result == 0) { // 게시글 추천
				BoardService.insertLike(boardNo, boardId);
			} else if(result == 1) { // 게시글 추천 취소
				BoardService.deleteLike(boardNo, boardId);
			} else {
			}
			likecnt = BoardService.likecnt(boardNo); // 총추천수
		} catch(Exception e) {
			e.printStackTrace();
		}
		return likecnt;
	}
	
}