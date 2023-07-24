package com.spring.pet.review.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.review.ReviewVO;

@Repository
public class ReviewDAO {

	@Autowired
	private SqlSessionTemplate mybatis; // dataSource,Mapper 담고 있음

//	CRUD 기능의 메소드 구현
	// 글쓰기
	public void insertReview(ReviewVO vo) {
		System.out.println("===mybatis insertReview() 기능처리===");
		mybatis.insert("reviewDAO.insertReview", vo);
		System.out.println("===mybatis updHosStar() 기능처리===");
		mybatis.update("reviewDAO.updHosStar", vo);
		System.out.println("===mybatis updHosStar() 기능안료===");

	}

	// 글수정
	public void updateReview(ReviewVO vo) {
		System.out.println("===mybatis updateReview() 기능처리===");
		mybatis.update("reviewDAO.updateReview", vo);
	}

	// 글삭제(Delete)
	public void deleteReview(ReviewVO vo) {
		System.out.println("===mybatis deleteReview() 기능처리===");
		mybatis.delete("reviewDAO.deleteReview", vo);
	}

	// 글삭제(update)
	public void updateDelReview(ReviewVO vo) {
		System.out.println("===mybatis updateDelReview 기능처리===");
		mybatis.delete("reviewDAO.updateDelReview", vo);
	}

	// 글상세조회
	public ReviewVO getReview(ReviewVO vo) {
		System.out.println("===mybatis getReview() 기능처리===");
		System.out.println((ReviewVO) mybatis.selectOne("reviewDAO.getReview", vo));
		return (ReviewVO) mybatis.selectOne("reviewDAO.getReview", vo); // 한줄 데이터면 selectOne
	}

	// 글목록조회
	public List<ReviewVO> getReviewList(ReviewVO vo) {
		System.out.println("===mybatis getReviewList() 기능처리===");
		return mybatis.selectList("reviewDAO.getReviewList", vo); // 여러줄 데이터면 selectList
	}

	// 글 등록을 위한 정보불러오기
	public List<ReviewVO> getReserveInfo(ReviewVO vo) {
		System.out.println("===mybatis getReviewInfo() 기능처리===");
		System.out.println("===mybatis getReviewInfo() 기능처리===" + vo);
		return mybatis.selectList("reviewDAO.getReserveInfo", vo);

	}

	// 신고리뷰 반려처리
	public void updateReport_reject(ReviewVO vo) {
		System.out.println("===mybatis updateReport_reject() 기능처리===");
		int updao_rj = mybatis.update("reviewDAO.updateReport_reject", vo);
		System.out.println("updao_rj: " + updao_rj);
	}

	// 신고리뷰 삭제
	public void updateReport_delete(ReviewVO vo) {
		System.out.println("===mybatis updateReport_delete() 기능처리===");
		int updao_del = mybatis.update("reviewDAO.updateReport_delete", vo);
		System.out.println("updao_del: " + updao_del);
	}

	// 신고리뷰 조회
	public ReviewVO getReportReview1(ReviewVO vo) {
		System.out.println("===mybatis getReportReview1() 기능처리===");
		ReviewVO rr = mybatis.selectOne("reviewDAO.getReportReview1", vo); // 한줄 데이터면 selectOne
		System.out.println("rr: " + rr);
		return rr;
	}
	
	// 신고리뷰 상세보기 조회
	public ReviewVO getReport(ReviewVO vo) {
		System.out.println("===mybatis getReport() 기능처리===");
		ReviewVO rp = mybatis.selectOne("reviewDAO.getReport", vo); // 한줄 데이터면 selectOne
		System.out.println("rp: " + rp);
		return rp;
	}

	// 신고리뷰 전체목록 조회
	public List<ReviewVO> getReportList(ReviewVO vo) {
		System.out.println("===mybatis getReportList() 기능처리===");
		List<ReviewVO> rl = mybatis.selectList("reviewDAO.getReportList", vo); // 여러줄 데이터면 selectList

		for (ReviewVO v : rl) {
			System.out.println("v: " + v);
		}
		return rl;
	}

	public ReviewVO getRev(ReviewVO vo) {
		ReviewVO asdf = (ReviewVO) mybatis.selectOne("reviewDAO.getRev", vo);
		System.out.println("겟리뷰: "+asdf);
		return asdf;
	}

	public List<ReviewVO> getRevList(ReviewVO vo) {
		List<ReviewVO> asdf = mybatis.selectList("reviewDAO.getRevList", vo);
		System.out.println("리뷰리스트: "+asdf);
		return asdf;
	}
	
	//[전체유저]  리뷰검색
	public List<ReviewVO> getMyRevList(ReviewVO vo) {
		System.out.println("===mybatis getMyRevList() 기능처리===");
		return mybatis.selectList("reviewDAO.getMyRevList", vo); // 여러줄 데이터면 selectList
	}
	// [유저] 마이페이지 리뷰
	public List<ReviewVO> getMyReviewPostList(ReviewVO vo) {
		System.out.println("===mybatis getMyReviewPostList() 기능처리===");
		return mybatis.selectList("reviewDAO.getMyReviewPostList", vo); // 여러줄 데이터면 selectList
	}
	
	// [마이페이지]  리뷰검색
		public List<ReviewVO> searchMyRevList(ReviewVO vo) {
			System.out.println("===mybatis searchMyRevList() 기능처리===");
			return mybatis.selectList("reviewDAO.searchMyRevList", vo); // 여러줄 데이터면 selectList
		}
		// [병원]  리뷰검색
		public List<ReviewVO> searchHosRevList(ReviewVO vo) {
			System.out.println("===mybatis searchHosRevList() 기능처리===");
			return mybatis.selectList("reviewDAO.searchHosRevList", vo); // 여러줄 데이터면 selectList
		}
		
	//리뷰추천
		public int reviewUp(ReviewVO vo) {
			System.out.println("===mybatis reviewUp() 기능처리===");
			return mybatis.selectOne("reviewDAO.reviewUp", vo); 
		}
		//리뷰추천 삽입
		public int reviewUpInsert(ReviewVO vo) {
			System.out.println("===mybatis reviewUpInsert() 기능처리===");
			 mybatis.insert("reviewDAO.reviewUpInsert", vo); 
			 return mybatis.update("reviewDAO.reviewUpUpdate", vo); 
		}
		//리뷰추천 삽입
		public int reviewUpDelete(ReviewVO vo) {
			System.out.println("===mybatis reviewUpDelete() 기능처리===");
			mybatis.delete("reviewDAO.reviewUpDelete", vo); 
			return mybatis.update("reviewDAO.reviewUpUpdateDel", vo); 
		}

	//리뷰신고
		public int reportReviewHos(ReviewVO vo) {
			System.out.println("===mybatis reportReviewHos() 기능처리===");
			return mybatis.update("reviewDAO.reportReviewHos", vo);
		}
	
		
}
