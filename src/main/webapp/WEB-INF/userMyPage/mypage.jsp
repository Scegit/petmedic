<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 request.setCharacterEncoding("UTF-8");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--    <script src="https://code.jquery.com/jquery-3.4.1.js"></script> -->
<!--    <link rel="stylesheet" -->
<!--    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" /> -->
<!-- <script -->
<!--    src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script -->
<!--    src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->

      
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!--     <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.js"></script> -->
<!--     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.js"></script> -->
<!--     <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.js"></script> -->

   <style>
   

/* container안에 들어가있는 div*/
.div-updateusersinfo {
	width:80%;
	margin: 10px auto 10px auto;
	}
   
/* container감싼 div */
div.userInfoDiv{
	width : 768px;
	max-width : 100%;
	margin-top : 30px;
	padding-top: 50px;
	border-radius : 5px;
	box-shadow: 0 .1rem 2rem rgba(0,0,0,.08) !important;
	
}

/* input */
.input-input { 
	width: 100%;
	padding : 6px 10px;
	border-radius : 5px;
	border : 1px solid #e3e3e3;
	outline : none;
}
   

.input-input:focus,.input-input:active {border: 1px solid #ffe100; outline:none;}
  
/*수정 버튼 , 탈퇴 버튼   */
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

  
/* 버튼 감싼 div   */
.div-btn{
	padding:0px;
	margin: 0 auto;
	width:100%;
	text-align:center;
}


  
.btn-submit:active ,.btn-submit:focus {
	outline:none !important;
	box-shadow:none !important;
	}

/*    주소검색 버튼 */
.btn-input {
   border:none;
   border-radius:6px;
   background-color:#fbbc04;
   color:white;
   width:100%;
   padding:7px;
   }
   
.btn-input:hover {
      font-weight:bold;
  	  background-color:#674ea7;
   }
   
.btn-input:active, .btn-input:focus {
	outline:none !important;
	box-shadow:none !important;
	}
	
.div-col {
margin-top:10px;
}
   </style>
<script>

//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
        	console.log('우편번호의 data' , data);
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수 "대구 달서구 야외음악당로 3"
            var extraRoadAddr = ''; // 참고 항목 변수  "(성당동)"

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다. data.bname : "성당동"
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname; // "성당동"
            }
            // 건물명이 있고, 공동주택일 경우 추가한다. data.buildingName : "" , data.apartment : "N"
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')'; //"(성당동)"
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode; //"42681"
            document.getElementById("sample4_roadAddress").value = roadAddr; //"대구 달서구 야외음악당로 3"
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress; //"대구 달서구 성당동 830-1"

            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if (roadAddr !== '') {
                document.getElementById("sample4_extraAddress").value = extraRoadAddr; ////"(성당동)"
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if (data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if (data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }

            $("#sample4_detailAddress").focus();
        }
    }).open();
}

$(function(){
	$('#updateuserinfo').submit(function(){
			if (confirm('수정 하시겠습니까?') == true){//확인
				
				alert('수정이 완료되었습니다.');
	
	}
		});
});
	



function mypetlist(val){
   console.log(val);
   
   location.href="/mypetlist?pet_users_id="+val;
}






function deleteInfo(val){
  
   if(confirm("정말 탈퇴하시겠습니까?")){

   location.href="/deleteInfo?users_id="+val;
   
   alert('탈퇴 되었습니다.');
   
   
}
  }
  
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
<script>



function handleEmailOption(selectBox) {
    var email2Container = document.getElementById("email2Container");
    

    if (selectBox.value === "") {
        email2Container.innerHTML = '<input type="text" class="form-control" name="users_email2" id="email2" placeholder="직접 입력">';
    } else {
        email2Container.innerHTML = '<select class="form-control" name="users_email2" id="email2" onchange="handleEmailOption(this)">' +
        '<option value="@naver.com" ${users.users_email2 eq '@naver.com' ? 'selected' : ''}>@naver.com</option>'
    	+'<option value="@daum.net" ${users.users_email2 eq '@daum.net' ? 'selected' : ''}>@daum.net</option>'
    	+'<option value="@gmail.com" ${users.users_email2 eq '@gmail.com' ? 'selected' : ''}>@gmail.com</option>'
    	+'<option value="@hanmail.com" ${users.users_email2 eq '@hanmail.com' ? 'selected' : ''}>@hanmail.com</option>'
    	+'<option value="@yahoo.co.kr" ${users.users_email2 eq '@yahoo.co.kr' ? 'selected' : ''}>@yahoo.co.kr</option>'
           '<option value="${users_users_email2 }" >직접 입력</option>'
           + '</select>';
    }
}






$(function(){	

	$(document).ready(function(){

		$('select[name=users_email2]').change(function() {

			if($(this).val()=="1"){

				$('#email2').val("");
				

			} else {

				$('#email2').val($(this).val());

				

			}

		});

	});

});





</script>
</head>
   <script>






 
</script>
<body>
<%@ include file="../../petmedic_navbar.jsp"%> 





   <div class="container structure myMainMenuWeb">
         <!-- 웹사이즈 메뉴 시작 -->
      <div id="menuDiv">
         <div class="row" id="flex">
             <div class="col-md-8 leftDiv">
					<h2>마이페이지</h2>
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

<!-- 마이페이지 시작 -->
<div class="container userInfoDiv">
 

	<form action="/updateInfo" method="post" id="updateuserinfo">
	
		<div class="div-updateusersinfo">
	
		<div class="row">
        	<div class="col div-col">
            	<input type="text" name="users_name" value="${users.users_name}" class="input-input" id="users_name" readonly>
        	</div>
        </div>
        <div class="row">
        	<div class="col div-col">
            	<input type="text" name="users_id" value="${users.users_id}" id="users_id" class="input-input" readonly>
       		</div>
        </div>

        <div class="row">
        	<div class="col div-col">
            	<input type="text" id="sample4_postcode" placeholder="우편번호" name="users_addr" value="${users.users_addr}" class="input-input" readonly>
        	</div>
        </div>
        <div class="row">
			<div class="col div-col">	            
				<input type="button" onclick="sample4_execDaumPostcode()" value="주소검색" class="btn-input">
	        </div>
	    </div>
        <div class="row">
	        <div class="col div-col">
	            <input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="users_addr2" value="${users.users_addr2}" class="input-input" readonly>
	        </div>
	     </div>
	    <div class="row">
        	<div class="col div-col">
            	<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="users_addr3" value="${users.users_addr3}" class="input-input" readonly>
        	</div>
        </div>
        <div class="row">
        	<div class="col div-col">
            	<input type="text" id="sample4_extraAddress" placeholder="참고항목" name="users_addr5" value="${users.users_addr5}" class="input-input" readonly>
        	</div>
        </div>
        <div class="row">
        	<div class="col div-col">
            	<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="users_addr4" value="${users.users_addr4}" class="input-input">
        	</div>
        	<span id="guide" style="color: #999; display: none"></span>
    	</div>
    	<div class="row">
        	<div class="col div-col">
            	<input type="text" name="users_email" id="email1" placeholder="이메일" value="${users.users_email}" class="input-input">
        	</div>
    	</div>
    	<div class="row">
        	<div class="col div-col" id="email2Container" >
            	<select name="users_email2" id="email2" class="input-input" onchange="handleEmailOption(this)" >
                	<option value="@naver.com" ${users.users_email2 eq '@naver.com' ? 'selected' : ''}>@naver.com</option>
                	<option value="@daum.net" ${users.users_email2 eq '@daum.net' ? 'selected' : ''}>@daum.net</option>
                	<option value="@gmail.com" ${users.users_email2 eq '@gmail.com' ? 'selected' : ''}>@gmail.com</option>
                	<option value="@hanmail.com" ${users.users_email2 eq '@hanmail.com' ? 'selected' : ''}>@hanmail.com</option>
                	<option value="@yahoo.co.kr" ${users.users_email2 eq '@yahoo.co.kr' ? 'selected' : ''}>@yahoo.co.kr</option>
					<option value="${users_users_email2 }">직접 입력</option>         	
<!-- 				받아오는건 못함 어케든 하겠지 -->
            	</select>
    		</div>
    	</div>	
    	<div class="row">
        	<div class="col div-col">
            	<input id="phoneNumber" type="text" name="users_tel" class="input-input" placeholder="전화번호" id="user" value="${users.users_tel}">
        	</div>
        </div>
        <div class="row">	
        	<div class="col div-col">
            	<input type="file" name="uploadFile" style="display:none;">
			</div>
		</div>
		
		<div class="div-btn">
			<input type="submit" value="수정" class="btn-submit">
			<button type="button" onclick="deleteInfo('${users.users_id}')" class="btn-submit">탈퇴</button>
<!-- form태그안에 있을때는 버튼의 type을 제거하면 , default가 submit임. form태그안에 있지 않은 경우는 type이 button이다. 그러므로 type을 꼭 써줘야한다 -->
		</div>
	</div>
</form>
</div>
</div>





 <%@ include file="../../footer.jsp"%>















</body>
</html>