package com.springbook.view.controller;

import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.pet.faq.FaqService;
import com.spring.pet.faq.FaqVO;

@Controller
public class FaqController {

	@Autowired @Qualifier("faqService")
	public FaqService faqService;
	
	// [관리자] 자주묻는질문 등록
	@RequestMapping("/insertFAQ")
	public String insertFAQ(FaqVO vo) {
		System.out.println("FAQ insert 컨트롤러 시작");
		String faq_cont = vo.getFaq_cont();
		faq_cont = faq_cont.replace("\r\n","<br>");
		vo.setFaq_cont(faq_cont);
		faqService.insertFAQ(vo);
		System.out.println("FAQ insert 컨트롤러 끗");
		return "faq/getFaqList_admin";
	}

	// [관리자] 수정페이지로 보내줘
	@RequestMapping("/updateFAQ")
	public String updateFAQForm(FaqVO vo, Model model) {
		System.out.println("업데이트 폼으로 나를 보내줘");
		System.out.println("내 데이터좀 가져와줘");
		
		vo = faqService.getFaq(vo);
	    String faq_cont = vo.getFaq_cont();
	    faq_cont = faq_cont.replace("<br>","\r\n");
	    vo.setFaq_cont(faq_cont);
		model.addAttribute("faqList", vo);
		
		return "faq/updateFAQ";
	}
	
	// [관리자] 자주묻는질문 수정
	@RequestMapping("/modiFAQ")
	public String updateFAQ(FaqVO vo) {
		System.out.println("FAQ update 컨트롤러 시작");
		System.out.println("몇번 글을 수정할거니? " + vo.getFaq_int());
		String faq_cont = vo.getFaq_cont();
		faq_cont = faq_cont.replace("\r\n","<br>");
		vo.setFaq_cont(faq_cont);
		faqService.updateFAQ(vo);
		System.out.println("vo.get타이틀 변경후: " + vo.getFaq_title());
		System.out.println("FAQ update 컨트롤러 끗");
		return "/faq/getFaqList_admin";
	}

	// [관리자] 자주묻는질문 삭제
	@RequestMapping("/deleteFAQ")
	public String deleteFAQ(FaqVO vo) {
		System.out.println("FAQ delete 컨트롤러 시작");	
		System.out.println("몇번 글을 삭제할거니? " + vo.getFaq_int());
		faqService.deleteFAQ(vo);
		System.out.println("FAQ delete 컨트롤러 끗");
		return "/faq/getFaqList_admin";
	}
	
	// [공통] 자주묻는질문 리스트 가져오기
	@RequestMapping("/getFaqList")
	@ResponseBody
	public List<FaqVO> getFaqList(FaqVO vo, Model model){
//	public String getFaqList(FaqVO vo, Model model){
		System.out.println("FAQ getFaqList 컨트롤러 시작");
		System.out.println("faq_cate_btn ? " + vo.getFaq_cate_btn());
		System.out.println("FaqSearch 셀렉트박스 선택값: " + vo.getFaqSearch());
		System.out.println("Faq 입력한 검색어: " + vo.getFaqSearchKeyword());
//		faqSearch, faqSearchKeyword
		
		if (vo.getFaqSearch() == null) {
			model.addAttribute("faqList", faqService.getFaqList(vo));
			System.out.println("model에 있니? " + model.getAttribute("faqList"));
			System.out.println("FAQ getFaqList 컨트롤러 끗");
			return faqService.getFaqList(vo);
		} else {
			System.out.println("으아아아아아아아아앙 검색faq");
			model.addAttribute("faqList", faqService.getFaqSearchList(vo));
			return faqService.getFaqSearchList(vo);
		}
	}
	
	// [공통] getFaqList으로 이동
	@RequestMapping("/togetFaqList")
	public String toFaq_list_wrap(FaqVO vo) {
		System.out.println("와라");
		
			return "/faq/getFaqList";
	}
	
	// [관리자] getFaqList_admin으로 이동
	@RequestMapping("/togetFaqListAdmin")
	public String toFaq_list_wrap_admin(FaqVO vo) {
		return "/faq/getFaqList_admin";
	}
	
	// [관리자] insertFAQ으로 이동
	@RequestMapping("/toInsertFAQ")
	public String toInsertFAQ(FaqVO vo, HttpSession session) {
		
//		if((session.getAttribute("users_id")==null)||!(session.getAttribute("users_role").equals("관리자"))) {
//			System.out.println(session.getAttribute("users_role"));
//			System.out.println("어드민이 아니다이거야");
//			return "redirect:/index.jsp";
//		} else if (session.getAttribute("users_role").equals("관리자")){
//			System.out.println(session.getAttribute("users_role"));
//			System.out.println("어드민 가보자고");
			return "/faq/insertFAQ";
//		} else {
//			return "redirect:/index.jsp";
//		}
	}
	   
}
