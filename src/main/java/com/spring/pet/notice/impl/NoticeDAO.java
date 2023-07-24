package com.spring.pet.notice.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.notice.NoticeVO;

@Repository("noticeDao")
public class NoticeDAO {

	@Autowired
	private SqlSessionTemplate noticeBatis;

	// 공지사항 등록
	public void insertNotice(NoticeVO vo) {
		System.out.println("다오다오 > insertNotice");
		noticeBatis.insert("noticeDAO.insertNotice", vo);
	}

	// 공지사항 수정
	public void updateNotice(NoticeVO vo) {
		System.out.println("다오다오 > updateNotice");
		noticeBatis.update("noticeDAO.updateNotice", vo);
	}

	// 공지사항 삭제
	public int deleteNotice(NoticeVO vo) {
		System.out.println("다오다오 > deleteNotice");
		return noticeBatis.update("noticeDAO.deleteNotice", vo);
	}

	// 공지사항 목록보기
	public List<NoticeVO> getNoticeList(NoticeVO vo) {
		System.out.println("다오다오 > getNoticeList");
//		System.out.println(noticeBatis.selectList("noticeDAO.getNoticeList", vo));
		return noticeBatis.selectList("noticeDAO.getNoticeList", vo);
	}

	// 공지사항 목록보기 (인덱스용)
	public List<NoticeVO> getNoticeList4Index(NoticeVO vo) {
		System.out.println("다오다오 > getNoticeList4Index");
		return noticeBatis.selectList("noticeDAO.getNoticeList4Index", vo);
	}

	// 공지사항 상세보기
	public NoticeVO getNoticeDetail(NoticeVO vo) {
		System.out.println("다오다오 > getNoticeDetail");
//		System.out.println("상세정보를 볼거야 :"+ (NoticeVO) noticeBatis.selectOne("noticeDAO.getNoticeDetail",vo));
		return (NoticeVO) noticeBatis.selectOne("noticeDAO.getNoticeDetail", vo);
	}

	// 공지사항 검색
	public List<NoticeVO> searchNoticeList(NoticeVO vo) {
		System.out.println("다오다오 > searchNoticeList");
		System.out.println("noticeSearch 검색한거뭐야? " + vo.getNoticeSearch());
		System.out.println("noticeSearchKeyword 검색한거뭐야? " + vo.getNoticeSearchKeyword());
		return noticeBatis.selectList("noticeDAO.searchNoticeList", vo);

	}

	// 조회수 카운팅
	public void noticeCnt(NoticeVO vo) {
		System.out.println("다오다오 > 조회수카운트");
		noticeBatis.update("noticeDAO.noticeCnt", vo);
	}

	// 글 목록 개수 가져오기
//	public int getNoticeCount(NoticeVO vo) {
//		System.out.println("다오다오 > 글 목록 개수가져오기");
////		System.out.println((String) noticeBatis.selectOne("noticeDAO.listCount", vo));
//		return noticeBatis.selectOne("noticeDAO.listCount", vo);
//	}

}
