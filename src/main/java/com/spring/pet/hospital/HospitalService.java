package com.spring.pet.hospital;

import java.util.List;

import com.spring.pet.date.DateVO;
import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.review.ReviewVO;

public interface HospitalService {

	//병원목록조회
	List<HospitalVO> getHospitalList(HospitalVO vo);
	
	
	
	//병원검색
	List<HospitalVO> searchHospitalList(HospitalVO vo);
	
	//병원정보검색
	List<HospitalVO> getHosList(HospitalVO vo);
	
	//병원정보
	HospitalVO getHos(HospitalVO vo);
	
	//검색 병원상세로
	HospitalVO getHosInfo(HospitalVO vo);
	
	//병원회원삭제(update)
	void delHos(HospitalVO vo);

	 //CRUD 기능의 메소드 구현
	//병원 정보등록
	void insertHospital(HospitalVO hosvo);

	//병원 정보수정
	void updateHospital(HospitalVO hosvo);

	//병원 정보 1차삭제
	void deletewaitingHospital(HospitalVO hosvo);
	
	//병원 정보완전삭제
	void deleteHospital(HospitalVO hosvo);

	//병원 상세조회
	HospitalVO getHospital(HospitalVO hosvo);

	//관리자의 요청된 병원승인
    void checkHospital(HospitalVO hosvo);
    
	   //승인요청한 병원목록
    List<HospitalVO> requestHospitalList(HospitalVO hosvo);
    
    //승인요청한 병원상세
    HospitalVO requestHospital(HospitalVO hosvo);
    
    //병원로그인
    String hashedChk(String password);
    
    boolean pwMatchChk(String chkPassword, String password);
    
    HospitalVO gethosInfo1(HospitalVO vo);
    
  //[유저] 병원목록검색
  	List<HospitalVO> getHosListUser(HospitalVO vo);
  	
 // 별점높은 병원 가져오기	
 		 List<HospitalVO> revHighStar(HospitalVO vo);
 // 리뷰많은 병원 가져오기	
 		 List<HospitalVO> getManyRevHos(HospitalVO vo);
 		 
 // 승인된 병원 전체목록 가져오기			 
 		 List<HospitalVO> ListHosUser(HospitalVO vo);
 	
 	HospitalVO getId(HospitalVO vo);
 	 
 	HospitalVO checkDupPhone(HospitalVO vo);
 	
 	  List<HospitalVO> getAllLocations(HospitalVO vo);
 	  
 	// 20230519 - 관리자 메인 최신 병원 가입 현황
 		public List<HospitalVO> adminMainRecentJoinHospital();

 		// 20230519 - 관리자 메인 병원 가입 현황(당 월 정보 가져오기)
 		public DateVO intoCurrentMonth(String vo);

 		// 20230519 - 관리자 메인 병원 가입 현황(당 월 가입 개수 정보 가져오기)
 		public DateVO weeksum(DateVO vo);

 		// 20230519 - 관리자 메인 병원 가입 현황(당 월 예약 개수 정보 가져오기)
 		public List<DateVO> reserveWeeksum(DateVO vo);  
 		
 		HospitalVO checkDupPhone1(HospitalVO vo);
  
 
}
