package com.spring.pet.hospital.impl;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.date.DateVO;
import com.spring.pet.hospital.HospitalVO;

@Repository
public class HospitalDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 병원목록조회
	public List<HospitalVO> getHospitalList(HospitalVO vo) {
		System.out.println("===mybatis getHospitalList() 기능처리===");
		return mybatis.selectList("hospitalDAO.getHospitalList", vo);
	}

	// 병원검색
	public List<HospitalVO> searchHospitalList(HospitalVO vo) {
		System.out.println("===mybatis getHospitalList() 기능처리===");
		return mybatis.selectList("hospitalDAO.searchHospitalList", vo);
	}

	public HospitalVO getHos(HospitalVO vo) {
		HospitalVO asdf = (HospitalVO) mybatis.selectOne("hospitalDAO.getHos", vo);
		System.out.println("DAO안의 getHos 메소드: " + asdf);
		return asdf;
	}

	public HospitalVO getHosInfo(HospitalVO vo) {
		HospitalVO hos = (HospitalVO) mybatis.selectOne("hospitalDAO.getHosInfo", vo);
		System.out.println("DAO안의 getHosInfo 메소드: " + hos);
		return hos;
	}

	public List<HospitalVO> getHosList(HospitalVO vo) {
		System.out.println("DAO안의 getHosList 메소");
		return mybatis.selectList("hospitalDAO.getHosList", vo);

	}
	//병원삭제
	public void delHos(HospitalVO vo) {
		mybatis.update("hospitalDAO.delHos", vo);
		System.out.println("DAO안의 delHos 메소드: ");
	}

	// 병원추가등록
	public void insertHospital(HospitalVO hosvo) {
		System.out.println("===>mybatis로 inserthospital() 작동");
		System.out.println(hosvo);
		mybatis.insert("hospitalDAO.insertHospital", hosvo);

	}

	// 승인요청한 병원목록
	public List<HospitalVO> requestHospitalList(HospitalVO hosvo) {
		System.out.println("===>mybatis로 requesthospitalList() 작동");
		System.out.println(hosvo); // 데이터를 잘받아오는지 확인하기 위한 출력
		return mybatis.selectList("hospitalDAO.requestHospitalList", hosvo);
	}

	// 승인요청한 병원상세
	public HospitalVO requestHospital(HospitalVO hosvo) {
		System.out.println("===>mybatis로 requestHospital() 작동");
		return mybatis.selectOne("hospitalDAO.requestHospital", hosvo);
	}

	// 병원승인하기
	public void checkHospital(HospitalVO hosvo) {
		System.out.println("===>mybatis로 checkhospital() 작동");
		mybatis.update("hospitalDAO.checkHospital", hosvo);
	}

	// 병원수정
	public void updateHospital(HospitalVO hosvo) {
		System.out.println("===>mybatis로 updatehospital() 작동");
		mybatis.update("hospitalDAO.updateHospital", hosvo);

	}

	// 병원정보 1차삭제
	public void deletewaitingHospital(HospitalVO hosvo) {
		System.out.println("===>mybatis로 deletewaitinghospital() 작동");
		mybatis.update("hospitalDAO.deletewaitingHospital", hosvo);

	}

	// 병원정보 완전삭제
	public void deleteHospital(HospitalVO hosvo) {
		System.out.println("===>mybatis로 deletehospital() 작동");
		mybatis.delete("hospitalDAO.deleteHospital", hosvo);

	}

	// 병원 보기
	public HospitalVO getHospital(HospitalVO hosvo) {
		System.out.println("===>mybatis로 getHospital() 작동");
		return (HospitalVO) mybatis.selectOne("hospitalDAO.getHospital", hosvo);

	}
	
	//병원로그인
	   public HospitalVO gethosInfo1(HospitalVO vo) {
		      System.out.println("===mybatis gethosInfo1() 기능처리===");
		      return mybatis.selectOne("hospitalDAO.getHosInfo1", vo);
		   }

		   boolean pwMatchChk(String chkPassword, String password) {
		      System.out.println("db비밀번호, 입력 비밀번호 매칭");

		      System.out.println("chkPassword : " + chkPassword);
		      System.out.println("password : " + password);
		      boolean chkMatch = false;

		      if (chkPassword != null && password != null) {
		         chkMatch = BCrypt.checkpw(chkPassword, password);
		      }
		      return chkMatch;
		   }

		   //비밀번호 암호화
		   String hashedChk(String password) {
		      System.out.println("비밀번호 암호화 매칭확인");

		      String passwordHashed = BCrypt.hashpw(password, BCrypt.gensalt());
		      boolean isValidPassword = BCrypt.checkpw(password, passwordHashed);

		      if (isValidPassword) {
		         return passwordHashed;
		      } else {
		         return null;
		      }

		   }

		// [유저] 병원목록조회
			public List<HospitalVO> getHosListUser(HospitalVO vo) {
				System.out.println("===mybatis getHosListUser() 기능처리===");
				return mybatis.selectList("hospitalDAO.getHosListUser", vo);
			}
			// [메인] 별점순
			public List<HospitalVO> revHighStar(HospitalVO vo) {
				System.out.println("===mybatis revHighStar() 기능처리===");
				return mybatis.selectList("hospitalDAO.revHighStar", vo);
			}
			// [메인] 리뷰순
			public List<HospitalVO> getManyRevHos(HospitalVO vo) {
				System.out.println("===mybatis getManyRevHos() 기능처리===");
				return mybatis.selectList("hospitalDAO.getManyRevHos", vo);
			}
			// 전체목록 가져오기		
			public List<HospitalVO> ListHosUser(HospitalVO vo) {
				System.out.println("===mybatis ListHosUser() 기능처리===");
				return mybatis.selectList("hospitalDAO.ListHosUser", vo);
			}
	
			public HospitalVO checkDupPhone(HospitalVO vo) {
				return mybatis.selectOne("hospitalDAO.checkPhone", vo);
			}
		   
		   public HospitalVO getId(HospitalVO vo) {
				return mybatis.selectOne("hospitalDAO.checkId", vo);
		   }
		   
		   //맵검색
		   public List<HospitalVO> getAllLocations(HospitalVO vo) {
		        return mybatis.selectList("hospitalDAO.getAllLocations", vo);
		    }

		   
		// 20230519 - 관리자 메인 최신 병원 가입 현황
			public List<HospitalVO> adminMainRecentJoinHospital() {
				return mybatis.selectList("hospitalDAO.adminMainRecentJoinHospital");
			}

			// 20230519 - 관리자 메인 병원 가입 현황(당 월 정보 가져오기)
			public DateVO intoCurrentMonth(String vo) {
				return mybatis.selectOne("dateDAO.intoCurrentMonth", vo);
			}

			// 20230519 - 관리자 메인 병원 가입 현황(당 월 가입 개수 정보 가져오기)
			public DateVO weeksum(DateVO vo) {
				return mybatis.selectOne("dateDAO.weeksum", vo);
			}

			// 20230519 - 관리자 메인 병원 가입 현황(당 월 예약 개수 정보 가져오기)
			public List<DateVO> reserveWeeksum(DateVO vo) {
				List<HospitalVO> cateList = mybatis.selectList("dateDAO.hosCategory");
				List<DateVO> dateList = mybatis.selectList("dateDAO.reserveWeeksum", vo);
				return dateList;
			}   	

			public HospitalVO checkDupPhone1(HospitalVO vo) {
				return mybatis.selectOne("hospitalDAO.checkPhone1", vo);
			}	
}
