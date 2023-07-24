<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../header.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.hosUpdate{
width:120px; 
height:50px; 
background-color:#fbbc04; 
color:white; 
border:0; 
border-radius:5px;
margin-top: 5px;
}

.buttons{
	text-align: center;
}

.hosUpdate:hover{
background-color:#674ea7;
}

input {
	accent-color: #F99417;
}

.input-group-text {
	width:125px;
}
.hospitalLabel {
	 padding-top: 8px;
	 padding-left: 3px;
}
.mobileHospitalLabel {
	 padding-top: 8px;
	 padding-left: 5px;
}

.hospitalCheckbox{
	width: 15px;
	height: 15px;
}
.mobileinputboxhosupdate{
width:100%;
}
.labelbox{
width:100%;
}
</style>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>
<div class="container structure" >
	<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h3><strong>정보수정</strong></h3></div>
			<div class="col-md-4 rightDiv">
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='myHos'" style="padding:15px;"><b>내<br>병원</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='toHosUpdate'" style="padding:15px;"><b>정보<br>수정</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='docList'" style="padding:12px;"><b>의사<br>관리</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='resList'" style="padding:15px;"><b>예약<br>보기</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='toHosReview'" style="padding:12px;"><b>리뷰<br>조회</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
			</div>
		</div>
	</div>
<!-- 	웹에서 보이는 메뉴 끝 -->
	
<!-- 	반응형 모바일 메뉴 시작 -->
	<div class="container mobileMyMenu">
         <div class="row mobileMytitle">
            <div class="col"><h3><strong>병원정보수정</strong></h3></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='myHos'">
               <b>내 병원</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosUpdate'">
               <b>정보<br>수정</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='docList'">
               <b>의사<br> 관리</b>
               </div>
            </div>
         </div>
         <div class="row mobileMy_memu mobileMymemu2">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='resList'">
               <b>예약<br>보기</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosReview'">
               <b>리뷰<br>조회</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosMyPage'">
                  마이<br>메인
               </div>
            </div>
         </div>
      </div>
<!--       반응형 마이 메뉴 끝 -->
	<br>
	<br>
	<div class="container-fluid hosUpdatecontainer">
		<!-- 파일 업로드 설정 반드시 메소드는 post로,enctype="multipart/form-data"를 추가 -->
		<!--   <form action="insertHospital" method="post"> -->
		<div class="webinputs">
		<form action="updHos" method="post" enctype="multipart/form-data">
				<div class="input-group mb-3"	>
					<div class="input-group-prepend">
						<span class="input-group-text">아이디</span>
					</div>
					<input type="text" class="form-control innm" name="hos_id"
						value="${hos.hos_id}" readonly="readonly">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">병원명</span>
					</div>
					<input type="text" class="form-control innm" name="hos_name"
						placeholder="병원명을 입력해주세요" value="${hos.hos_name}">
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text">병원주소</span>
					</div><br>
					<div class="mobileinputboxhosupdate">
						
					<div class="form-group">
                        <div class="input-group">
                            <div class="input-group">
                                <input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" name="hos_addr" value="${hos.hos_addr}" required readonly>
                                <div class="input-group-append">
                                    <input type="button" class="btn btn-primary" id="joinaddr" onclick="sample4_execDaumPostcode()" value="주소검색">
                                </div>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_roadAddress" placeholder="도로명주소" name="hos_addr2" value="${hos.hos_addr2}" readonly>
                                <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" name="hos_addr3" value="${hos.hos_addr3}" readonly>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_extraAddress" placeholder="참고항목" name="hos_addr5" value="${hos.hos_addr5}" readonly>
                                <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" name="hos_addr4" value="${hos.hos_addr4}">
                            </div>

                            <span id="guide" style="color: #999; display: none"></span>
                        </div>
                        <span id="addressAlert"></span>
                    </div>
                    </div>
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">병원연락처</span>
					</div>
					<input type="text" class="form-control innm" name="hos_tel" placeholder="대표 연락처를 입력해주세요." value="${hos.hos_tel}">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">진료시간</span>
					</div>
					<input type="text" class="form-control innm" name="hos_start" placeholder="진료 시작시간" value="${hos.hos_start}"> 
					~
					<input type="text" class="form-control innm" name="hos_end" placeholder="진료 종료시간" value="${hos.hos_end}">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">휴일</span>
					</div>
					<div class="webHospitalLabel">
						<label class="hospitalLabel" style="padding-left: 15px;"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="0" <c:if test="${hos.hos_hol.indexOf('0') > -1 }">checked</c:if>> 월요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="1" <c:if test="${hos.hos_hol.indexOf('1') > -1 }">checked</c:if>> 화요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="2" <c:if test="${hos.hos_hol.indexOf('2') > -1 }">checked</c:if>> 수요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="3" <c:if test="${hos.hos_hol.indexOf('3') > -1 }">checked</c:if>> 목요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="4" <c:if test="${hos.hos_hol.indexOf('4') > -1 }">checked</c:if>> 금요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="5" <c:if test="${hos.hos_hol.indexOf('5') > -1 }">checked</c:if>> 토요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="6" <c:if test="${hos.hos_hol.indexOf('6') > -1 }">checked</c:if>> 일요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="7" <c:if test="${hos.hos_hol.indexOf('7') > -1 }">checked</c:if>> 공휴일</label> 
					</div>
					
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">점심시간</span>
					</div>
					<input type="text" class="form-control innm" name="hos_s_lunch" placeholder="점심시간 시작" value="${hos.hos_s_lunch}">
					~
					<input type="text" class="form-control innm" name="hos_e_lunch" placeholder="점심시간 종료" value="${hos.hos_e_lunch}">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">진료동물</span>
					</div>
					<label class="hospitalLabel" style="padding-left: 15px;"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="개" <c:if test="${hos.hos_cate.indexOf('개') > -1 }">checked</c:if>>개</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="고양이" <c:if test="${hos.hos_cate.indexOf('고양이') > -1 }">checked</c:if>>고양이</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="새" <c:if test="${hos.hos_cate.indexOf('새') > -1 }">checked</c:if>>새</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="파충류" <c:if test="${hos.hos_cate.indexOf('파충류') > -1 }">checked</c:if>>파충류</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="기타동물" <c:if test="${hos.hos_cate.indexOf('기타동물') > -1 }">checked</c:if>>기타동물</label>
					<br>
				</div>
				<div class="input-group mb-3">
               <div class="input-group-prepend">
                  <span class="input-group-text">기본 진료비</span>
               </div>
               <input type="text" pattern="[0-9]+" class="form-control innm" placeholder="기호를 제외한 숫자만 입력하세요." name="hos_price"
                  value="${hos.hos_price}">
            </div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">병원사이트</span>
					</div>
					<input type="text" class="form-control innm" name="hos_url"
						placeholder="www.example.com">
				</div>
				<div class="input-group mb-3"	>
				<div class="input-group-prepend">
					<span class="input-group-text">사진: </span>
				</div>
					<input type="file" class="form-control" name="uploadFile" value="${hos.filename}">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">승인여부</span>
					</div>
				<input type="text" class="form-control innm" name="hos_role"
					value="${hos.hos_role}" placeholder="관리자의 승인 후 목록에 등록됩니다." readonly>
			</div>
			<br>
			<div class="buttons">
				<input type="submit" class="hosUpdate" value="수정하기">
				<input type="button" class="hosUpdate" onclick="location.href='toHosMyPage'" value="취소하기">
			</div>
			</form>
		</div> 
			
		<div class="mobileinputs">
		<form action="updHos" method="post" enctype="multipart/form-data">
				<div class="input-group mb-3"	>
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">아이디</span>
					</div>
					<br>
					<div class="mobileinputboxhosupdate">
					<input type="text" style="width:100%" class="form-control innm" name="hos_id"
						value="${hos.hos_id}" readonly="readonly">
						</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">병원명</span>
					</div><br>
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_name"
						placeholder="병원명을 입력해주세요" value="${hos.hos_name}">
						</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">병원주소</span>
					</div><br>
					<div class="mobileinputboxhosupdate">
						
					<div class="form-group">
                        <div class="input-group">
                            <div class="input-group">
                                <input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" name="hos_addr" value="${hos.hos_addr}" required readonly>
                                <div class="input-group-append">
                                    <input type="button" class="btn btn-primary" id="joinaddr" onclick="sample4_execDaumPostcode()" value="주소검색">
                                </div>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_roadAddress" placeholder="도로명주소" name="hos_addr2" value="${hos.hos_addr2}" readonly>
                                <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" name="hos_addr3" value="${hos.hos_addr3}" readonly>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_extraAddress" placeholder="참고항목" name="hos_addr5" value="${hos.hos_addr5}" readonly>
                                <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" name="hos_addr4" value="${hos.hos_addr4}">
                            </div>

                            <span id="guide" style="color: #999; display: none"></span>
                        </div>
                        <span id="addressAlert"></span>
                    </div>
                    </div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">병원연락처</span>
					</div><br>
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_tel" placeholder="대표 연락처를 입력해주세요." value="${hos.hos_tel}">
					</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">진료시간</span>
					</div><br>
					<div class="mobiletimebox" style="width:100%">
						<table style="width:100%;">
							<tr>
							<td>
							<input type="text"  class="form-control innm" name="hos_start" placeholder="진료 시작시간" value="${hos.hos_start}"> 
							</td><td>
							~
							</td><td>
							<input type="text"  class="form-control innm" name="hos_end" placeholder="진료 종료시간" value="${hos.hos_end}">
							</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">휴일</span>
					</div><br>
					<div class="mobileHospitalLabeldiv" style="margin:0 auto;">
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="0" <c:if test="${hos.hos_hol.indexOf('0') > -1 }">checked</c:if>> 월요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="1" <c:if test="${hos.hos_hol.indexOf('1') > -1 }">checked</c:if>> 화요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="2" <c:if test="${hos.hos_hol.indexOf('2') > -1 }">checked</c:if>> 수요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="3" <c:if test="${hos.hos_hol.indexOf('3') > -1 }">checked</c:if>> 목요일</label> 
						<br>
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="4" <c:if test="${hos.hos_hol.indexOf('4') > -1 }">checked</c:if>> 금요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="5" <c:if test="${hos.hos_hol.indexOf('5') > -1 }">checked</c:if>> 토요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="6" <c:if test="${hos.hos_hol.indexOf('6') > -1 }">checked</c:if>> 일요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="7" <c:if test="${hos.hos_hol.indexOf('7') > -1 }">checked</c:if>> 공휴일</label> 
					</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">점심시간</span>
					</div><br>
					<div class="mobiletimebox" style="width:100%">
						<table style="width:100%;">
							<tr>
							<td>
							<input type="text" class="form-control innm" name="hos_s_lunch" placeholder="점심시간 시작" value="${hos.hos_s_lunch}">
							</td><td>
							~
							</td><td>
							<input type="text" class="form-control innm" name="hos_e_lunch" placeholder="점심시간 종료" value="${hos.hos_e_lunch}">
							</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">진료동물</span>
					</div><br>
					<div class="mobileHospitalLabeldiv" style="display:block;margin:0 auto;">
					<label class="mobileHospitalLabel" style="padding-left: 10px;"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="개" <c:if test="${hos.hos_cate.indexOf('개') > -1 }">checked</c:if>>개</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="고양이" <c:if test="${hos.hos_cate.indexOf('고양이') > -1 }">checked</c:if>>고양이</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="새" <c:if test="${hos.hos_cate.indexOf('새') > -1 }">checked</c:if>>새</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="파충류" <c:if test="${hos.hos_cate.indexOf('파충류') > -1 }">checked</c:if>>파충류</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="기타동물" <c:if test="${hos.hos_cate.indexOf('기타동물') > -1 }">checked</c:if>>기타동물</label>
					</div>
					<br>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">기본 진료비</span>
					</div><br>
					<div class="mobileinputboxhosupdate">
					<input type="text" pattern="[0-9]+" class="form-control innm" placeholder="기호를 제외한 숫자만 입력하세요." name="hos_price"
						value="${hos.hos_price}">
						</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">병원사이트</span>
					</div><br>
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_url"
						placeholder="www.example.com">
						</div>
				</div>
				<div class="input-group mb-3"	>
				<div class="labelbox">
					<span class="input-group-text" style="width:100%; display:block; text-align:left;">사진: </span>
				</div><br>
				<div class="mobileinputboxhosupdate">
					<input type="file" class="form-control" name="uploadFile" value="${hos.filename}" required>
					</div>
				</div>
				<div class="input-group mb-3">
					<div class="labelbox">
						<span class="input-group-text" style="width:100%; display:block; text-align:left;">승인여부</span>
					</div><br>
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_role"
					value="${hos.hos_role}" placeholder="관리자의 승인 후 목록에 등록됩니다." readonly>
					</div>
				</div>
			
			<br>
			<div class="buttons">
				<input type="submit" class="hosUpdate" value="수정하기">
				<input type="button" class="hosUpdate" onclick="location.href='toHosMyPage'" value="취소하기">
			</div>
		</form>
			</div>
	</div>
	</div>
	<script>
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
    }
	</script>
	<%@ include file="../../footer.jsp"%>
</body>
</html>










