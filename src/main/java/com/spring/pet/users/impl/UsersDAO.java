package com.spring.pet.users.impl;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.review.ReviewVO;
import com.spring.pet.users.AdminUserReserveVO;
import com.spring.pet.users.UsersVO;

@Repository
public class UsersDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	//로그인
	public UsersVO getUsers(UsersVO vo) {
		 System.out.println("===mybatis getUsers() 기능처리===");
		 return mybatis.selectOne("UsersDAO.getUsers", vo);
	}
	//내정보조회
	public UsersVO getUserInfo(UsersVO vo) {
		System.out.println("===mybatis getUserInfo() 기능처리===");
		return mybatis.selectOne("UsersDAO.getUserInfo", vo);
	}
	
	public UsersVO getUserInfoByEmail(UsersVO vo) {
		return mybatis.selectOne("UsersDAO.getUserInfoByEmail", vo);
	}
	
	//회원가입
	public void insertUser(UsersVO vo) {
		System.out.println("===> mybatis insertUser() 기능처리");
		mybatis.insert("UsersDAO.insertUser", vo);
	}
    
	//아이디 중복체크
		public UsersVO getId(UsersVO vo) {
				System.out.println("vo.getId:" + vo.getUsers_id());
				System.out.println("vo : " + vo);
				return mybatis.selectOne("UsersDAO.checkId", vo);
		}
	
		public UsersVO checkDupPhone(UsersVO vo) {
			return mybatis.selectOne("UsersDAO.checkPhone", vo);
		}

		public UsersVO checkDupEmail(UsersVO vo) {
			return mybatis.selectOne("UsersDAO.checkEmail", vo);
		}

	//마이페이지 정보 수정(주소, 이메일, 전화번호)
	public int updateInfo(UsersVO vo) {
		System.out.println("===>mybatis로 updateInfo() 기능처리");
		return mybatis.update("UsersDAO.updateInfo",vo);
	}
	
	public int updateInfoPassword(UsersVO vo) {
		return mybatis.update("UsersDAO.updateInfoPassword",vo);
	}
	
	//마이페이지 탈퇴
	public int deleteUser(UsersVO vo) {
		System.out.println("===>mybatis로 deleteUser() 기능처리");
		return mybatis.delete("UsersDAO.deleteUser", vo);
	}
	
	//[관리자] 회원리스트 카운트 페이징 처리
		public int userListCount(UsersVO vo) {
			System.out.println("DAO의 userCount 진행");
			return mybatis.selectOne("UsersDAO.userListCount",vo);
		}
		
		
		//[관리자] 회원리스트
		public List<UsersVO> getUserList(UsersVO vo) {
			System.out.println("DAO의 getUserList 실행");
			return mybatis.selectList("UsersDAO.userList",vo);
		}
		
		
		//[관리자] 회원상세보기
		public UsersVO getUserDtail(UsersVO vo) {
			System.out.println("DAO의 getUserDtail 실행");
			return mybatis.selectOne("UsersDAO.userDtail",vo);
		}
		
		//[관리자] 회원 정보 수정
		public int userUpdate(UsersVO vo) {
			System.out.println("DAO의 userUpdate 실행");
			return mybatis.update("UsersDAO.userUpdate",vo);
		}
		
		
		//[관리자] 회원 찜목록 가져오기
		public List<AdminUserReserveVO> getUserZzim(UsersVO vo){
			System.out.println("DAO의 getUserZzim 실행");
			return mybatis.selectList("reserveDAO.getUserZzim",vo);
		}
		
		
		//[관리자] 특정 회원 예약목록 가져오기
		public List<ReserveVO> adminUserReserve(UsersVO vo){
			System.out.println("DAO의 adminUserReserve 실행");
			return mybatis.selectList("reserveDAO.getAdminUserReserve", vo);
		}
		
		//[관리자] 특정 회원 예약 목록 갯수 가져오기
		public int adminUserReserveListCount(UsersVO vo) {
			System.out.println("DAO의 adminUserReserveListCount 메소드 실행");
			return mybatis.selectOne("reserveDAO.adminUserReserveListCount",vo);
		}
		
		
		//[관리자] 특정 회원 리뷰 내역 가져오기
		public List<ReviewVO> adminUserReview(UsersVO vo){
			System.out.println("DAO의 adminUserReview 메소드 실행");
			return mybatis.selectList("reviewDAO.adminUserReview", vo);
		}
		
		//[관리자] 특정 회원 리뷰 갯수 가져오기
		public int adminUserReviewListCount(UsersVO vo) {
			System.out.println("DAO의 adminUserReviewListCount 메소드 실행");
			return mybatis.selectOne("reviewDAO.adminUserReviewListCount",vo);
		}
		
		//[관리자] 회원상세보기에 가져올 예약 (※2차 통합 후 수정)
				public List<ReserveVO> getAdminUserDetailThree(UsersVO vo){
					System.out.println("DAO의 getAdminUserDetailThree실행");
					return mybatis.selectList("reserveDAO.getAdminUserDetailThree", vo);
				}
						
				//[관리자] 회원상세보기에 가져올 취소예약 수 (※2차 통합 후 수정)
				public int adminUserReserveCancelListCount(UsersVO vo){
					System.out.println("DAO의 adminUserReserveCancelListCount실행");
					return mybatis.selectOne("reserveDAO.adminUserReserveCancelListCount", vo);
				}
		
	
		// [유저] 찜한 병원 정보들 가져오기
		public List<UsersVO> getUsersHos(UsersVO vo) {
			System.out.println("===mybatis getUsersHos() 기능처리 === 찜병원 가져와라");
//			return mybatis.selectOne("UsersDAO.getUsersHos", vo);
			return mybatis.selectList("UsersDAO.getUsersHos", vo);
		 }

		// [유저] 찜한 병원이름들 가져오기
		public List<UsersVO> getZzimHosName(UsersVO vo) {
			System.out.println("getZzimHosId 유저다오다오 > 유저가 찜한 병원들의 이름값을 가져온다");
			System.out.println("유저다오의 pick 아이디1 " + vo.getUsers_pick1());
			System.out.println("유저다오의 pick 아이디2 " + vo.getUsers_pick2());
			System.out.println("유저다오의 pick 아이디3 " + vo.getUsers_pick3());
			System.out.println("유저다오의 pick 아이디4 " + vo.getUsers_pick4());
			System.out.println("유저다오의 pick 아이디5 " + vo.getUsers_pick5());
			return mybatis.selectList("UsersDAO.getZzimHosName", vo);
//			return mybatis.selectOne("UsersDAO.getZzimHosName", vo);
		}
		
		// [유저] 찜병원 지우기
		public void delUsersZzim(UsersVO vo) {
			System.out.println("유저다오 > 찜 병원 지우기");
		  	System.out.println("1 병원 지울 회원아이디: " + vo.getUsers_id());	// test
		  	System.out.println("2 지울 병원 아이디: " + vo.getUsers_pick1());	// testhospital
		  	System.out.println("3 delzzim의 값: " + vo.getDelZzim());			// hos1
			mybatis.update("UsersDAO.delUsersZzim", vo);
		}
	
		public void userPick1(UsersVO vo){
			System.out.println("다오"+vo);
			mybatis.update("UsersDAO.pickHos1", vo);
		}
		public void userPick2(UsersVO vo){
			System.out.println("다오"+vo);
			mybatis.update("UsersDAO.pickHos2", vo);
		}
		public void userPick3(UsersVO vo){
			System.out.println("다오"+vo);
			mybatis.update("UsersDAO.pickHos3", vo);
		}
		public void userPick4(UsersVO vo){
			System.out.println("다오"+vo);
			mybatis.update("UsersDAO.pickHos4", vo);
		}
		public void userPick5(UsersVO vo){
			System.out.println("다오"+vo);
			mybatis.update("UsersDAO.pickHos5", vo);
		}
		
		//db비밀번호, 입력 비밀번호 매칭
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
		// [유저] 마이페이지 메인페이지		
		public UsersVO getUserMyPage(UsersVO vo) {
			System.out.println("getUserMyPage DAO");
			return mybatis.selectOne("UsersDAO.getUserMyPage",vo);
		}
		
		// [유저] 찜병원 데이터만 가져오기 (개수세는용도)
				public UsersVO zzimCnt(UsersVO vo) {
					return mybatis.selectOne("UsersDAO.zzimcnt", vo);
				}
		public UsersVO checkDupPhone1(UsersVO vo) {
					return mybatis.selectOne("UsersDAO.checkPhone1", vo);
				}	
}
