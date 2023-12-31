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
.input-group-text {
	width:125px;
	text-align: right;	
}
.mobileinputboxinsertdoc{
width:100%;
}
.labelbox{
width:100%;
}
.submitbutton{

width:120px; 
height:50px; 
background-color:#fbbc04; 
color:white; 
border:0; 
border-radius:5px;
margin-top: 5px;
}

.submitbutton:hover{
background-color:#674ea7;
}
</style>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>

<div class="container structure" >
		<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h2>의사등록</h2></div>
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
            <div class="col"><h3><strong>의사 등록</strong></h3></div>
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
	<div class="container-fluid" style="width:90%">
		<div class="container webinputbox">
		<form action="updDoc" method="POST" enctype="multipart/form-data">
			<div class="input-group mb-3"	>
				<div class="input-group-prepend">
					<span class="input-group-text" style="width:120px;">병원 아이디: </span>
				</div>
				<input type="text" class="form-control innm" name="doc_hos_id" value="${doc.doc_hos_id}" readonly required>
			</div>
			<br>
			<div class="input-group mb-3"	>
			<div class="input-group-prepend">
				<span class="input-group-text" style="width:120px;">의사 아이디: </span>
			</div>
				<input type="text" class="form-control innm" name="doc_id" value="${doc.doc_id}" readonly required>
			</div>
			<br>
			<div class="input-group mb-3"	>
			<div class="input-group-prepend">
				<span class="input-group-text" style="width:120px;">사진: </span>
			</div>
				<input type="file" class="form-control" name="uploadFile">
			</div>
			<br>
			<div class="input-group mb-3"	>
				<div class="input-group-prepend">
					<span class="input-group-text" style="width:120px;">성명: </span>
				</div>
				<input type="text" class="form-control innm" name="doc_name"  value="${doc.doc_name}" required>
			</div>
			<br>
			<div class="input-group mb-3"	>
				<div class="input-group-prepend">
					<span class="input-group-text" style="width:120px;">소개글: </span>
				</div>
				
				<textarea style="margin:0; resize: none;" class="form-control innm" name = "doc_info" required >${doc.doc_info}</textarea>
			</div>
			
			<br>
			
			<!-- 	<input type="text" style ="height:100%" value = ${doc.doc_info}> -->
			<div style="text-align: center;">
			<input class="submitbutton" type="submit" value="추가하기">
			</div>
			</form>
			</div>
			
		<div class="container mobileinputbox">
		<form action="updDoc" method="POST" enctype="multipart/form-data">
			<div class="input-group mb-3"	>
				<div class="labelbox">
					<span class="input-group-text" style="width:100%; display:block; text-align:left;">병원 아이디: </span>
				</div>
				<div class="mobileinputboxinsertdoc">
				<input type="text" class="form-control innm" name="doc_hos_id" value="${doc.doc_hos_id}" readonly required>
				</div>
			</div>
			<br>
			<div class="input-group mb-3"	>
			<div class="labelbox">
				<span class="input-group-text" style="width:100%; display:block; text-align:left;">의사 아이디: </span>
			</div>
			<div class="mobileinputboxinsertdoc">
				<input type="text" class="form-control innm" name="doc_id" value="${doc.doc_name}" readonly required>
				</div>
			</div>
			<br>
			<div class="input-group mb-3"	>
			<div class="labelbox">
				<span class="input-group-text" style="width:100%; display:block; text-align:left;">사진: </span>
			</div>
			<div class="mobileinputboxinsertdoc">
				<input type="file" class="form-control" name="uploadFile" required>
				</div>
			</div>
			<br>
			<div class="input-group mb-3"	>
				<div class="labelbox">
					<span class="input-group-text" style="width:100%; display:block; text-align:left;">성명: </span>
				</div>
				<div class="mobileinputboxinsertdoc">
				<input type="text" class="form-control innm" name="doc_name" value="${doc.doc_name}" required>
				</div>
			</div>
			<br>
			<div class="input-group mb-3"	>
				<div class="labelbox">
					<span class="input-group-text" style="width:100%; display:block; text-align:left;">소개글: </span>
				</div>
				<div class="mobileinputboxinsertdoc">
				<textarea style="margin:0; resize: none;" class="form-control innm" name = "doc_info"  required >${doc.doc_info}</textarea>
				</div>
			</div>
			
			<br>
			
			<!-- 	<input type="text" style ="height:100%" value = ${doc.doc_info}> -->
			<div style="text-align: center;">
			<input class="submitbutton" type="submit" value="추가하기">
			</div>
		</form>
			</div>
	</div>
</div>
	<%@ include file="../../footer.jsp"%>
</body>
</html>