package com.synergy.socdoc.mypage.service;

import java.util.HashMap;
import java.util.List;

import com.synergy.socdoc.member.QnaBoardVO;

public interface InterMyPageService {

	int getTotalCount(HashMap<String, String> paraMap);  // 총 게시물 건수(totalCount)를 구하기(검색이 있을때와 검색이 없을때로 나뉜다.)

	List<QnaBoardVO> boardListSearchWithPaging(HashMap<String, String> paraMap);  // 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한것)

	QnaBoardVO getView(String qnaSeq, String userid); // 글조회수 증가와 함께 글1개를 조회를 해주는 것 

	QnaBoardVO getViewWithNoAddCount(String qnaSeq); // 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.

	int del(HashMap<String, String> paraMap) throws Throwable; // 1개글 삭제하기 
	
	


}
