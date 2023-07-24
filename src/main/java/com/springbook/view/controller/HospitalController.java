package com.springbook.view.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.http.HttpRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.spring.pet.commons.PageInfo;
import com.spring.pet.doctor.DoctorService;
import com.spring.pet.doctor.DoctorVO;
import com.spring.pet.hospital.HospitalService;
import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.reserve.ReserveService;
import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.review.ReviewService;
import com.spring.pet.review.ReviewVO;
import com.spring.pet.users.PhoneService;
import com.spring.pet.users.UsersService;
import com.spring.pet.users.UsersVO;

@Controller
@SessionAttributes("hos")
public class HospitalController {

	@Autowired
	private UsersService userService;

	@Autowired
	private ReviewService revService;

	@Autowired
	private HospitalService hospitalService;

	@Autowired
	private DoctorService doctorService;
	
	@Autowired
	private ReserveService reserveService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private PhoneService phoneService;

	int pageSize = 10; // 한 페이지에 가져올 리스트 수
	int total = 0; // 가져올 리스트 초기값
	int totalPage = 1; // 페이지 기본 값

	@ModelAttribute("conditionMap") // 컨트롤러를 탈 때마다 계속 생성되는 객체이다. request객체인데 밑에 url 타기전에 실행되어 객체생성
	public Map<String, String> searchConditionMap() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("카테고리명", "CATEGORY");
		conditionMap.put("지역명", "LOCATION");
		conditionMap.put("의사명", "DOCTOR");
		conditionMap.put("병원명", "HOSPITAL");
		return conditionMap;
	}

//병원 검색 페이지로 이동
	@RequestMapping("/searchHospitalList")
	public String searchHospitalList(HospitalVO vo, Model model) {
		System.out.println("병원 검색 처리");
		return "/search/getSearchHosList";
	}
//병원 검색 페이지로 이동
	@RequestMapping("/ListHosUser")
	public String ListHosUser(HospitalVO vo, Model model) {
		System.out.println("병원 검색 처리");
		model.addAttribute("hospital", hospitalService.ListHosUser(vo));
		return "/hospital/getHosListUser";
	}

//병원들 검색으로이동
	@RequestMapping("/getHosList")
	@ResponseBody
	public List<HospitalVO> getHosList(HospitalVO vo) {
		System.out.println("병원 검색데이터 처리");
		return hospitalService.getHosList(vo);
	}

	// 병원 상세페이지 메인
	@RequestMapping("/getHos")
	public String getHos(HospitalVO vo, Model model, HttpSession session) {
		System.out.println("아이디: " + session.getAttribute("users_id"));
		System.out.println("병원아이디: " + session.getAttribute("hos_id"));
		
		System.out.println("병원 컨트롤러 : " + vo);
//		vo.setHos_id((String)session.getAttribute("hos_id"));
		model.addAttribute("hos", hospitalService.getHos(vo));

		return "/hospital/hosDetail";

	}

	// 검색에서 병원상세로
	@RequestMapping("/getHosInfo")
	public String getHosInfo(@RequestParam("hos_addr2") String hosAddr2, @RequestParam("hos_addr3") String hosAddr3,
			@RequestParam("hos_name") String hosName, @RequestParam("hos_tel") String hosTel, Model model) {
		System.out.println("왔냐");
		HospitalVO vo = new HospitalVO();
		vo.setHos_addr2(hosAddr2);
		vo.setHos_addr3(hosAddr3);
		vo.setHos_name(hosName);
		vo.setHos_tel(hosTel);

		System.out.println(vo.getHos_addr2());
		System.out.println(vo.getHos_addr3());
		model.addAttribute("hos", hospitalService.getHosInfo(vo));

		return "/hospital/hosDetail";
	}

//병원 상세정보
	@RequestMapping("/toHosInfo")
	public String toHosInfo() {
		System.out.println("왔냐1");

		return "/hospital/hosInfo";
	}

//병원의 의사삭제
	@RequestMapping(value = "/delHos")
	public String delHos(HospitalVO vo, HttpSession session) {
		System.out.println("비번" + vo.getHos_pw());
		vo.setHos_id((String)session.getAttribute("hos_id"));
		// 여기에 if else 써서 delHos가 받아오는 값이 0보다 많으면 인덱스로, 없으면 리다리엑트로
		hospitalService.delHos(vo);
//	      session.invalidate();
		return "redirect:index.jsp";
	}

	//의사정보1
		@RequestMapping("/toDoc")
		public String toDoctors(DoctorVO vo, Model model, HttpSession session) {
			System.out.println("왔냐2");

			vo.setDoc_hos_id((String) session.getAttribute("doc_hos_id"));

			System.out.println(vo.getDoc_hos_id());
			model.addAttribute("docList", doctorService.getDocList(vo));
			System.out.println(vo);
			return "hospital/doctors";
		}

	//  병원리뷰로 이동
		@RequestMapping("/toReviewList")
		public String toReviewList(ReviewVO vo, Model model, HttpSession session) {
			vo.setRev_hos_id((String) session.getAttribute("hos_id"));
//			모델 어트리뷰트 써서 끌고올것
			System.out.println(vo.getRev_hos_id());
			model.addAttribute("revList", revService.getRevList(vo));
			System.out.println(vo);
			return "hospital/reviews";
		}
	
		//병원 마이페이지에서 리뷰 조회할때 사용
		@RequestMapping("/toHosReview")
		public String toReview(ReviewVO vo, Model model, HttpSession session) {

			vo.setRev_hos_id((String)session.getAttribute("hos_id"));
//			모델 어트리뷰트 써서 끌고올것
			System.out.println(vo.getRev_hos_id());
			model.addAttribute("reviewList", revService.getRevList(vo));
			System.out.println(vo);
			return "hosMyPage/myHosReviews";
		}

		//의사정보2
		@RequestMapping("/toDocUpdate")
		public String toDocUpdate(DoctorVO vo, Model model, HttpSession session) {
			System.out.println("투닥투닥"+ vo);
			model.addAttribute("doc", doctorService.getDoc(vo));
			System.out.println("투닥업"+vo);
			return "hosMyPage/docUpdate";
		}

	
		//병원 마이페이지 정보 수정
		@RequestMapping("/toHosUpdate")
		public String toHosUpdate(HospitalVO vo, Model model, HttpSession session) {
			
			vo.setHos_id((String)session.getAttribute("hos_id"));
			
			System.out.println(vo.getHos_id());
			model.addAttribute("hos", hospitalService.getHos(vo));
			return "hosMyPage/hosUpdate";
		}
	
		@RequestMapping(value = "/updHos")
		public String updHos(HospitalVO vo)  throws IllegalStateException, IOException { 
			System.out.println(vo);
			
			MultipartFile uploadFile = vo.getUploadFile();
			
			String realPath = "c:/vet/petmedic/src/webapp/resources/imgs/";
//			String realPath = "C:\\final project2\\petmedic11차 (1)\\src\\main\\webapp\\resources\\imgs";
			String fileName = uploadFile.getOriginalFilename();
			
			if(!uploadFile.isEmpty()) {
				vo.setFilename(fileName);
				uploadFile.transferTo(new File(realPath+fileName)); //transferTo: file을 destination으로 transfer함
			}
			
			hospitalService.updateHospital(vo);
			return "hosMyPage/hosMyPage";
		}
		//의사삭제
		@RequestMapping("/delDoc")
		public String delDoctor(DoctorVO vo) {
			System.out.println(vo);
			doctorService.delDoc(vo);
			return "hospital/doctors";
		}

		//의사 수정
		@RequestMapping(value = "/updDoc")
		public String updDoctor(DoctorVO vo)  throws IllegalStateException, IOException  {
			System.out.println(vo);
			MultipartFile uploadFile = vo.getUploadFile();
			
			String realPath = "c:/vet/petmedic/src/webapp/resources/imgs/";
//			String realPath = "C:\\final project2\\petmedic11차 (1)\\src\\main\\webapp\\resources\\imgs";
			String fileName = uploadFile.getOriginalFilename();
			
			if(!uploadFile.isEmpty()) {
				vo.setDoc_filename(fileName);
				uploadFile.transferTo(new File(realPath+fileName)); //transferTo: file을 destination으로 transfer함
			}
			
			System.out.println(vo);
			
			doctorService.updDoc(vo);
			return "redirect:/docList";
		}
		//내 병원 	
		@RequestMapping("/myHos")
		public String myHos(HospitalVO vo, Model model) {
			System.out.println(vo);
			model.addAttribute("hos", hospitalService.getHos(vo));
			return "hosMyPage/myHos";
		}

	//병원리스트
		@RequestMapping("/docList")
	      public String docList(DoctorVO vo, Model model, HttpSession session) {
	         vo.setDoc_hos_id((String) session.getAttribute("hos_id"));
	         System.out.println("닥리스트"+vo);

	         model.addAttribute("docList", doctorService.getDocList(vo));
	         System.out.println(vo);
	         return "hosMyPage/docList";
	      }

		//병원회원 탈퇴
		@RequestMapping("/toDelHos")
		public String delHos(HospitalVO vo, Model model) {
			System.out.println(vo);
			model.addAttribute("hos", hospitalService.getHos(vo));
			return "hosMyPage/deleteHos";
		}

		@RequestMapping("/toHosMyPage")
		public String toHosMyPage(HospitalVO hvo, DoctorVO dvo, ReviewVO revvo, ReserveVO resvo, Model model, HttpSession session) {
			System.out.println("왔냐");
			hvo.setHos_id((String)session.getAttribute("hos_id"));
			dvo.setDoc_hos_id((String)session.getAttribute("hos_id"));
			resvo.setRes_hos_id((String)session.getAttribute("hos_id"));
			revvo.setRev_hos_id((String)session.getAttribute("hos_id"));
			System.out.println(hvo.getHos_id());
			model.addAttribute("hos", hospitalService.getHos(hvo));
			model.addAttribute("docList", doctorService.getDocList(dvo));
			model.addAttribute("revList", reviewService.getRevList(revvo));
			model.addAttribute("resList", reserveService.getResList(resvo));

			return "hosMyPage/hosMyPage";
		}

		@RequestMapping("/toInsertDoc")
		public String toInsertDoc(HospitalVO vo, Model model, HttpSession session) {

			vo.setHos_id((String)session.getAttribute("hos_id"));
			//이건 김태희가 세션 없어서 임의로 만든거임
			
//			모델 어트리뷰트 써서 끌고올것
			System.out.println(vo.getHos_id());
			model.addAttribute("hos", hospitalService.getHos(vo));
			System.out.println(vo);
			return "hosMyPage/insertDoc";
		}

		@RequestMapping("/insertDoc")
		public String insertDoc(DoctorVO vo, HttpSession session) throws IllegalStateException, IOException {
			
			MultipartFile uploadFile = vo.getUploadFile();
			
			//경로 바꿔야됨
			String realPath = "c:/vet/petmedic/src/webapp/resources/imgs/";
//			String realPath = "C:\\final project2\\petmedic11차 (1)\\src\\main\\webapp\\resources\\imgs";
			String fileName = uploadFile.getOriginalFilename();
			
			 if(!uploadFile.isEmpty()) {
				   vo.setDoc_filename(fileName);
				   uploadFile.transferTo(new File(realPath+fileName)); //transferTo: file을 destination으로 transfer함
			   }
			
			doctorService.insertDoc(vo);
			
			return "redirect:/docList";
		}
	
		@RequestMapping("/pickHos")
		public String pickHos(UsersVO uvo, Model model, HttpSession session) {
			
			 
			System.out.println("uvo: " + uvo);
			
			uvo.setUsers_id((String)session.getAttribute("users_id"));
			uvo.setHos_id((String)session.getAttribute("hosId"));
			
			System.out.println(userService.getUserInfo(uvo));
			System.out.println(uvo.getHos_id());
			
			System.out.println(userService.getUserInfo(uvo).getUsers_pick1() .equals(uvo.getHos_id()) );
			
			if(!userService.getUserInfo(uvo).getUsers_pick1().equals(uvo.getHos_id())){
				if(!userService.getUserInfo(uvo).getUsers_pick2().equals(uvo.getHos_id())){
					if(!userService.getUserInfo(uvo).getUsers_pick3().equals(uvo.getHos_id())){
						if(!userService.getUserInfo(uvo).getUsers_pick4().equals(uvo.getHos_id())){
							if(!userService.getUserInfo(uvo).getUsers_pick5().equals(uvo.getHos_id())){
								if(userService.getUserInfo(uvo).getUsers_pick1().isEmpty()){
									userService.pickHos1(uvo);
								} else if(!userService.getUserInfo(uvo).getUsers_pick1().isEmpty()){
									 if(!userService.getUserInfo(uvo).getUsers_pick2().isEmpty()){
										 if(!userService.getUserInfo(uvo).getUsers_pick3().isEmpty()){
											 if(!userService.getUserInfo(uvo).getUsers_pick4().isEmpty()){
												 if(!userService.getUserInfo(uvo).getUsers_pick5().isEmpty()){ 
													 System.out.println("찜 목록이 다 찼습니다"); 
//													 model.addAttribute("error","1");
													 return "redirect:getHos?error=1";
//													 return "hosDetail/hosDetail.jsp?error=1";
												 } 
												 else {
													 userService.pickHos5(uvo);
												 }
											 } else {
												 userService.pickHos4(uvo);
											 }
										 } else {
											 userService.pickHos3(uvo);
										 }
									 }else {
										 userService.pickHos2(uvo);
									 }
								}
							}else {
								System.out.println("중복됨");
								return "redirect:getHos?error=2";
							}
						}else {
							System.out.println("중복됨");
							return "redirect:getHos?error=2";
						}
					}else {
						System.out.println("중복됨");
						return "redirect:getHos?error=2";
					}
				}else {
					System.out.println("중복됨");
					return "redirect:getHos?error=2";
				}
			} else {
				System.out.println("중복됨");
				return "redirect:getHos?error=2";
			}
			return "hosDetail/hosDetail";
		}

//		 [관리자]병원등록1
		@RequestMapping(value = "/insertHospital", method = RequestMethod.GET)
		public String insertHospital() {
			System.out.println("insertHospital() get방식 메소드 호출 시작");
			return "/hospital/insertHospital";
		}

		// 병원등록
		   @RequestMapping(value = "/insertHospital", method = RequestMethod.POST)
		   public String insertHospital(HospitalVO hosvo) throws IllegalStateException, IOException {
		      System.out.println("insertHospital() post방식 메소드 호출 시작");
		      System.out.println("hosvo: " + hosvo);
		      MultipartFile uploadFile = hosvo.getUploadFile();

		      // 상대경로를 절대경로로 변경해주는 경우 realPath 추가
		      // String realPath =
		      // request.getSession().getServletContext().getRealPath("/img/");

		      // 파일 이미지경로 설정
		      String realPath = "c:/vet/petmedic/src/main/webapp/resources/pdf/";
		      String fileName = uploadFile.getOriginalFilename();

		      if (!uploadFile.isEmpty()) {
		         String fileExtension = FilenameUtils.getExtension(fileName);
		         if ("pdf".equalsIgnoreCase(fileExtension)) {
		            hosvo.setHos_file(fileName);
		            uploadFile.transferTo(new File(realPath + fileName));
		         }
		      }
		      
		      /*
		       * List<String> hos_pic = new ArrayList<>();
		       */   
		      
		      MultipartFile uploadFile1 = hosvo.getUploadFile1();
		      // 파일 이미지경로 설정              
		      String realPath2 = "c:/vet/petmedic/src/main/webapp/resources/imgs/"; 
		       String pictureFileName = uploadFile1.getOriginalFilename();
		       
		       // 이미지 파일이 존재할 경우에만 처리 
		       if (!uploadFile.isEmpty()) { 
		          String pictureFileExtension = FilenameUtils.getExtension(pictureFileName); 
		       if(isImageFileExtension(pictureFileExtension)) {
		         hosvo.setHos_pic(pictureFileName);
		       uploadFile1.transferTo(new File(realPath2 + pictureFileName)); 
		          } 
		       }
		       
		       String hashedPw = hospitalService.hashedChk(hosvo.getHos_pw());
		       hosvo.setHos_pw(hashedPw);
		       hospitalService.insertHospital(hosvo);
		      return "redirect:/index.jsp";
		   }

		   // 이미지파일 다운받게 해주는 메소드
		   private boolean isImageFileExtension(String fileExtension) {
		      String[] imageExtensions = { "jpg", "jpeg", "png", "gif" };
		      String lowerCaseFileExtension = fileExtension.toLowerCase();
		      for (String extension : imageExtensions) {
		         if (lowerCaseFileExtension.equals(extension)) {
		            return true;
		         }
		      }
		      return false;
		   }
	   

	// [관리자] 병원승인하기
	   @RequestMapping(value="/checkHospital")
	   public String checkHospital(@ModelAttribute("hospital") HospitalVO hosvo, HttpSession session, Model model) {
	       hospitalService.checkHospital(hosvo);
	       model.addAttribute("hospital", hospitalService.getHospitalList(hosvo));
	       return "/hospital/getHospitalList";
	   }
	
	   
	   
	// 병원 수정
	@RequestMapping("/updateHospital")
	public String updateHospital(HospitalVO hosvo, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("updateHospital 경로");
		System.out.println("hosvo 수정: " + hosvo);
		
		MultipartFile uploadFile = hosvo.getUploadFile();
		
		// 상대경로를 절대경로로 변경해주는 경우 realPath 추가
		// String realPath =
		// request.getSession().getServletContext().getRealPath("/img/");
		String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
		String fileName = uploadFile.getOriginalFilename();

		if (!(uploadFile.isEmpty())) {
			hosvo.setHos_pic(fileName);
			uploadFile.transferTo(new File(realPath + fileName)); // transferTo: file을 destination으로 transfer함
		}
	      
	      hospitalService.updateHospital(hosvo);
			
			return "redirect:/getHospitalList";
	   }
	
		
		// 조건부여했을시 삭제가능하게
//			 if(hosvo.getHos_id().equals(session.getAttribute("hos_id").toString()) ) {
//				 hospitalService.updateHospital(hosvo);
//				 return "getHospitalList";
//			 } else {
//				 return "getHospital?error=1";
//			 }
	
	// 관리자가 병원 수정페이지이동
	   @RequestMapping(value = "/updatePageHospital")
	   public String updatePageHospital(HospitalVO hosvo, Model model) {
	      System.out.println("updatePageHospital" + hosvo);

	      model.addAttribute("hospital", hospitalService.getHospital(hosvo));
	      return "hospital/updateHospital";
	   }

	// [관리자] 병원정보 1차삭제
    @RequestMapping(value="/deletewaitingHospital")
    public String deletewaitingHospital(HospitalVO hosvo, Model model) {
       hosvo.setHos_del("Y"); 
        hospitalService.deletewaitingHospital(hosvo);
        List<HospitalVO> hospital = hospitalService.getHospitalList(hosvo);
         model.addAttribute("hospital", hospital);             
       return "hospital/getHospitalList";
      //return "hospital/getHospitalList";
   }

	// 병원정보 완전삭제
	@RequestMapping("/deleteHospital")
	public String deleteHospital(HospitalVO hosvo) {
		hospitalService.deleteHospital(hosvo);
		System.out.println();
		return "hospital/getHospitalList";
	}

	// 병원 상세로 이동
	@RequestMapping("/getHospital")
	public String getHospital(HospitalVO hosvo, Model model) {
		// Model model 인터페이스 객체를 자동으로 만듬.
		System.out.println(hosvo);

		model.addAttribute("hospital", hospitalService.getHospital(hosvo));
//			=> 데이터를 담기만해도 어차피 포워드로 전송이 되기때문에 MAV 객체를 쓸 필요가 없다
		return "hospital/getHospital";
	}

	// 병원 목록
	@RequestMapping("/getHospitalList")
	public String getHospitalListPost(HospitalVO hosvo, Model model) {
		System.out.println("병원 목록 검색 처리");

		model.addAttribute("hospital", hospitalService.getHospitalList(hosvo));
		return "hospital/getHospitalList";
	}
	// [유저]병원 목록
	@RequestMapping("/getHosListUser")
	public String getHosListUser(HospitalVO hosvo, Model model) {
		System.out.println("유저전용 병원 목록 검색 처리");
		
		model.addAttribute("hospital", hospitalService.getHosListUser(hosvo));
		System.out.println(model.getAttribute("hospital"));
		return "hospital/getHosListUser";
	}

	// 병원증명자료 다운로드
	   @RequestMapping("/download")
	   public void download(HospitalVO hospital, HttpServletResponse response) throws Exception {
	      try {
	         String fileName = hospital.getHos_file();
	         String extension = FilenameUtils.getExtension(fileName);

	         if (extension.equalsIgnoreCase("pdf") || isImageFileExtension(extension)) {
	            String path = "c:/Swork/petmedic/src/main/webapp/resources/imgs/" + fileName;
	            File file = new File(path);

	            response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
	            FileInputStream fileInputStream = new FileInputStream(file);
	            OutputStream out = response.getOutputStream();

	            int read;
	            byte[] buffer = new byte[1024];
	            while ((read = fileInputStream.read(buffer)) != -1) {
	               out.write(buffer, 0, read);
	            }

	            fileInputStream.close();
	            out.close();
	         } else {
	            throw new Exception();
	         }
	      } catch (Exception e) {
	         throw new Exception("Download error: " + e.getMessage());
	      }
	   }
	   
	   
	   
	   

	// 관리자가 요청받은 병원 상세목록
	@RequestMapping("/requestHospitalList")
	public String requestHospitalListPost(HospitalVO hosvo, Model model) {
		System.out.println("병원 목록 검색 처리");

		model.addAttribute("hospital", hospitalService.requestHospitalList(hosvo));
		return "admin_user/requestHospitalList";
	}
	
	 // 관리자가 요청받은 병원 상세
	   @RequestMapping(value="/requestHospital")
	    public String requestHospital(HospitalVO hosvo, Model model) {
		  System.out.println("request hospital : " + hosvo);
	   

	   model.addAttribute("hospital", hospitalService.requestHospital(hosvo));
	   return "admin_user/requestHospital";
	    }
	

	// 페이징 메소드
	public PageInfo paging(PageInfo pageInfo) {
		int listCount = pageInfo.getPageListCount(); // 받아온 리스트 카운트 얻어옴

		int totalPage = listCount / 10; // 임의의 totalPage 변수 생성
		if (listCount % 10 != 0) {
			totalPage++;
		}
		pageInfo.setTotalPage(totalPage); // 정해진 totalPage 수 대입

		int pageNUM = pageInfo.getPageNUM(); // pageNUM값 받아옴
		if (pageNUM == 0) {
			pageNUM = 1;
		}

		pageInfo.setPageNUM(pageNUM);// 이거 해야 처어어어음 로딩 했을 때 페이징 버튼 css 제대로 됨..

		int start = pageNUM - 1;// 임의의 start 변수 생성
		if (start > 0) {
			start = 10 * start;
			pageInfo.setStart(start);
		} else {
			pageInfo.setStart(start); // start 변수 만들어야겠지 ? ?
		}

		if (totalPage <= 10) {
			pageInfo.setStartNUM(1);
			pageInfo.setEndNUM(totalPage);
		} else {
			int p = pageNUM / 10;

			if ((pageNUM % 10) == 0) {
				p = p - 1;
				pageInfo.setStartNUM((p * 10) + 1);
				pageInfo.setEndNUM((p + 1) * 10);
			} else {
				pageInfo.setStartNUM((p * 10) + 1);
				pageInfo.setEndNUM((p + 1) * 10);
			}

			if (pageInfo.getEndNUM() > totalPage) {
				pageInfo.setEndNUM(totalPage);
			}
		}

		return pageInfo;

	}
	
	//병원로그인
	@ResponseBody
	   @RequestMapping(value = "/hoslogin", method = RequestMethod.POST)
	   public Object login(HospitalVO vo, Model model, HttpSession session) {
	       Map<String, Object> Login = new HashMap<String, Object>();
	      String hos_pw = vo.getHos_pw();
	      HospitalVO hosInfo = hospitalService.gethosInfo1(vo);
	      if (hosInfo != null) {
	         if (hospitalService.pwMatchChk(hos_pw, hosInfo.getHos_pw())) {
	            session.setAttribute("login", hosInfo);
	            session.setAttribute("hos_id", hosInfo.getHos_id());
	            session.setAttribute("hos_name", hosInfo.getHos_name());
	            session.setAttribute("hos_role", hosInfo.getHos_role());
	            Login.put("loginError", "false");
	         }else {
	            Login.put("loginError", "true");
	            System.out.println("ture 틀린 비번");
	            }
	         }else {
	            Login.put("loginError", "true");
	             System.out.println("사용자 정보 없음");
	         }
	      return Login;
	   }
	
	 //병원로그인2 hoslogin.jsp에서 작동되는거
	   @RequestMapping(value = "/hoslogin2", method = RequestMethod.POST)
	   public String login2(HospitalVO vo, Model model, HttpSession session) {
	      System.out.println("로그인 인증 처리 ...");
	      String hos_pw = vo.getHos_pw();
	      HospitalVO hosInfo = hospitalService.gethosInfo1(vo);
	      if (hosInfo != null) {
	         if (hospitalService.pwMatchChk(hos_pw, hosInfo.getHos_pw())) {
	            session.setAttribute("login", hosInfo);
	            session.setAttribute("users_id", hosInfo.getHos_id());
	            session.setAttribute("users_name", hosInfo.getHos_name());
	            session.setAttribute("users_role", hosInfo.getHos_role());
	            return "redirect:petmedic_main.jsp";
	         }
	      }
	      model.addAttribute("nologin", true);
	      return "forward:/hoslogin.jsp";
	   }
	   
	   private String randomAuthCode() {
				Random rand = new Random();
				String numStr = "";
				for (int i = 0; i < 6; i++) {
					String ran = Integer.toString(rand.nextInt(10));
					numStr += ran;
				}
				return numStr;
			}
	   
	// 전화번호로 아이디찾기 - 인증번호 전달
			@RequestMapping("/forgothosIdCheck")
			@ResponseBody
			public HashMap forgotId(HospitalVO vo, HttpSession session) {
				HospitalVO cvo = hospitalService.checkDupPhone(vo);

				System.out.println("컨트롤러cvo : " + cvo);
				HashMap<String, Object> result = new HashMap();
				result.put("flag", cvo != null);
				if (cvo != null) {
					String rndAuthCode = randomAuthCode();
					UUID uuid = UUID.randomUUID();
					session.setAttribute(uuid.toString(), rndAuthCode);
					result.put("key", uuid.toString());
					phoneService.certifiedPhoneNumber(vo.getHos_tel(), rndAuthCode);
				}
				return result;
			}
			
			// 전화번호로 아이디 찾기 인증번호 확인
						@RequestMapping("/forgothosIdConfirm")
						@ResponseBody
						public String forgotIdConfirm(String phone, String key, String value, HttpSession session) {
							String keyValue = (String) session.getAttribute(key);
							// 인증번호가 없을경우 재발신 요청하도록 변경
							if (keyValue == null)
								return "expired";
							if (keyValue != null && keyValue.equals(value)) {
								HospitalVO hospitalVO = new HospitalVO();
								hospitalVO.setHos_tel(phone);
								HospitalVO cvo = hospitalService.checkDupPhone1(hospitalVO);
								SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // yyyy-MM-dd HH:mm:ss
								String format = formatter.format(cvo.getHos_new_date());
								// 사용자 정보가 있을경우 id와 가입일자 return
								return format+"/" +cvo.getHos_id();
							}
							return "";
						}
			
			// 비밀번호 재설정
			@RequestMapping("/resethosPassword")
			public String resetPassword() {
				return "intercept/resethosPassword";
			}
			
			// 아이디 찾기
			@RequestMapping("/forgothosId")
			public String forgotId() {
				return "intercept/forgothosId";
			}
			
			// 비밀번호 재설정 id와 전화번호 입력했을때 처리
			@RequestMapping("/resethosPasswordCheck")
			@ResponseBody
			public HashMap resetPasswordCheck(HospitalVO vo, HttpSession session) {
				HospitalVO cvo = hospitalService.getId(vo);

				HashMap<String, Object> result = new HashMap();
				result.put("flag", cvo != null);
				// 입력한 id가 없는 경우
				result.put("msg", cvo == null ? "존재하지 않는 ID 입니다." : "");

				if (cvo != null) {
					// 입력한 id는 존재하지만 입력한 전화번호와 일치하지 않는경우
					if (cvo.getHos_tel().equals(vo.getHos_tel()) == false) {
						result.put("flag", false);
						result.put("msg", "전화번호와 일치하는 사용자가 없습니다.");
					} else {
						String rndAuthCode = randomAuthCode();
						UUID uuid = UUID.randomUUID();
						session.setAttribute(uuid.toString(), rndAuthCode);
						result.put("key", uuid.toString());
						phoneService.certifiedPhoneNumber(vo.getHos_tel(), rndAuthCode);
					}
				}
				return result;
			}
			
			@RequestMapping("/hosauthCodeConfirmCheck")
			@ResponseBody
			public Boolean phoneConfirmCheck(String key, String value, HttpSession session) {
				String keyValue = (String) session.getAttribute(key);
				System.out.println(keyValue);
				if (keyValue == null)
					return null;
				return keyValue != null && keyValue.equals(value);
			}

	   
		// 별점높은 병원 가져오기	
			@RequestMapping("/revHighStar")
			@ResponseBody
			public List<HospitalVO> revHighStar(HospitalVO vo, HttpSession session) {
			    System.out.println("별점높은 병원 가져오기 revHighStar 처리");
			    // You can use the revHosSeq and revUserId values as needed
			    return hospitalService.revHighStar(vo);
			}
			// 리뷰많은 병원 가져오기	
			@RequestMapping("/getManyRevHos")
			@ResponseBody
			public List<HospitalVO> getManyRevHos(HospitalVO vo, HttpSession session) {
				System.out.println("리뷰많은 병원 가져오기 revHighStar 처리");
				// You can use the revHosSeq and revUserId values as needed
				return hospitalService.getManyRevHos(vo);
			}
			
	   
			@RequestMapping("/resList")
	         public String resList(ReserveVO vo, HttpSession session, Model model) {
	            vo.setRes_hos_id((String)session.getAttribute("hos_id"));
	            
	            System.out.println(vo.getRes_hos_id());
	            model.addAttribute("resList", reserveService.getResList(vo));
	            System.out.println(vo);
	            return "/hosMyPage/resList";
	         }
			
			
			// 예약횟수로 베스트 병원 가져오기 (인덱스용)
			   @RequestMapping("/getBestHospitals")
			   @ResponseBody
			   public List<ReserveVO> getBestHospitals(ReserveVO vo){
			      System.out.println("베스트병원 가져올거야 > 리저브컨트롤러");
			      reserveService.getBestHospital(vo);
			      return reserveService.getBestHospital(vo);
			   }	
			
			  //맵검색 
			   @RequestMapping("/locations")
			   @ResponseBody
			   public List<HospitalVO> getLocations(@RequestParam String keyword, @RequestParam String searchCondition, HospitalVO vo) {
			     // Retrieve location data from the database (MariaDB in this case)
				   vo.setSearchKeyword(keyword);
				   vo.setSearchCondition(searchCondition);
			     List<HospitalVO> locations = hospitalService.getAllLocations(vo);
			     return locations;
			   }  
			   
			// 병원 상세 [찜목록에서 이동]
			   @RequestMapping("/getHosDetailZzim")
			   public String getHosDetail(HospitalVO vo, Model model) {
			      System.out.println("병원 컨트롤러 : " + vo);
			       System.out.println("저장된 호스아이디: " + vo.getHos_id());
			       model.addAttribute("hos", hospitalService.getHos(vo));
			       return "/hospital/hosDetail";
			   }
	   
}
