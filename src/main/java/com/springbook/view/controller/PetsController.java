package com.springbook.view.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.pet.pets.PetsService;
import com.spring.pet.pets.PetsVO;
import com.spring.pet.users.UsersVO;

@Controller
public class PetsController {

	@Autowired
	private PetsService petsService;

	// 펫 등록
	@RequestMapping("/insertPets") 
	public String insertPets(@ModelAttribute("pets") PetsVO vo, Model model, HttpSession session)
			throws IllegalStateException, IOException {
		String id = (String) session.getAttribute("users_id"); // ID값을 넣은 세션객체를 만들어놔야 여기서 갖고 올 수 있음
		vo.setPet_users_id(id);// id값을 vo에서 세터로 설정한다.
		MultipartFile uplodFile = vo.getUploadFile();
		String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
		String fileName = uplodFile.getOriginalFilename();
		System.out.println("펫등록 겟오리지널파일이름"+fileName);
		
		if (!uplodFile.isEmpty()) {//공부 필요
			vo.setPet_pic(fileName);
			String filenm = vo.getPet_pic();
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date time = new Date();
			String result = dateFormat.format(time);
			filenm = result + filenm;
			System.out.println(filenm+"filenm");
			
			if (filenm != null) {
				File file = new File("c:/vet/petmedic/src/main/webapp/resources/imgs/" + filenm);
				boolean exists = file.exists();
				while (exists) {
				
					File filet = new File("c:/vet/petmedic/src/main/webapp/resources/imgs/" + filenm);
					exists = filet.exists();
				}

				uplodFile.transferTo(new File(realPath + filenm));
				vo.setPet_pic(filenm);
			}

		}

		petsService.insertPets(vo);
		System.out.println("vo insert 됨?"+vo); 
		model.addAttribute("pets", vo);
		return "redirect:/mypetlist";

	}

	// 펫 수정(파일 업데이트 x db에선 변함)
	@RequestMapping("/updatePetsInfo")
	public String updatePetsInfo(@ModelAttribute("pets") PetsVO vo, Model model, HttpSession session)
			throws IllegalStateException, IOException {
		vo.setPet_pic((String)session.getAttribute("pet_pic"));

		System.out.println("이전의 pet_pic"+vo.getPet_pic());
	
		String id = (String) session.getAttribute("users_id"); // ID값을 넣은 세션객체를 만들어놔야 여기서 갖고 올 수 있음
		vo.setPet_users_id(id);// id값을 vo에서 세터로 설정한다.
		
		MultipartFile uplodFile = vo.getUploadFile();
		String fileName = uplodFile.getOriginalFilename(); // 새로 업로드한 파일이름
		String delfile = vo.getPet_pic();					// 기존에 등록된 파일이름(삭제되어야함)
		System.out.println("지울 파일명:   " + delfile);
		System.out.println("새로 업로드할 파일명:     " + fileName);
		
		String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
//		Path filePath = Paths.get("c:/vet/petmedic/src/main/webapp/resources/imgs/" + fileName);
		
		if(!uplodFile.isEmpty()) {
			String filenm = vo.getPet_pic(); //이전에 있던 파일 이름
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date time = new Date();
			String result = dateFormat.format(time); //날짜 붙이기
			filenm = result + fileName; //왜 변수를 새로만들면 않되? =걍 외우자
			vo.setPet_pic(filenm);
			
			System.out.println("filenm"+filenm);
			
			if (filenm != null) {//새로 등록했을 때
				File file = new File("c:/vet/petmedic/src/main/webapp/resources/imgs/" + filenm);
				boolean exists = file.exists();
				while (exists) {
					File filet = new File("c:/vet/petmedic/src/main/webapp/resources/imgs/" + filenm);
					exists = filet.exists();
				}

				 Path delfilePath = Paths.get(realPath + delfile);
		         try {
		            Files.deleteIfExists(delfilePath);
//		            uplodFile.transferTo(new File(realPath + filename));
		         } catch (IllegalStateException e) {
		            e.printStackTrace();
		         } catch (IOException e) {
		            e.printStackTrace();
		         }
		         
				uplodFile.transferTo(new File(realPath + filenm));
//				vo.setPet_pic(filenm);
			}
		}
		petsService.updatePetsInfo(vo);
		return "redirect:/mypetlist?pet_users_id="+id;
	}

	// 펫 조회
	@RequestMapping("/mypetInfo") 
	public String getPetsInfo(@ModelAttribute("pets") PetsVO vo, Model model, HttpSession session) {
		
		model.addAttribute("pets", petsService.getPetsInfo(vo));

		System.out.println("펫 정보 받아오기 처리");

		if (petsService.getPetsInfo(vo) != null) {
			System.out.println("vo: " + vo);
			session.setAttribute("pet_name", vo.getPet_name());
			session.setAttribute("pet_users_id", vo.getPet_users_id());
			session.setAttribute("pet_pic", vo.getPet_pic());
			
			System.out.println("id" + vo.getPet_users_id());
			return "userMyPage/mypetinfo";
		} else {
		}

		return "userMyPage/mypetlist";
	}

	// 펫 목록 조회
	@RequestMapping(value = "/mypetlistajax")
	@ResponseBody //아작스로 데이터 보내려면 반드시 붙여야함
	public List<PetsVO> mypetlistajax(PetsVO vo, Model model, HttpSession session) {
		System.out.println("vo: " + vo.getPet_users_id());
		model.addAttribute("petsList", petsService.getPetsList(vo));
	
		if (petsService.getPetsList(vo) != null) {
			return petsService.getPetsList(vo);
		} else {
		 return null;
		}
	}

	@RequestMapping(value = "/mypetlist")
	public String getPetsList(PetsVO vo, Model model, HttpSession session) {
		System.out.println("vo: " + vo.getPet_users_id());
		String id = (String) session.getAttribute("users_id");
		vo.setPet_users_id(id);
		model.addAttribute("petsList", petsService.getPetsList(vo));
		
		
			return "userMyPage/mypetlist"; //string으로 url 보낼때는 return null하면 안 됨

	}


	// 펫 삭제(파일 삭제 o)
		@RequestMapping(value = "/deletePetsInfo")
		public String deletePetsInfo(PetsVO vo, Model model) {
		
			System.out.println("delete vo:"+vo);
			int r =petsService.deletePetsInfo(vo) ;
			String filenm = vo.getPet_pic();
			System.out.println("filenm"+filenm);
			Path filePath = Paths.get("c:/vet/petmedic/src/main/webapp/resources/imgs/" + filenm);
//			System.out.println("이미지가 찐으로 있는 경로"+filePath);
			if (r>0) { //delete,update,insert는 행수를 반환하기 때문에 int로 받아 조건을 넣는다.
		
	                 // 파일 삭제
	                 try {
						Files.delete(filePath);
					} catch (IOException e) {
						e.printStackTrace();
					}
//	                  
//	       
//				
				return "redirect:/mypetlist?pet_users_id="+vo.getPet_users_id();
			} else 
				return "mypetlist?error=1";


		}
		//펫 등록 페이지
		@RequestMapping("/mypets")
		public String mypets(UsersVO vo) {
			return "userMyPage/mypets";
		}
	
	

}