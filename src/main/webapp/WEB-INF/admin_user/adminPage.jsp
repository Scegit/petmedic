 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 







<%-- 
<%
String users_role = "USER"; // 사용자의 역할 정보

if (users_role.equals("SUPERADMIN")) {
    // SUPERADMIN인 경우에만 adminPage.jsp를 인클루드
    %><%@ include file="../admin_user/adminPage.jsp" %><%
}
%>
--%>


<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- css -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- boxicons css -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
 -->
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel="stylesheet">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<title>관리자페이지</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script> -->
<script>
<%--
//로그인 폼에서 전달받은 아이디와 패스워드 정보로 사용자 인증 진행
String users_id = request.getParameter("users_id");
String users_pw = request.getParameter("users_pw");
String userRole = null;  // 등급 정보 초기화
if (isValidUser(users_id, users_pw)) {
// 등급 정보 검사
userRole = getUserRole(users_id);
if (!userRole.equals("admin") && !userRole.equals("superadmin")) {
 // 등급이 admin 또는 superadmin이 아니면 에러 메시지 출력 후 로그인 폼으로 이동
 out.println("권한이 없습니다.");
 response.sendRedirect("login.jsp");
} else {
 // 등급이 admin 또는 superadmin인 경우 세션에 정보 저장 후 관리자 페이지로 이동
 HttpSession session = request.getSession();
 session.setAttribute("users_id", users_id);
 session.setAttribute("users_role", userRole);
 response.sendRedirect("adminPage.jsp");
}
} else {
// 인증 실패 시 에러 메시지 출력 후 로그인 폼으로 이동
out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
response.sendRedirect("login.jsp");
}

//사용자 인증을 위한 메소드
private boolean isValidUser(String userid, String userpw) {
// 사용자 정보를 검사하는 로직
}

//사용자 등급 정보를 가져오는 메소드
private String getUserRole(String userid) {
// 사용자 등급 정보를 데이터베이스에서 가져오는 로직
}
--%>
</script>

<style>
/*일단 내부스타일로 작성*/
.adminsidebar{
	overflow: auto;
	height: 100%;
}
/* 사이드바 닫힌 상태 */
.sidebar-closehide {
	width: 70px;
	background: #5D3891;
	height: 100vh;
	z-index: 9999; /* 다른 요소 위에 표시되도록 설정 */
	top: 0; /* 페이지 상단에 위치하도록 설정 */
	left: 0; /* 페이지 왼쪽에 위치하도록 설정 */
	bottom: 0;
	position: fixed; /*사이드바영역 위아래 끝으로*/
	float: left; 
	
}

/* 사이드바 열린 상태 */
.sidebar-closeshow {
	background: #5D3891;
	float: left;
	width: 220px;
	/* 사이드바를 고정 위치로 설정 */
	position: fixed;
	/* 페이지 상단에 위치하도록 설정 */
	top: 0;
	/* 페이지 왼쪽에 위치하도록 설정 */
	left: 0;
	/* 페이지 전체 높이만큼 설정 */
	height: 100%;
	/* 다른 요소 위에 표시되도록 설정 */
	z-index: 9999;
	
}
/* 사이드바 열린상태 아이콘크기 */
.sidebar-closeshow .nav-link i {
	color: #Fbbc04;
	font-size: 1.2rem; /* 아이콘크기설정 rem('배')으로 지정 */
	 
}
.sidebar-closehide .nav-link i {
	color: #Fbbc04;
	font-size: 1.2rem; /* 아이콘크기설정 rem('배')으로 지정 */
	
}
/*사이드바 닫힌상태*/
.sidebar-closehide .nav-link{
	float: left;
	align-items: center;
	position: absolute;

}




/* 사이드바 닫힌상태에서 각 아이콘위치 고정 */
.sidebar-closehide .nav-link:nth-child(1) {
    top:90px;   
}   
.sidebar-closehide .nav-link:nth-child(2) {
	top:150px;	
}
.sidebar-closehide .nav-link:nth-child(3) {
	top:210px;
}
.sidebar-closehide .nav-link:nth-child(4) {
	top:270px;
}
.sidebar-closehide .nav-link:nth-child(5) {
	top:330px;
}
.sidebar-closehide .nav-link:nth-child(6) {
	top:390px;
}
.sidebar-closehide .nav-link:nth-child(7) {
	top:450px;
}

/* 사이드바 열린상태에서 각 아이콘위치 고정 */
.sidebar-closeshow .nav-link{
   align-items: center;
   float: left;
   
}


/* 사이드바 닫힌상태 아이콘크기 */
.sidebar-closehide .nav-link i {
	color: #Fbbc04;
	font-size: 2.5rem; /* 아이콘크기설정 rem('배')으로 지정 */
	margin-top: 10px;
	float: left;
	padding-right: 10px;
	margin-left: -8px;
}


.image-text {
	background: white;
	width: 100%;
	border-bottom: 1px solid #0097A7;
}

.image-text span {
	justify-content: center;
	align-items: center;
	display: flex;
}

/* 사이드바 닫힌상태 로고영역 */
.sidebar-closehide .image-text span img {
	width: 64px;
	height: auto;
	margin-top: 10px;
	margin-bottom: 10px;
}
/* 사이드바 닫힌상태 로고옆 닫기버튼 숨김 */
.sidebar-closehide .image-text span button {
	display: none;
}
/* 사이드바 열린상태 로고영역 */
.sidebar-closeshow .image-text span img {
	width: 160px;
	height: 160px;
	margin-top: 10px;
	margin-bottom: 10px;
}
/* 로고영역 */
.btn-close {
	border-radius: 50%;
	border: 2px solid #5D3891;
	padding:0px;
	width: 30px;
	height: 28px;
	
}
/* 닫힌상태에서 메뉴들글자숨기기*/
.sidebar-closehide .nav-link .text.nav-text{  
  color: white;
  display: none;
}
/* 닫힌상태에서 하위메뉴글자 숨김*/
.sidebar-closehide li .amove{
 display: none;

}

/* 열린상태의 하위메뉴영역*/
.sidebar-closeshow .amove:child{
  font-size: 14px;
  margin-left: 5px;
}
/* 로고가 든 메뉴영역 배경색 */
.menu-bar {
	color: white;
}
/* 닫힌상태 아이콘 가운데 정렬*/
.sidebar-closehide ul.menu-links {
	
	list-style: none;
}
ul.menu-links {
   padding-left: 8px; 

}

/* 사이드바 닫힌상태 위아래 여백 */
.nav-link {
	margin: 10px 0 10px 0;
}
/* 사이드바 열린상태 위아래 여백 */
.sidebar-closeshow .nav-link {
  text-align: inherit;
/*   margin-right: 20px; */
}
.sidebar-closeshow .nav-link li{
  text-align: inherit;
  margin-right: 30px;
  margin-bottom: 5px;
}



.submenu{
 fiex: 1=;
}

/* 상위메뉴의 글씨밑줄 제거 */
.sidebar-closeshow .nav-link a {
	text-decoration: none;
	cursor: pointer;
	color: white;
	list-style: none;
	font-size: 20px;
	float: left;
}
.nav-link span{
  font-size: 20px;
}

.nav-link ul {
	list-style: none;
	margin-top: 5px;
	margin-left: 25px;
	text-align: center;
	padding: 0;
}


.nav-link a:hover {
	color: #Fbbc04;
	font-weight: bold; /* 호버 시 굵은 글씨 스타일 */
    text-decoration: none;
}

.nav-link a.submenu {
	display: none;
}
/* 상위메뉴 정렬 및 효과*/
.nav-link a span {
	font-size: 20px;
	color: white;
	justify-content: center;
	align-items: center;
	margin-left: 20px;
	
}

/* 사이드바 열린상태 상위메뉴효과*/
.sidebar-closeshow .nav-link a span:hover {
	color: #Fbbc04;
	font-weight: bold; /* 호버 시 굵은 글씨 스타일 */
	
}


/* 숨겨진 서브메뉴 */
.submenu li a {
	color: white;
	display: none;
}
/* 활성화된 서브메뉴 보이기 */
.submenu {
	list-style: none;
}

.submenu li {
	/* 불릿기호 없애기*/
	list-style: none;
	/*들여쓰기 없애기*/
	/*   padding-left: 0px;  */
	display: block;
}
/* 닫힌상태 하위메뉴*/
.sidebar-closehide .spanmove{
  display: none;
  position: fixed; /* 글자안보이게 해줌*/
}

/* ---- 로그 아웃 버튼 스타일 --- */
.adminlogout{
  width: 100%;
  height: 30px;
  color: white;
  padding-left: 2px;
}
.adminlogout:hover{
  width: 100%;
  height: 30px;
  color: #Fbbc04;
  font-weight: bold; /* 호버 시 굵은 글씨 스타일 */
  text-decoration: none;
}


.sidebar-closeshow .logoutadmin{
  float: right;
}
.sidebar-closeshow .adminlogout{
  width: 100%;
  height: 30px;
  color: white;
  float: left;
  margin-l; 
}

.sidebar-closeshow .adminlogout:hover{
  width: 100%;
  height: 30px;
  color: #Fbbc04;
  font-weight: bold; /* 호버 시 굵은 글씨 스타일 */
  text-decoration: none;
}

</style>
	
</head>




<body class="adminnsidebar">
<script>
 <%-- 사이드메뉴바 기능 --%> 
$(document).ready(function(){
	 $(".sidebar-close").removeClass("sidebar-closeshow");
	 $(".sidebar-close").addClass("sidebar-closehide"); 
	
	$(document).on('click','.btn-close', function(){
		$(".sidebar-close").removeClass("sidebar-closeshow");
		$(".sidebar-close").addClass("sidebar-closehide");
		
 	});
 	
	$(document).on("click",".sidebar-closehide" , function(e){
			$(".sidebar-close").removeClass("sidebar-closehide");
			$(".sidebar-close").addClass("sidebar-closeshow");
			
	});   
});	
		
// 		$(".sidebar-close").hide();
// 		$("#op-btn").show().css({'color' : '#Fbbc04','font-size': '3rem'});
// 		.css('color', '#Fbbc04')  한개일때 사용하는 css방식
</script>  
<script>
// 상위메뉴에서 하위메뉴보여주는 함수식
$(document).ready(function(){
    // memu 클래스 바로 하위에 있는 a 태그를 클릭했을때
    $(".nav-link>a").click(function(){
        // 현재 클릭한 태그가 a 이기 때문에
        // a 옆의 태그중 ul 태그에 submenu 클래스 태그를 넣던지 빼던지 한다.
        $(this).next("ul").toggleClass("submenu");
    });
});
</script>
<script>



</script>

 <nav class="sidebar-close sidebar-closeshow"> 
  <header>
    <div class="image-text">
      <span class="image">
      <!--   20230518_영미 수정 -->
      <img src="resources/imgs/PetMedicLogo_P.png" alt="logo" onclick="window.location.href='/adminMain'"/> 
      <button type="button" class="btn-close" >
<i class="material-icons" style="font-size:25px">clear</i></button>
      </span>           
    </div>           
  </header>
  
  <div class="menu-bar">
    <div class="adminmenu">
   	<div class="logoutadmin">
       <a class="adminlogout" href="logout">로그아웃</a>
      </div>
      <ul class="menu-links">
         <li class="nav-link">
           <a href="#">  
            <i class='bx bx-male-female icon' ></i>
             <span class="text nav-text"><a href="/getUserList" class="spanmove">일반회원관리</a></span>
             </a>          
         </li>
       <li class="nav-link">
         <a href="#">  
         <i class='bx bx-buildings icon' ></i>
         <span class="text nav-text" class="spanmove">병원관리</span>
         <ul class="submenu">
         <li class="amove"><a href="/requestHospitalList" >승인요청병원</a></li>
         <li class="amove"><a href="/getHospitalList" >병원목록</a></li>
         <li class="amove"><a href="/insertHospital" >병원등록</a></li>       
         </ul>
         </a>
       </li> 
      <li class="nav-link">
        <a href="#">  
        <i class='bx bx-plus-medical icon' ></i>
         <span class="text nav-text"><a href="/getReserveList" class="spanmove">예약관리</span>                        
        </a>
      </li>  
   <li class="nav-link">
   <a href="#">  
   <i class='bx bx-paper-plane icon' ></i>
   <span class="text nav-text" ><a class="spanmove">리뷰관리</a></span>
    <ul class="submenu">
         <li class="amove"><a href="/getAdminRevList">리뷰목록</a></li>
         <li class="amove"><a href="/getReportList">리뷰신고내역</a></li>
       </ul>
   </a>
   </li>
   <li class="nav-link">
   <a href="#">  
   <i class='bx bx-book-content icon'></i>
   <span class="text nav-text"><a href="/toAdmin_NoticeMain" class="spanmove">공지사항관리</a></span>
   </a>
   </li>  
   <li class="nav-link">
   <a href="#">  
   <i class='bx bx-home-alt icon'></i>
   <span class="text nav-text"><a class="spanmove" href="/togetFaqListAdmin">FAQ관리</a></span>
   </a>
   </li>
    <li class="nav-link">
   <a href="#">  
   <i class='bx bxs-home'></i>   
   <span class="text nav-text">
   <a class="spanmove" href="index.jsp">메인으로가기</a></span>
   </a>
   </li>
   </ul>    
   
   </div> 
  </div>
</nav>



</body>
</html>