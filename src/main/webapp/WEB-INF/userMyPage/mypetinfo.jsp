<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" -->
<!--    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" /> -->
<!-- <script -->
<!--    src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script -->
<!--    src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!-- <script -->
<!--    src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

<title>Insert title here</title>

</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%> 
<style>


*{ box-sizing: border-box;}

div.petInfoDiv{
	width : 768px;
	max-width : 100%;
	margin-top : 30px;
	padding-top: 50px;
	border-radius : 5px;
	box-shadow: 0 .1rem 2rem rgba(0,0,0,.08) !important;
}

.input-input { 
	width: 100%;
	padding : 6px 10px;
	border-radius : 8px;
	border : 1px solid #e3e3e3;
	outline : none;
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
	text-align:center;
}

.previewImg {
	text-align:center;}

.selectClass {
	width : 100%;
	padding : 6px 10px;
	border-radius : 10px;
	border : 1px solid #e3e3e3;

}

.div-col { margin-top: 10px; }

.btn-submit {
	width: 100%; 
	background-color : #fbbc04; 
	border-radius : 8px;
	border : none;
	padding: 10px 10px;
	margin: 20px auto 20px auto;
	color:white;
}

.btn-submit:hover {
	background-color :#674ea7;
	color:white;
	font-weight:bold;
}


.div-btn{
	padding:0px;
	margin: 0 auto;
	width: 150px;
	
}

.div-updatepetsinfo {
	width:80%;
	margin: 10px auto 10px auto;
}

.span-info {
	font-size:12px;
	color:gray;}
	
/* 파일 미리보기 문구 */
.span-file {
	font-size:14px;
	display:block;
	margin-bottom:30px;
	text-align:center;
	}

/* 이미지 나오는 곳 */
div#image_container {
    text-align:center;
    padding: 20px 250px;
}

.imgDivBox {margin-top: 50px; text-align: center;}
#previewImg {height: 100%; max-width: 100%;}

@media screen and (max-width: 576px) { 

	.img-img {
	border-radius:100%;
	border:1px solid #fbbc04;
	padding:20px;
	text-align:center;
	width:70%;
	}
	
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
   <div class="container structure myMainMenuWeb">
   <!-- ########################### -->
       
      <!-- 웹사이즈 메뉴 시작 -->
      <div id="menuDiv">
         <div class="row" id="flex">
            <div class="col-md-8 leftDiv">
               <h2>마이펫 수정</h2>
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
               <div class="mobileMy_wrap" onclick="location.href='/getUsers'">내정보</div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/mypetlist'">마이펫</div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="getMyActionZzim()">찜병원</div>
            </div>
         </div>
         <div class="row mobileMy_memu mobileMymemu2">
            <div class="col">
               <div class="mobileMy_wrap" onclick="getMyActionReserve()">예약<br>내역</div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/getMyReviewPostList'">나의<br>리뷰</div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/tomypagemain'">마이<br>메인</div>
            </div>
         </div>
      </div>
<!-- 반응형 메뉴 끝 -->
<div class="container imgDivBox">   
	
	<!-- 	이미지 추가되는 곳 (시작) -->
	<label for="clickImg">
	<div id="imgContainer">
		<img id="previewImg" src="${pageContext.request.contextPath}/resources/imgs/${pets.pet_pic} ">
	</div>
	</label>
	<span class="span-file">파일 등록 시 미리 볼 수 있습니다.</span>
	<!-- 	 이미지 추가되는 곳 (종료) -->
	  
	<div class="div-updatepetsinfo">
		<div class="row">
			<div class="col div-col">
				<label class="Petlabel" style="display:none">펫 사진 등록</label>
			</div>
		</div>
	</div>
</div>


<div class="container petInfoDiv">
	 <form action="updatePetsInfo" id="updatepetsinfo" method="post" enctype="multipart/form-data">

		<div class="row">
			<div class="col">
				<input type="file" id="clickImg" name="uploadFile" style="display:none" class="input-input" onchange="readURL(this);">
			</div>
		</div>
		<div class="row">
			<div class="col div-col">
				<label class="Petlabel">펫 이름</label>
			</div>
		</div>			
		<div class="row">
			<div class="col">
				<input type="text" name="pet_name" value="${pets.pet_name}"  class="input-input" readonly>
			</div>
		</div>
		
		<div class="row" id="pet_age">
			<div class="col div-col">
				<label class="Petlabel">펫 나이<span class="span-info">  (숫자로만 입력해주세요.)</span></label>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<input type="text" name="pet_age" value="${pets.pet_age }" placeholder="나이" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" class="input-input">
			</div>
		</div>
	
		<div class="row" id="pet_weight">
			<div class="col div-col">
				<label class="Petlabel">펫 체중(kg)</label>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<input type="text" name="pet_weight" value="${pets.pet_weight }" onKeyup="this.value=this.value.replace(/[^-\.0-9]/g,'');" class="input-input">
			</div>
		</div>
			
	  
		<div class="row">
			<div class="col div-col">
				<label class="Petlabel">펫 성별</label>
			</div>
		</div>	 
		<div class="row">
			<div class="col">
				<select name="pet_sex" class="selectClass" >
					<option value="모름" <c:if test="${pets.pet_sex eq '모름'}">selected</c:if>>모름</option>
					<option value="암컷" <c:if test="${pets.pet_sex eq '암컷'}">selected</c:if>>암컷</option>
					<option value="수컷" <c:if test="${pets.pet_sex eq '수컷'}">selected</c:if>>수컷</option>
				</select>
			</div>
		</div>
	   
	   
		<div class="row">
			<div class="col div-col">
				<label class="Petlabel">펫 품종</label>
			</div>
		</div> 
		<div class="row">
			<div class="col">
				<input type="text" name="pet_cate" value="${pets.pet_cate}" class="input-input">
			</div>   
		</div>
	
		<div class="row">
			<div class="col-12 div-col">
				<label class="Petlabel">펫 질병정보</label>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
			  <input type="text" name="pet_info" value="${pets.pet_info}" class="input-input">
			</div>
		</div>
	
	
		<div class="row">
			<div class="col-12 div-col">
				<label class="Petlabel">중성화 여부 (Y,N)</label>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<select name="pet_neuter" class="selectClass">
					<option value="Y" <c:if test="${pets.pet_neuter eq 'Y'}">selected</c:if>>Y</option>
					<option value="N" <c:if test="${pets.pet_neuter eq 'N'}">selected</c:if>>N</option>
				</select>
			</div>
		</div>
	
		<div class="div-btn">
		<input type="submit" value="수정" class="btn-submit">
		</div>
		</div>
	</form>
</div>
</div>
 <%@ include file="../../footer.jsp"%>
	
<script>

$(function(){
	$('#updatepetsinfo').submit(function(){
		if(confirm('펫 정보를 수정하시겠습니까?')==true) {	
		alert('수정되었습니다.');
		}
	});
});
		
// function setThumbnail(event) {
//     var reader = new FileReader();

//     reader.onload = function(event) {
//       var img = document.createElement("img");
//       img.setAttribute("src", event.target.result);
//       img.classList.add("thumImg");
//       img.style.width = "70%";
//       img.style.borderRadius = "50%";
//       img.style.borderWidth = "1px";
//       img.style.borderStyle = "solid";
//       img.style.borderColor = "#fbbc04";
  
//       document.querySelector("div#image_container label").innerHTML = '';
//       document.querySelector("div#image_container label").appendChild(img);
//     };

//     reader.readAsDataURL(event.target.files[0]);
//   }

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
//	     };
		} else {
			document.getElementById('previewImg').src = defaultImgUrl;
		}
	}
  
//   $(function() {
// 	  $('#uploadfile').("onclick",function(){
		  
// 	  });
	  
//   });
</script>

</body>
</html>