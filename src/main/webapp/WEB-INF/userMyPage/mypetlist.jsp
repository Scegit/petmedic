<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" -->
<!--    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" /> -->
<!-- <script -->
<!--    src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script -->
<!--    src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!-- <script -->
<!--    src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script>

</script>

<meta charset="UTF-8">

<title>마이펫리스트</title>
<style>
/* 마이펫 발바닥 선택 시 색 변경 */
#mypetlist {
	background-color: white;
	color:#fbbc04;}

/* 정보 조회 버튼 ,삭제 버튼*/
.pet-btn {
	border:none;
	background-color:#fbbc04;
	color: white;
	border-radius: 15px;
	padding:10px 16px;
	width: 80%;
	
	}
	
.h3 {
margin:0 auto;
text-align:center;
margin-top:50px;}

.pet-btn:hover {
	background-color:#674ea7;
	font-weight:bold;}


/* 등록 버튼 */
.pet-insert-btn {
	background-color:#674ea7;
	color:white;
	border:none;
	width: 70%;
	padding:10px 16px;
	border-radius: 15px;
}

.pet-insert-btn:hover {
	background-color:#fbbc04;
	font-weight:bold;
}


#row {
  	display: flex;
  	align-items: center;
  	margin-top:50px;
  	border:none;
  	background-color:white;
  	border-radius:25px;
   	transition: transform 0.3s ease;
   	text-align:center;
   	font-family: 'SUIT-Regular';
    box-shadow: 0 .1rem 2rem rgba(0,0,0,.08) !important;
}

.div-btn-mypets {
	text-align:center;
	margin:50px;
}

#row:hover {
  transform: translateY(-5px);
}

#row > div {
  display: inline-block;
  vertical-align: middle;
  margin:0 auto;
  width:700px;
  padding:8px;
  color:gray;
}

.pet-btn:active, .pet-btn:focus , .pet-insert-btn:active, .pet-insert-btn:focus {
	outline:none !important;
	box-shadow:none !important;}



/* 기본이미지크기 */
img {

	width:70px;
	border-radius:50px;
	border:1px solid #ededed;
}

.img {width:80px;}

.petslist {

width:768px;}

.div-petslist {
display:none;}

.btn-petslist:active, .btn-petslist:focus{
outline:none !important;
box-shadow:none !important;}

@media screen and (max-width:599px) {
/* 스마트폰 세로 */


.div-title {

width:250px;
margin:0 auto;}

.handDivR ,.oneDivR circleDiv ,.twoDivR circleDiv,.threeDivR circleDiv {

background-color: #674ea7;
color: #674ea7; }

.circleDiv {background-color: #674ea7;
color: #674ea7; }

.col-md-8 leftDiv {
margin:0 auto;
}

.div-petslist {
display:block;} 
.col-6.col-xs-6.col-sm-2.col-xs-btn {
    padding: 10px !important;
  }
}

</style>
</head>

<body>
 <%@ include file="../../petmedic_navbar.jsp"%>
 

   <div class="container structure myMainMenuWeb">
        <!-- 웹사이즈 메뉴 시작 -->
      <div id="menuDiv">
         <div class="row" id="flex">
            <div class="col-md-8 leftDiv">
					<h2>마이펫리스트</h2>
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
               <div class="mobileMy_wrap" id="getMyReviewPostList" onclick="revIns()">
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

<div class="container petslist">
	<c:choose>
		<c:when test="${empty petsList }">
			<h3 class="h3" style="color:gray;">등록한 펫이 없습니다</h3>
		</c:when>
		<c:otherwise>
		<c:forEach var="pets" items="${petsList}">
			<div class="div-title">
				<div class="row" id="row">
				  <div class="col-12 col-xs-12 col-sm-2"><img id="img" style="width:70px; height:70px; border-radius:50%;"  src="${pageContext.request.contextPath}/resources/imgs/${pets.pet_pic} " onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png ';"></div>
				  <div class="col-12 col-xs-12 col-sm-2">${ pets.pet_name }</div>
				  <div class="col-12 col-xs-12 col-sm-2">${ pets.pet_age }살</div>
				  <div class="col-6 col-xs-6 col-sm-2 col-xs-btn"><button type="button" class=" pet-btn" onclick="mypetinfo('${ pets.pet_name }','${pets.pet_users_id }','${pets.pet_pic }')">정보</button></div>
				  <div class="col-6 col-xs-6 col-sm-2 col-xs-btn"><button type="button" class=" pet-btn" onclick="deletepet('${ pets.pet_name }','${pets.pet_users_id }','${pets.pet_pic}')">삭제</button></div>
				</div>
			</div>
		</c:forEach>
		</c:otherwise>
	</c:choose>
		
		
	
	
	<div class="div-btn-mypets">
		<button type="button" class="pet-insert-btn" 
		onclick="mypets('<%=session.getAttribute("users_id") %>')">펫 등록</button>
	</div>
</div>
</div>
 <%@ include file="../../footer.jsp"%>

<script>
window.onload = function() {
    var petlist = document.getElementById("row");
    petlist.classList.add("float-up");
  };
  
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
  
  function mypetinfo(val1,val2,val3) {
		console.log(val1+val2+val3);
		
		location.href="mypetInfo?pet_name="+val1+"&pet_users_id="+val2+"&pet_pic="+val3;
		
	}

	function deletepet(val1,val2,val3) {
		console.log(val1+val2+val3);
		  if(confirm("펫을 정말 삭제하시겠습니까?"))
				  {

			   location.href="deletePetsInfo?pet_name="+val1+"&pet_users_id="+val2+"&pet_pic="+val3;
			   
			   alert('삭제되었습니다.');
			   
			   
			}
			   else return;}

	function mypets(val){
		console.log(val);
		location.href="/mypets?pet_users_id="+val;
	}</script>
</body>
</html>