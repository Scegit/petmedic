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
<title>펫등록</title>
<style>

/* 컨테이너가 감싼 div */
.insertPets {
	width:80%;
	margin: 10px auto 10px auto;
}

/* 컨테이너를 감싼 div */
div.insertPetsDiv {
	width : 768px;
	max-width : 100%;
	margin-top : 30px;
	padding-top: 50px;
	border-radius : 5px;
	box-shadow: 0 .1rem 2rem rgba(0,0,0,.08) !important;
	margin: 0 auto;
}

.div-col {margin-bottom:10px;}

/* 인풋 */
.input-input {
 	width: 100%;
	padding : 6px 10px;
	border-radius : 5px;
	border : 1px solid #e3e3e3;
	outline : none;
 }
 
.input-input:focus,.input-input:active {border: 1px solid #ffe100; outline:none;}

/* 등록버튼 */
.btn-submit {
	width: 110px; 
	background-color : #fbbc04; 
	border-radius : 8px;
	border : none;
	padding: 8px;
	margin: 20px auto;
	color:white;
}
  
.btn-submit:hover {
  	background-color :#674ea7;
	color:white;
	font-weight:bold;
}
	
.btn-submit:action, .btn-submit:focus {outline:none !important; box-shadow:none !important;}
	
  
.div-btn {
	margin:0 auto;
	text-align:center;}
  

.petimg {width:50px; border-radius:50px;}

/* 파일 미리보기 문구 */
.span-file {
	font-size:14px;
	display:block;
	margin-bottom:30px;
	text-align:center;
	}

/* 이미지 나오는 곳 */
div#image_container {
    padding: 20px 150px;
    text-align:center;
}

#imgContainer{
	width: 300px; 
	height: 300px; 
	margin: 0 auto; 
	padding:0px; 
	border-radius : 50%;
	border : 1px solid #ddd;
	overflow : hidden;
	background-color: #e3e3e3;
}

#previewImg {height: 100%; max-width: 100%;}


.previewImg {
	text-align:center;}

.imgDivBox {margin-top: 50px; text-align: center;}

@media screen and (max-width: 576px) { 

/* 파일 미리보기 문구 */
.span-file {
	text-align:center;
	margin-top:30px;
	}

#imgContainer{
	width: 230px; 
	height: 230px; 
	margin: 0 auto; 
	padding:0px; 
	border-radius : 50%;
	border : 1px solid #ddd;
	overflow : hidden;
	background-color: #e3e3e3;
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
               <h2>마이펫 등록</h2>
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


	<div class="container imgDivBox">  
	<div class="insertPets">

<!-- 	이미지 추가되는 곳 (시작) -->
	<label for="clickImg">
	<div id="imgContainer">
		<img id="previewImg">
	</div>
	</label>
	<span class="span-file">파일 등록 시 미리 볼 수 있습니다.</span>
	<!-- 	 이미지 추가되는 곳 (종료) -->
<div class="container insertPetsDiv">
	
	<form action="/insertPets" id="insertpetsinfo" method="post" enctype="multipart/form-data">
    	<div class="row">
      		<div class="col div-col">
    			<input type="file" id="clickImg" accept="image/*"  class="input-input" onchange="readURL(this);" name="uploadFile" style="display:none;">
  			</div>
  		</div>
  		<div class="row">
		  <div class="col div-col">
		    <input type="text" name="pet_name" placeholder="이름을 입력해주세요. 등록 후 수정 하실 수 없습니다." class="input-input" required>
		  </div>
		</div>

		<div class="row">
		  <div class="col div-col">
		    <input type="text" name="pet_age" placeholder="나이를 입력해주세요. 숫자로만 입력 가능 예)3"  class="input-input" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
  		  </div>
  		</div>
  		
  		<div class="row">
  			<div class="col div-col">
   				<input type="text" name="pet_weight" placeholder="체중(kg)을 입력해주세요." class="input-input"onKeyup="this.value=this.value.replace(/[^-\.0-9]/g,'');">
 			</div>
		</div>
		
		<div class="row">
  			<div class="col div-col">
    			<select name="pet_sex" class="input-input">
				    <option value="성별을 선택해주세요">성별을 선택해주세요</option>
				    <option value="모름" >모름</option>
				    <option value="암컷" >암컷</option>
				    <option value="수컷" >수컷</option>
    			</select>
  			</div>
  		</div>
  		<div class="row">
	  		<div class="col div-col">
	    		<input type="text" name="pet_cate" placeholder="품종을 입력해주세요. 예)모름" class="input-input">
	  		</div>
  		</div>

		<div class="row">
		  <div class="col div-col">
		    <input type="text" name="pet_info" placeholder="질병 정보를 입력해주세요. 예)없음" class="input-input">
		  </div>
  		</div>
  		
  		<div class="row">
		  <div class="col div-col">
		    <select name="pet_neuter" class="input-input">
		      <option value="중성화 여부를 선택해주세요" selected>중성화 여부 (Y,N으로 표시)</option>
		      <option value="Y" > Y</option>
		      <option value="N"> N</option>
		    </select>
    	 </div>
  		</div>

	<div class="div-btn">
		<input type="submit" value="등록" class="btn-submit">
	</div>
	</div>
</form>
</div>
   </div>		
		



	
 <%@ include file="../../footer.jsp"%>
<script>
// function onlyNumber(){
// 	   if((event.keyCode > 48 && event.keyCode < 57 ) 
// 	      || event.keyCode == 8 //backspace
// 	      || event.keyCode == 37 || event.keyCode == 39 //방향키 →, ←
// 	      || event.keyCode == 46 \\delete키
// 	      || event.keyCode == 39){
// 	   }else{
// 	   event.returnValue=false;
// 	   }
// 	}


$('#insertpetsinfo').submit(function () {
	if(confirm('펫을 추가하시겠습니까?')== true){
	alert('펫이 추가되었습니다.');
	}else {return false;}
	
	
	
});

  
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

function readURL(input) {
	let defaultImgUrl = "${pageContext.request.contextPath}/img/noimg.png" ;
	
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
							document.getElementById('previewImg').src = e.target.result;
							previewImg.setAttribute("src", e.target.result);
							previewImg.classList.add("thumImg");
							previewImg.style.width = "180%";
							previewImg.style.borderWidth = "1px";
							previewImg.style.borderStyle = "solid";
							previewImg.style.borderColor = "#fbbc04";	};
							previewImg
		reader.readAsDataURL(input.files[0]);
//     };
	} else {
		document.getElementById('previewImg').src = defaultImgUrl;
	}
}


</script>

</body>
</html>