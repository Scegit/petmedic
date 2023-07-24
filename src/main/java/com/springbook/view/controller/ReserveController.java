package com.springbook.view.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.reserve.ReserveService;
import com.spring.pet.reserve.ReserveVO;

@Controller
@SessionAttributes("reserve")
public class ReserveController {

	@Autowired
	private ReserveService reserveService;

	@ModelAttribute("searchMap") // 컨트롤러를 탈 때마다 계속 생성되는 객체이다. request객체인데 밑에 url 타기전에 실행되어 객체생성
	public Map<String, String> searchConditionMap() {
		Map<String, String> searchMap = new HashMap<String, String>();
		System.out.println("searchMap: " + searchMap);
		searchMap.put("아이디", "RES_USERS_ID");
		searchMap.put("이름", "USERS_NAME");
		searchMap.put("연락처", "USERS_TEL");
		searchMap.put("병원명", "HOS_NAME");
		return searchMap;
	}

	

	// [관리자] 예약 취소
	@RequestMapping("/updateReserve_rcc")
	public String updateReserve_rcc(@ModelAttribute("reserve") ReserveVO vo, HttpSession session, Model model) {
		System.out.println("uprcc : " + vo);
		reserveService.updateReserve_rcc(vo);
		model.addAttribute("reserve", reserveService.getReserve(vo));
		return "reserve/getReserve";
	}

	// [회원] 나의 예약 취소
	   @RequestMapping("/cancelMyReserve")
	   public String cancelMyReserve(ReserveVO vo, Model model) {
	      System.out.println(vo.getRes_seq() + " 번 데이터를 취소할거야");
	      reserveService.cancelReserve(vo);
	      model.addAttribute("reserve", reserveService.getReserve(vo));
	      return "userMyPage/myActionReserve";
	   }

	// [관리자] 회원예약 상세 조회
	@RequestMapping("/getReserve")
	public String getReserve(ReserveVO vo, Model model, HospitalVO hvo, HttpSession session) {
		System.out.println("예약 상세 조회 처리");

		model.addAttribute("reserve", reserveService.getReserve(vo));

		if (session.getAttribute("users_role").equals("ADMIN") || session.getAttribute("users_role").equals("SUPERADMIN")) {
			return "/reserve/getReserve";
		} else {
			hvo.setHos_id(vo.getRes_hos_id());
			HospitalVO rvp1 = reserveService.reservation_page(hvo);
			model.addAttribute("hospital", rvp1);
			model.addAttribute("hos_start", hvo.getHos_start());
			model.addAttribute("hos_end", hvo.getHos_end());
			model.addAttribute("hos_s_lunch", hvo.getHos_s_lunch());
			model.addAttribute("hos_e_lunch", hvo.getHos_e_lunch());
			model.addAttribute("hos_hol", hvo.getHos_hol());
			return "/reserve/getReserve";
		}
//		return "reserve/getReserve";
	}
	
	  // [관리자] 예약 상세 조회
	   @RequestMapping("/getAllReserve")
	   public String getAllReserve(ReserveVO vo, Model model) {
	      System.out.println("예약 상세 조회 처리");

	      model.addAttribute("reserve", reserveService.getReserve(vo));
	      return "/reserve/getReserve";
	   }


	// 예약 목록
	@RequestMapping("/getReserveList")
	public String getReserveListPost(ReserveVO vo, Model model) {
		System.out.println("예약 목록 검색 처리");

		// 리스트 받아오는 것
		model.addAttribute("reserveList", reserveService.getReserveList(vo));

		// 리스트 페이징 처리
		String rvl = new Gson().toJson(reserveService.getReserveList(vo));
		model.addAttribute("rvl", rvl);

		// 검색 받아오는 것
		model.addAttribute("searchCondition", vo.getSearchCondition());

		return "reserve/getReserveList";
	}

	// [회원] 나의 예약목록을 가져오기
	@RequestMapping("/getMyReserve")
	@ResponseBody
	public List<ReserveVO> getMyReserve(ReserveVO vo) {
		System.out.println("내 예약목록 가져오기 컨트롤러");
		System.out.println("아이디: " + vo.getRes_users_id());
		
		List<ReserveVO> rvo = reserveService.myReserveList(vo);
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//
//		for (ReserveVO reserveVO : rvo) {
//		    Date resDate = reserveVO.getRes_date();
//		    String formattedResDate = sdf.format(resDate);
//		    System.out.println("formattedResDate" + formattedResDate);
//		    vo.setResDateAsFormattedString(formattedResDate);
//		    System.out.println("vo.getres_date" + reserveVO.getRes_date());
//		    
//		    Date resCashDate = reserveVO.getRes_cashdate();
//		    String formattedResCashDate = sdf.format(resCashDate);
//		    vo.setResCashDateAsFormattedString(formattedResCashDate);
//		}
	    
		System.out.println("vo.getRes_cashdate" + vo.getRes_cashdate());
		
		return rvo;
//		return reserveService.myReserveList(vo);
	}
	// [회원] 나의 예약목록을 필터
	@RequestMapping("/reserveFilter")
	@ResponseBody
	public List<ReserveVO> reserveFilter(ReserveVO vo) {
		System.out.println("내 예약목록 가져오기 컨트롤러");
		System.out.println("아이디: " + vo.getRes_users_id());
		
		List<ReserveVO> rvof = reserveService.reserveFilter(vo);
		System.out.println("vo.getRes_cashdate" + vo.getRes_cashdate());
		
		return rvof;
	}
	
	//예약하기
		@RequestMapping("/insertreserve")
		public String insertReserve(ReserveVO vo) throws ParseException {
			System.out.println("insertreserve 영역: " + vo.getRes_date()); 
			 // 문자열
	        String dateStr = vo.getRes_date_temp();
	 
	        // 포맷터
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	 
	        // 문자열 -> Date
	        Date date = formatter.parse(dateStr);
			vo.setRes_date(date);
		if(	reserveService.insertReserve(vo) >0) {
			return "redirect:index.jsp";
		}else
			return "hospital/index"; // 일단 해놓은거임
		}
 
		// [회원] 예약상세내역 가져오기
		   @RequestMapping("/myReserveDOne")
		   @ResponseBody
		   public ReserveVO myReserveDOne(ReserveVO vo, Model model) {
		      System.out.println("내거 예약 하나만 가져올건데... ");
		      model.addAttribute("myResrvLst", reserveService.myReserveDOne(vo));
		      return reserveService.myReserveDOne(vo);
		   }	
		   
		// [회원] 나의 예약목록을 가져오기
		   @RequestMapping("/myReserveDATE")
		   @ResponseBody
		   public List<ReserveVO> myReserveDATE(ReserveVO vo, Model model) {
		      System.out.println("내 예약목록 가져오기 컨트롤러");
		      System.out.println("아이디: " + vo.getRes_users_id());
		      
		      List<ReserveVO> rvo = reserveService.myReserveDATE(vo);
		      System.out.println("vo.getRes_cashdate" + vo.getRes_cashdate());
		      return rvo;
		   }	   
}
