package com.spring.pet.faq.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.pet.faq.FaqVO;

@Repository("faqDao")
public class FaqDAO {
	
	@Autowired
	private SqlSessionTemplate faqBatis;
	
	// 자주묻는질문 등록
	public void insertFAQ(FaqVO vo) {
		System.out.println("faq다오 > insertFAQ");
		faqBatis.insert("faqDAO.insertFaq", vo);
	}

	// 자주묻는질문 수정
	public void updateFAQ(FaqVO vo) {
		System.out.println("faq다오 > updateFAQ");
		faqBatis.update("faqDAO.updateFaq", vo);
	}

		// 자주묻는질문 삭제
	public void deleteFAQ(FaqVO vo) {
		System.out.println("faq다오 > deleteFAQ");
		faqBatis.update("faqDAO.deleteFaq", vo);
	}
		
	// 자주묻는질문 한 개만 가져오기
	public FaqVO getFaq(FaqVO vo) {
		System.out.println("faq다오 > get 한개만");
		return faqBatis.selectOne("faqDAO.getFaq", vo);
	}

	// 자주묻는질문 목록 가져오기
	public List<FaqVO> getFaqList(FaqVO vo) {
		System.out.println("목록가져오기");
		
		if (vo.getFaq_cate_btn() == null || vo.getFaq_cate_btn().equals("null")) {
			System.out.println("faq바티스 > get all");
			System.out.println("vo.getFaq_cate_btn 1" + vo.getFaq_cate_btn());
			return faqBatis.selectList("faqDAO.getFaqAll", vo);
		} else {
			System.out.println("faq바티스 > getList(검색)");
			System.out.println("vo.getFaq_cate_btn 2" + vo.getFaq_cate_btn());
			return faqBatis.selectList("faqDAO.getFaqList", vo);
		}
	}
	
	public List<FaqVO> getFaqSearchList(FaqVO vo){
		System.out.println("검색목록가져오기");
		
		return faqBatis.selectList("faqDAO.getFaqSearch", vo);
	}
	
	// 자주묻는질문 개수 가져오기
	public int getFaqCount(FaqVO vo) {
		System.out.println("faq바티스 > 개수가져와라");
		return faqBatis.selectOne("faqDAO.listCount", vo);
	}
}
