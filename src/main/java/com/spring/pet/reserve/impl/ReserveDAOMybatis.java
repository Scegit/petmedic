package com.spring.pet.reserve.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.reserve.ReserveVO;

@Repository
public class ReserveDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis; // dataSource,Mapper 담고 있음

//	CRUD 기능의 메소드 구현

	// 예약 취소
	public void updateReserve_rcc(ReserveVO vo) {
		System.out.println("===mybatis updateReserve_rcc() 기능처리===");
		int updao_rcc = mybatis.update("reserveDAO.updateReserve_rcc", vo);
		System.out.println("updao_rcc: " + updao_rcc);
	}

	// 예약 수정
	public void updateReserve(ReserveVO vo) {
		System.out.println("===mybatis updateReserve() 기능처리===");
		int updao = mybatis.update("reserveDAO.updateReserve", vo);
		System.out.println("updao: " + updao);
	}

	// 예약페이지(병원정보 가져오기)
	public HospitalVO reservation_page(HospitalVO hvo) {
		System.out.println("===mybatis reservation_page() 기능처리===");
		HospitalVO rvp = mybatis.selectOne("reserveDAO.reservation_page", hvo);
		System.out.println("reservation_page: " + rvp);
		return rvp;
	}

	// 예약 상세조회
	public ReserveVO getReserve(ReserveVO vo) {
		System.out.println("===mybatis getReserve() 기능처리===");
		ReserveVO mk = mybatis.selectOne("reserveDAO.getReserve", vo); // 한줄 데이터면 selectOne
		System.out.println("mk: " + mk);
		return mk;
	}

	// 예약 목록조회
	public List<ReserveVO> getReserveList(ReserveVO vo) {
		System.out.println("===mybatis getReserveList() 기능처리===");
		List<ReserveVO> ml = mybatis.selectList("reserveDAO.getReserveList", vo); // 여러줄 데이터면 selectList

		for (ReserveVO v : ml) {
			System.out.println("v: " + v);
		}
		return ml;
	}

	// [회원] 나의 예약목록 가져오기
	public List<ReserveVO> myReserveList(ReserveVO vo) {
		System.out.println("리절브다오다오다오다오다오다오다오");
		System.out.println("예약목록 가져올 아이디" + vo.getRes_users_id());
		return mybatis.selectList("reserveDAO.myReserveList", vo);
	}

	// [회원] 나의 예약 취소하기
	public void cancelReserve(ReserveVO vo) {
		System.out.println("리절브다오 > 예약취소할 번호 : " + vo.getRes_seq());
		mybatis.update("reserveDAO.cancelMyReserve", vo);
	}

	//예약하기
	public int insertReserve(ReserveVO vo) {
		return mybatis.insert("reserveDAO.insertReserve", vo);
	}
	
	// [회원] 나의 예약목록 필터
		public List<ReserveVO> reserveFilter(ReserveVO vo) {
			System.out.println("리절브다오다오다오다오다오다오다오");
			System.out.println("예약목록 가져올 아이디" + vo.getRes_users_id());
			return mybatis.selectList("reserveDAO.reserveFilter", vo);
		}
		
		public List<ReserveVO> getResList(ReserveVO vo) {
			List<ReserveVO> asdf = mybatis.selectList("reserveDAO.getResList", vo);
			System.out.println("예약다오 예약리스트: "+asdf);
			return asdf;
		}	
	
		// 예약횟수로 베스트 병원 가져오기 (인덱스용)   
		   public List<ReserveVO> getBestHospital(ReserveVO vo){
		      System.out.println("베스트병원을 DAO");
		      return mybatis.selectList("reserveDAO.getBestHospital", vo);
		   }	
		   
		// 20230519 - 관리자 메인페이지 최근 병원 예약 현황
			public List<ReserveVO> adminRecentReserveHospital() {
				return mybatis.selectList("reserveDAO.adminRecentReserveHospital");
			}
			// [회원] 나의 예약목록 기간으로 가져오기
			   public List<ReserveVO> myReserveDATE(ReserveVO vo) {
			      System.out.println("리절브다오다오다오다오다오다오다오");
			      System.out.println("예약목록 가져올 아이디" + vo.getRes_users_id());
			      return mybatis.selectList("reserveDAO.myReserveDATE", vo);
			   }
			   
			// 예약상세내역 1개만 가져오기 
			   public ReserveVO myReserveDOne(ReserveVO vo) {
			      return mybatis.selectOne("reserveDAO.myReserveDOne", vo);
			   }
			   	   
}
