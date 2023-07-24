<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
 request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
/* 발바닥 내정보 선택 시 색 변경 */
#myinfo{
	background-color: white;
	color:#fbbc04;
	}
	
.updateuser {
	width:100%;
	margin:0 auto;}

.div-form {
  	margin-top: 60px;
  	text-align: center;
  	border: 1px solid #d4d4d4;
  	width: 90%;;
  	margin: 0 auto;
  	height: 200px;
  	border-radius:15px;
  	max-width:100%;
  	margin-bottom:30px;
}

.hr1 {display:none;}

.h4-update {
	text-align:center;
	margin-top:20px;
	color:gray;
	margin-bottom:20px;
	font-weight:500;
}

.p2 {font-size: 14px; color:#828282;}

.p1 {
	margin-top:20px;
	font-size: 15px;
	margin-bottom:0;
	color:#828282;
	font-weight:bold;
	}

.input-id {width:170px; border:1px solid #e3e3e3;}

.input-pw {border:1px solid #e3e3e3;}

.div-input {margin-top:30px;}

.btn-submit {
	padding: 8px;
	background-color:#fbbc04;
	color:white;
	border-radius:8px;
	border:none;

}

.btn-submit:hover {
	background-color: #674ea7;
	border:none;
	color:white;
	font-weight:bold;}

.btn-mypage {
	text-align:center;
	color:white;
	cursor:pointer;
	border-radius: 8px;
	padding: 8px; 
	background-color: #fbbc04;
	border:none;
	
}

.btn-mypage:hover {
	background-color:#674ea7;
	font-weight:bold;}

.btn-mypage:active, .btn-mypage:focus , .btn-submit:active , .btn-submit:focus {
	outline:none !important;
	box-shadow:none !important;}

.btn-submit {
	width:90px;
	display:inline;
}

div.btn-btn {
	text-align:center;
	margin-top:50px;
}

/* 인풋 누를 때 효과 */
.input-id:active,.input-id:focus , .input-pw:active, .input-pw:focus {border: 1px solid #ffe100; outline:none;}

/* 스마트폰 세로 */
@media screen and (max-width: 576px) { 

.div-input {
	text-align:center;
}

.div-form {
  width: 400px;
  text-align:center;
  margin:0 auto;
  margin-top:10px;
  height:10%;
}

.hr2 {
	display:none;
	text-align:left;
	width:800px;
	margin-top:10px;
}


.h4-update {
	font-size : 30px;
	margin-top:50px;
	text-align:center;}

.input-id {
	width:250px;
	padding:10px;
	display:block;
	margin:50px auto 20px auto;
}

.input-pw {
	width:250px;
	padding:10px;
	display:block;
	margin: 0 auto 20px auto;
}

.div-input {
	margin-top:150px;
	margin:0 auto;
}

.p1 {
	text-align:left;
	font-weight:bold;}

.p2 {
	text-align:left;
	font-size:13px;
	width:320px;}

.div-form {
	border:none;
	margin:0 auto;
	text-align:center;
	margin-top:30px;
	}

.btn-submit {
	display:block;
	margin:0 auto;
	padding:8px;
	width:90px;
	}

.hr1 {
	display:block;
	text-align:left;
	width:335px;
	margin-top:10px;
}

.h2 {
	text-align:left;
	margin-top:30px;
}

.btn-mypage {
	border:none;
	padding:8px;
	display:inline;
	border-radius:8px;
	}

.btn-submit {
	display:inline;
}

.div-btn {
	margin-top:10px;
}

div.btn-btn {
	text-align:center;
	height:50px;
}

</style>
</head>
<body style="height:150%;">

<%@ include file="../../petmedic_navbar.jsp"%> 

   <div class="container structure myMainMenuWeb">
<!-- 웹사이즈 메뉴 시작 -->
      <div id="menuDiv">
         <div class="row" id="flex">
            <div class="col-md-8 leftDiv">
               <h1>마이페이지</h1>
            </div>
            <div class="col-md-4 rightDiv">
               <div class="wrapDiv">
                  <div class="handDivR" onclick="location.href='/getUsers'">
                     <b>내정보</b>
                  </div>
                  <div class="oneDivR circleDiv"></div>
                  <div class="twoDivR circleDiv"></div>
                  <div class="threeDivR circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivL" onclick="location.href='/mypetlist'">
                     <b>마이펫</b>
                  </div>
                  <div class="oneDivL circleDiv"></div>
                  <div class="twoDivL circleDiv"></div>
                  <div class="threeDivL circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivR" onclick="getMyActionZzim()">
                     <b>찜병원</b>
                  </div>
                  <div class="oneDivR circleDiv"></div>
                  <div class="twoDivR circleDiv"></div>
                  <div class="threeDivR circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivL" onclick="getMyActionReserve()">
                     <b>예약내역</b>
                  </div>
                  <div class="oneDivL circleDiv"></div>
                  <div class="twoDivL circleDiv"></div>
                  <div class="threeDivL circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivR" onclick="location.href='/getMyReviewPostList'">
                     <b>나의리뷰</b>
                  </div>
                  <div class="oneDivR circleDiv"></div>
                  <div class="twoDivR circleDiv"></div>
                  <div class="threeDivR circleDiv"></div>
               </div>
            </div>
         </div>
      </div>
      <!-- 웹사이즈 메뉴 끝 -->
      
      <!-- 반응형 메뉴 시작 -->
      <div class="container mobileMyMenu">
         <div class="row mobileMytitle">
            <div class="col"><h3><strong>마이페이지</strong></h3></div>
            <div class="col"><span><%=session.getAttribute("users_id")%>님! 어서오세요 </span></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/getUsers'">
                  내정보
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/mypetlist'">
                  마이펫
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="getMyActionZzim()">
                  찜병원
               </div>
            </div>
         </div>
         <div class="row mobileMy_memu mobileMymemu2">
            <div class="col">
               <div class="mobileMy_wrap" onclick="getMyActionReserve()">
                  예약<br>내역
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/getMyReviewPostList'">
                  나의<br>리뷰
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/tomypagemain'">
                  마이<br>메인
               </div>
            </div>
         </div>
      </div>
      <!-- 반응형 메뉴 끝 -->

<div class="container updateuser">
	<form action="update" method="post">
		<h4 class="h4-update">내정보 확인</h4>
		<hr class="hr1">
	
	<div class="div-form">
		<p class="p1">비밀번호를 한번 더 입력해주세요.</p>
		<p class="p2">회원님의 정보를 안전하게 보호하기 위해 비밀번호를 한번 더 확인합니다.</p>
		<hr class="hr2">
			<div class="div-input">
				<input type="text" name="users_id" value="${users.users_id}" class="input-id" readonly>
				<input type="password" name="users_pw" class="input-pw" placeholder="비밀번호">
			</div>
						
	</div>
			<div class="btn-btn">
				<input type="submit" class="btn-submit"value="확인">
				<button class="btn-mypage" onclick="tomypagemain('${users.users_id}')">마이페이지</button>
			</div>	
	</form>
</div>
</div>


<script>                                                            
function tomypagemain(val)
{console.log(val);
	location.href="/tomypagemain?users_id="+val;}

//리뷰쓰기 이동
function revIns(val){
   location.href = "getReserveForReview";
}
//예약내역으로 이동 
function getMyActionReserve(val){
   location.href = "myActionReserve";
}
//찜병원으로 이동   
function getMyActionZzim(val){
   location.href = "myActionZzim";
}
</script>

 <%@ include file="../../footer.jsp"%>
</body>
</html>