<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<%@ include file="../../header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>병원등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hospital.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
#hosdivspan{
  color: black;
  border-radius: 5px 0 0 5px;
}

.hoslogin{
  width: 1000px;
  height: 100%;
  position: static;
  
}

.row a img{
  margin: 0 224px 0 224px; /* 메인가는 로고 중앙정렬*/
}

div.input-group.mb-3{
 margin-bottom: 0;
}
.col.hos_holdate{
  border: 1px solid #cccccc;
  
  }
.col.hos_aniAnimal{
 border: 1px solid #cccccc;
}
.col.hos_aniAnimal div{
    padding-left: 25px; 
}
.col.hos_holdate div{
   padding-left: 25px; 
} 
/* 반응형 시작*/
@media(max-width:1199px){
.col.hos_holdate{
  border: 1px solid #cccccc;
}
.col.hos_aniAnimal{
 border: 1px solid #cccccc;
 }
 
.inserthos{
 margin-left: 20px;
  }
#colid{ 
margin-right: -50px;
  }  
  
}


/* 반응형 끝*/

/*중복체크버튼 위치*/
#hos_id{ 
 padding-right: 180px;
}

#idCheck{
 background: #Fbbc04;
  border: none;
  color: white;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
} 

#idCheck:hover{
   background:  #5D3891;
   transform: scale(1.03); /* Increase the size by 10% */    
   background-color: #674ea7;
} 
#hos_pw{ 
 padding-right: 180px;
}
#hos_pw1{ 
 padding-right: 180px;
}

#formSubmit{
 background: #Fbbc04;
  border: none;
  color: white;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
} 

#formSubmit:hover{
   background:  #5D3891;
   transform: scale(1.03); /* Increase the size by 10% */    
   background-color: #674ea7;
}   
</style>


 <body class="inserthos">
 
<div class="container-fluid" id="hosadd">


		<div class="row">
		<a href="index.jsp"> 
		<img style="width: 160px; align-items: center;"src="${pageContext.request.contextPath}/img/PetMedicLogo_P.png"></a>
	     
			<h3 class="hname">병원정보를 등록해주세요</h3>
		</div>
		<!-- 파일 업로드 설정 반드시 메소드는 post로,enctype="multipart/form-data"를 추가 -->
		<!--   <form action="/insertHospital" method="post"> -->
		<form action="/insertHospital" method="post"
			enctype="multipart/form-data" id="hosform" onsubmit="return formSubmit()" novalidate>

			<%
			String hos_id = request.getParameter("hos_id");
			if (hos_id != null && !hos_id.isEmpty()) {
				// hos_id 값이 존재하는 경우
			} else {
				// hos_id 값이 존재하지 않는 경우
			}
			%>
			<div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text" id="hosspan">병원회원ID</span>
						</div>
					</div>
					<div class="col" >
						<input type="text" class="form-control innm" name="hos_id"
							placeholder="4~16자입니다." id="hos_id" style="text-align: left;" required>
							</div>									
					<div class="input-group-append" >
                             <button type="button" id="idCheck" class="btn btn-primary" onclick="checkDupId()" style="text-align: right;">중복체크</button>
                    </div>
				</div>
				<span id="idAlertSpan"></span>
                <input type="hidden" id="idCheckFlag" value="false" />
			</div>
			<div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">병원명</span>
						</div>
					</div>
					<div class="col">
						<input type="text" class="form-control innm" name="hos_name"
							placeholder="사용하실 병원명을 입력해주세요">
					</div>
				</div>
			</div>
			<div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">비밀번호</span>
						</div>   
					</div>
					<div class="col">
						<input type="password" class="form-control innm" id="hos_pw"
							name="hos_pw" pattern="[가-힣A-Za-z]{8,16}" required>
							<span></span>
					</div>
					<!-- <div class="input-group-append" >
                        <button type="button" id="formSubmit" class="btn btn-primary" onclick="passwordCheck1()" style="text-align: right;">중복체크</button>
                    </div> -->
				</div>
			</div>
			 <div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">비밀번호재확인</span>
						</div> 
					
			 		</div>
					<div class="col">
						<input type="password" class="form-control innm" id="hos_pw1"
							name="hos_pw1" placeholder="한번 더 입력해주세요." required>
					</div>	
					<!-- <div class="input-group-append" >
                        <button type="button" id="formSubmit" class="btn btn-primary" onclick="hos_pw">중복체크</button>
                    </div> -->
				</div>
			</div> 

			<div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">주소</span>							
						</div>					
					</div>
					
					<div class="col hos_adcol">
						
						<div class="col">
							<div class="col">
							<label for="address" class="address"></label> 
							<input type="text" class="form-control hos_zipcode" id="sample4_postcode"
								placeholder="우편번호" name="hos_addr" required> 
							</div>
							<div class="col">
							<input type="button" class="form-control hos_findZipcode"
								onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
							</div>
						</div>
							
						<div class="col">
							<input type="text" class="form-control hos_doroName"
								id="sample4_roadAddress" placeholder="도로명주소" name="hos_addr2">
							<input type="text" class="form-control hos_jibunName"
								id="sample4_jibunAddress" placeholder="지번주소" name="hos_addr3">
						</div>
						<div class="col">
							<input type="text" class="form-control hos_sangseName"
								id="sample4_detailAddress" placeholder="상세주소" name="hos_addr4">
							<input type="text" class="form-control hos_chamgo"
								id="sample4_extraAddress" placeholder="참고항목" name="hos_addr5">
						</div>							 
							
							
						<div class="invalid-feedback">필수 정보입니다.</div>
					</div>
				</div>
			</div>

    <div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">병원연락처</span>
						</div>
					</div>
					<div class="col">
						<input type="text" id="tlno"class="form-control innm" name="hos_tel"
							placeholder="형식: '-'없이 적어주세요." pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="12">
					</div>
				</div>
			</div>
			<script>
			var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}");
var res = patt.test( $("#tlno").val());

if( !patt.test( $("#tlno").val()) ){
    alert("전화번호를 정확히 입력하여 주십시오.");
    return false;
}
</script>
			

			<div class="row hosformrow">
				<div class="input-group mb-3 hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">진료시간</span>
						</div>
					</div>
					<div class="col hos_timetime">
						<select class="custom-select stime" name="hos_start">
							<option>07:00</option>
							<option>07:30</option>
							<option selected>08:00</option>
							<option>08:30</option>
							<option>09:00</option>
							<option>09:30</option>
							<option>10:00</option>
							<option>10:30</option>
							<option>11:00</option>
							<option>11:30</option>
							<option>12:00</option>
							<option>12:30</option>
							<option>13:00</option>
							<option>13:30</option>
							<option>14:00</option>
							<option>14:30</option>
							<option>15:00</option>
							<option>15:30</option>
							<option>16:00</option>
							<option>16:30</option>
							<option>17:00</option>
							<option>17:30</option>
							<option>18:00</option>
							<option>18:30</option>
							<option>19:00</option>
							<option>19:30</option>
							<option>20:00</option>
							<option>20:30</option>
							<option>21:00</option>
							<option>21:30</option>
							<option>22:00</option>
						</select> 
						<select class="custom-select stime" name="hos_end">
							<option>07:00</option>
							<option>07:30</option>
							<option>08:00</option>
							<option>08:30</option>
							<option>09:00</option>
							<option>09:30</option>
							<option>10:00</option>
							<option>10:30</option>
							<option>11:00</option>
							<option>11:30</option>
							<option>12:00</option>
							<option>12:30</option>
							<option>13:00</option>
							<option>13:30</option>
							<option>14:00</option>
							<option>14:30</option>
							<option>15:00</option>
							<option>15:30</option>
							<option>16:00</option>
							<option>16:30</option>
							<option>17:00</option>
							<option>17:30</option>
							<option selected>18:00</option>
							<option>18:30</option>
							<option>19:00</option>
							<option>19:30</option>
							<option>20:00</option>
							<option>20:30</option>
							<option>21:00</option>
							<option>21:30</option>
							<option>22:00</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row hosformrow">
				<div class="input-group mb-3 hosmb">
					<div class="col" id="hos_lunchbreak">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">점심시간</span>
						</div>
					</div>
					<div class="col" id="hos_lunchBTime">
						<select class="custom-select stime" name="hos_s_lunch">
							<option>10:00</option>
							<option>10:30</option>
							<option>11:00</option>
							<option>11:30</option>
							<option>12:00</option>
							<option>12:30</option>
							<option selected>13:00</option>
							<option>13:30</option>
							<option>14:00</option>
							<option>없음</option>
						</select> 
						<select class="custom-select stime" name="hos_e_lunch">
							<option>11:00</option>
							<option>11:30</option>
							<option>12:00</option>
							<option>12:30</option>
							<option>13:00</option>
							<option>13:30</option>
							<option selected>14:00</option>
							<option>14:30</option>
							<option>15:00</option>
							<option>없음</option>
						</select>
						</div>
					</div>
				</div>

			<div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">기본 진료비</span>
						</div>
					</div>
					<div class="col">
						<input type="text" class="form-control innm" name="hos_price" placeholder="숫자를 입력하시면 됩니다.">
					</div>
				</div>
			</div>

			<div class="row hosformrow">
				<div class="input-group mb-3 hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">휴일</span>
						</div>
					</div>
					<div class="col hos_holdate">
						<div class="custom-control custom-checkbox">
					<label><input type="checkbox" name="hos_hol" value="월">월</label>	
						</div>
						<div class="custom-control custom-checkbox">
				      <label><input type="checkbox" name="hos_hol" value="화">화</label>					
						</div>
						<div class="custom-control custom-checkbox">
				       <label><input type="checkbox" name="hos_hol" value="수">수</label>	
						</div>
						<div class="custom-control custom-checkbox">
					<label><input type="checkbox" name="hos_hol" value="목">목</label>					
						</div>
						<div class="custom-control custom-checkbox">
					   <label><input type="checkbox" name="hos_hol" value="금">금</label>							
						</div>
						<div class="custom-control custom-checkbox">						
				       <label><input type="checkbox" name="hos_hol" value="토">토</label>						
						</div>
						<div class="custom-control custom-checkbox">						
							<label><input type="checkbox" name="hos_hol" value="일">일</label>
						</div>
					</div>
				</div>
			</div>

			<div class="row hosformrow">
				<div class="input-group mb-3 hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">진료동물</span>
						</div>
					</div>
					<div class="col hos_aniAnimal">
						<div class="custom-control custom-checkbox">
							<label><input type="checkbox" name="hos_cate" value="강아지">강아지</label>
						</div>
						<div class="custom-control custom-checkbox">
						<label><input type="checkbox" name="hos_cate" value="고양이">고양이</label>
						</div>
						<div class="custom-control custom-checkbox">
							<label><input type="checkbox" name="hos_cate" value="새">새</label>
						</div>
						<div class="custom-control custom-checkbox">
						    <label><input type="checkbox" name="hos_cate" value="파충">파충류</label> 
						</div>
						<div class="custom-control custom-checkbox">
							<label><input type="checkbox" name="hos_cate" value="기타">기타동물</label>
						</div>
					</div>
				</div>
			</div>

			<div class="row hosformrow">
				<div class="input-group mb-3" id="hosmb">
					<div class="col">
						<div class="input-group-prepend" id="hosdivspan">
							<span class="input-group-text">병원사이트</span>
						</div>
					</div>
					<div class="col">
						<input type="text" class="form-control innm" name="hos_url"
							pattern="(([\w-]+\.)+[\w-]+(/[.\w-]*)*"
							placeholder="예시) www.naver.com">
					</div>
				</div>
			</div>
    <div class="row hosformrow">
    <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">증명자료등록</span>
      </div>
      <input type="file" class="form-control innm" name="uploadFile" title="pdf파일만 가능합니다." accept=".pdf"> 
    </div>
    </div>
    <div class="row hosformrow">
    <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
      <span class="input-group-text">병원사진등록</span>           
      </div>
      <div class="col">
      <input type="file" class="form-control innm" name="uploadFile1" title="사진이나 이미지를 등록해주세요." accept=".jpg, .png" >     
    </div>
   </div> 
 </div>
    <div class="row hosformrow">
    <div class="input-group mb-3">
    <div class="col">
      <div class="input-group-prepend" id="hosdivspan" >
        <span class="input-group-text">승인여부</span>
      </div>
      <input type="text" class="form-control innm" name="hos_role" placeholder="관리자의 승인 후 목록에 등록됩니다." readonly>          
    </div>
     </div>
      <h3 class="hend"></h3>
   </div> 
   
         
    <div id="footer">
	  	<button id="addhospital" type="submit" class="btn btn-primary">승인요청</button>
	 </div>
   </form>
  </div>
  
  
  </div>
  <script type="text/javascript">
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if (roadAddr !== '') {
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
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
            addressCheck();
        }
    }).open();
}

//병원아이디 중복확인
function idCheck() {
        const id = $("#hos_id");
        const idAlertSpan = $("#idAlertSpan");
        const idCheckFlag = $("#idCheckFlag");
        
        if (id.val().trim() === "") {
            idAlertSpan.html("아이디를 입력하십시오.").css("color","red");
            id.focus();
            return false;
        } else {
            idAlertSpan.html("");
        }

        if (id.val().length < 4 || id.val().length > 20) {
            idAlertSpan.html("아이디는 4자이상 20자이하로 입력하십시오.").css("color","red");
            id.focus();
            return false;
        } else {
            idAlertSpan.html("");
        }

        if (idCheckFlag.val() === "false") {
            idAlertSpan.html("아이디 중복체크를 하십시오.").css("color","red");
            return false;
        } else {
            idAlertSpan.html("");
        }

        return true;
    }

    function passwordCheck1() {
        const passwordInput = $("#hos_pw");
        // 비밀번호 유효성 검사
        if (passwordInput.val().trim() === "") {
            passwordInput.next().text("비밀번호를 입력하십시오.").css("color","red");
            passwordInput.focus();
            return false;
        } else {
            passwordInput.next().text("");
        }

        if (passwordInput.val().length < 8 || passwordInput.val().length > 16) {
            passwordInput.next().text("비밀번호는 8자이상 16자이하로 입력하십시오.").css("color","red");
            passwordInput.focus();
            return false;
        } else {
            passwordInput.next().text("");
        }
        return true;
    }

    function passwordCheck2() {
        const password1Input = $("#hos_pw1");
        if (password1Input.val().trim() === "") {
            password1Input.next().text("비밀번호 확인을 입력하십시오").css("color","red");
            password1Input.focus();
            return false;
        } else {
            password1Input.next().text("");
        }

        if (password1Input.val().length < 8 || password1Input.val().length > 16) {
            password1Input.next().text("비밀번호는 8자이상 16자이하로 입력하십시오.").css("color","red");
            password1Input.focus();
            return false;
        } else {
            password1Input.next().text("");
        }
        return true;
    }
    
    

    function addressCheck() {
        const addressInput = $("#sample4_postcode");
        const addressAlert = $("#addressAlert");
        // 주소 유효성 검사
        if (addressInput.val().trim() === "") {
            addressAlert.html("주소검색 버튼을 클릭하여 주소를 검색 후 입력하십시오.").css("color","red");
            return false;
        } else {
            addressAlert.html("");
        }
        return true;
    }
    
    
    function formSubmit() {
        const passwordInput = $("#hos_pw");
        const password1Input = $("#hos_pw1");

        var checkFlag = true;

        if (!idCheck()) checkFlag = false;
        if (!passwordCheck1()) checkFlag = false;
        if (!passwordCheck2()) checkFlag = false;

        if (passwordInput.val().trim() !== password1Input.val().trim()) {
            password1Input.next().text("비밀번호가 일치하지 않습니다.").css("color","red");
            password1Input.focus();
            checkFlag = false;
        } else {
            password1Input.next().text("");
        }

        if (!nameCheck()) checkFlag = false;
        if (!phoneCheck()) checkFlag = false;
        if (!addressCheck()) checkFlag = false;
        if (!emailCheck()) checkFlag = false;

        return checkFlag == true;
    }

    function isInputEmptyCheck(id, msg) {
        var value = $("#" + id).val();
        if (value == null || value == "") {
            alert(msg);
            $("#" + id).focus();
            return false;
        }
        return true;
    }
  //아이디 중복확인
    function checkDupId() {
        const id = $("#hos_id");
        const idAlertSpan = $("#idAlertSpan");
        const idCheckFlag = $("#idCheckFlag");

        if (id.val().trim() === "") {
            idAlertSpan.html("아이디를 입력하십시오.").css("color","red");  // .css({"color":"red"}) -> 여러개 나열 할 때 오브젝트 방식임
            id.focus();
            return false;
        } else {
            idAlertSpan.html("")
        }

        if (id.val().length < 4 || id.val().length > 16) {
            idAlertSpan.html("아이디는 4자이상 16자이하로 입력하십시오.").css("color","red");
            id.focus();
            return false;
        } else {
            idAlertSpan.html("");
        }


        $.ajax({
            method: "POST",
            url: "idDupCheck",
            data: {"hos_id": id.val()},
            cache: false,
            success: function (data) {
                if (data) {
                    idAlertSpan.html("사용가능한 ID입니다.").css("color","green");
                    idCheckFlag.val("true");
                } else {
                    idAlertSpan.html("중복된 ID입니다.").css("color","red");
                    idCheckFlag.val("false");
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }
</script>

</body>
</html>
