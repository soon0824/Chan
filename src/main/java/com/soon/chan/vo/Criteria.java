package com.soon.chan.vo;

public class Criteria {
	private int page; // 보여줄 페이지 번호
	private int perPageNum; // 페이지당 보여줄 게시글의 개수
	
	public Criteria() {
		// 최초 게시판에 진입할 때를 위해서 기본 값을 설정 행 ㅑ한다.
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
}
