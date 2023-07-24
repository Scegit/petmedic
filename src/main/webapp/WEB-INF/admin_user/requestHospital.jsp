<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="adminPage.jsp" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.*,
javax.servlet.http.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="java.sql.*" %>
<c:set var="action" value="edit" /> <!-- 수정 작업을 수행할 경우 -->
<%-- c:set 태그를 사용하여 action 변수를 설정합니다. --%>
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hospital.css">
  
<style>
#addhospital{
  background: #Fbbc04;
}
#hosid{
  width: 100%;
  border-radius: 3px;
  border: 1px solid #878ECD;
  text-align: center;
  
}

body{
  padding-left: 200px;
  padding-right: 200px;
}


#hosdivspan{
  color: black;
  border-radius: 5px 0 0 5px;
}
.form-control.innm{
  border: 1px solid #878ECD;
  margin-bottom: 0;
}
#hosmb label{
   border-top: 1px solid #878ECD;
   border-bottom: 1px solid #878ECD;
}

div.hosmb {
    border: 1px solid #878ECD;
    border-radius: 5px;
    background: #DDE7F2;
    
}
#stime{
  border-radius: 0px;
  border: 1px solid #878ECD;
  borde-right: 0px;
}
#etime{
 border-radius: 0 3px 3px 0;
 borde-left: 0px;
}
input.form-control.innm {
    border: 1px solid #878ECD;
    background:  #DDE7F2;
    justify-content: center;
    text-align: center;
} 

.btn.btn-primary{
  background: #Fbbc04;
}
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



</style>  
  
</head>
<body>
<script>
 <%-- 역할권한에 따른 페이지사용제한 설정 --%>
/* //필요한 패키지 import
 const express = require('express');
 const multer = require('multer');
 const path = require('path');

 // Express 앱 생성
 const app = express();
 const port = 8090;

 // 파일 업로드를 처리할 Multer 미들웨어 생성
 const upload = multer({ dest: 'uploads/' }); // 업로드된 파일을 uploads/ 폴더에 저장

 // 업로드된 PDF 파일 확인 라우트 정의
 app.get('/uploads/:filename', (req, res) => {
   const fileName = req.params.filename;
   const filePath = path.join('c:/Swork/petmedic/src/main/webapp/resources/pdf/', fileName);

   // 업로드된 PDF 파일을 확인하고 싶다면 해당 파일을 읽어서 클라이언트에 전송합니다.
   res.sendFile(filePath);
 });

 // 업로드 처리 라우트 정의
 app.post('/upload', upload.single('file'), (req, res) => {
   // 업로드된 파일 정보는 req.file 객체에 저장됩니다.
   if (!req.file) {
     return res.status(400).send('파일을 업로드해야 합니다.');
   }

   // 파일 업로드 성공 시
   res.send('파일이 성공적으로 업로드되었습니다.');
 });

 // 서버 시작
 app.listen(port, () => {
   console.log(`서버가 http://localhost:${port} 에서 실행 중입니다.`);
 }); */
</script>

<script>
<%

// try {

//   // 파일 업로드 처리
//   String uploadPath = "c:/Swork/petmedic/src/main/webapp/resources/pdf/";
//   String fileName = "";
//   String contentType = "";

//   if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
//     FileItemFactory factory = new DiskFileItemFactory();
//     ServletFileUpload upload = new ServletFileUpload(factory);
//     List<FileItem> items = upload.parseRequest(request);

//     for (FileItem item : items) {
//       if (!item.isFormField()) {
//         fileName = item.getName();
//         contentType = item.getContentType();
//         File uploadedFile = new File(uploadPath + fileName);
//         item.write(uploadedFile);
//       }
//     }
//   }

  // 파일명을 데이터베이스에 저장 (hos_file 컬럼에 파일명 저장)
//   String query = "INSERT INTO hospital (hos_file) VALUES (?)";
//   PreparedStatement pstmt = connection.prepareStatement(query);
//   pstmt.setString(1, fileName);
//   pstmt.executeUpdate();

  // 파일 확인을 위해 다운로드 경로 생성
//   String downloadPath = request.getContextPath() + "/resources/pdf/" + fileName;
 %> 
</script> 



<body class="inserthos">

<div class="container-fluid" id="hosadd">

  <div class="row">
		<a href="index.jsp"> 
		<img style="width: 160px; align-items: center;"src="${pageContext.request.contextPath}/img/PetMedicLogo_P.png"></a>
	     
			<h3 class="hname">승인요청한 병원정보</h3>
		</div>
		
	
  <%-- 파일 추가 영역 --%>
     <div class="row hosformrow">
     <div class="input-group mb-3" id="hosmb">
     <div class="col">
      <div class="input-group-prepend" id="hosdivspan">
        </div></div>
            <img src="${pageContext.request.contextPath}/img/${hospital.hos_pic}" alt="${hospital.hos_pic}" style="display: block; width: 100%;">
      </div></div>
  <div class="row hosformrow">
	<div class="input-group mb-3" id="hosmb">
    <div class="col">
    <div class="input-group-prepend" id="hosdivspan">
   <span class="input-group-text" >등록된 아이디</span>
	</div></div> 
	  <div class="col">                										
  <input type="text" name="hos_id" value="${hospital.hos_id}" id="hosid" readonly>
    </div></div></div> 
   
<div class="row hosformrow">
    <div class="input-group mb-3" id="hosmb">
    <div class="col" >	
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">병원명</span>
      </div></div>
      <div class="col" >
      <input type="text" class="form-control innm" name="hos_name" value="${hospital.hos_name}" readonly<%//=sts %>>      
    </div></div></div>
    
    <div class="row hosformrow">
    <div class="input-group mb-3" id="hosmb">
      <div class="col">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">연락처</span>
      </div></div>
      <div class="col" >
      <input type="text" class="form-control innm" name="hos_tel" value="${hospital.hos_tel}" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" readonly<%//=sts %>>
      <p id="convertedPhoneNumber"></p>      
    </div></div>
    </div>
    
    <div class="row hosformrow">
    <div class="input-group mb-3" id="hosmb">
    	<div class="col">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">위치</span>
      </div></div>
      <div class="col">
      <input type="text" class="form-control innm" name="hos_addr2" value="${hospital.hos_addr2}" readonly <%//=sts %>> 
    </div></div></div>
     <div class="row hosformrow">
    <div class="input-group mb-3" id="hosmb">
     <div class="col">     
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">사이트</span>
      </div></div>
      <div class="col">
      <input type="button" class="form-control innm" name="hos_url" value="${hospital.hos_url}" onclick="location.href='${hospital.hos_url}'" readonly<%//=sts%>> 
      <%-- onclick="location.href='https://${hospital.hos_url}'" 이렇게 부여시 해당 주소에 https:// 가 더해져서 이동가능 --%>   
    </div></div></div>
    <div class="row hosformrow">    
    <div class="input-group mb-3" id="hosmb">
    <div class="col">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">진료동물</span>
      </div></div>
       <div class="col">
      <input type="text" class="form-control innm" name="hos_cate" value="${hospital.hos_cate}" readonly <%//=sts %>>      
    </div></div></div>
    <div class="row hosformrow">
    <div class="input-group mb-3"id="hosmb">
    <div class="col">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">진료시간</span>
      </div></div>
      <div class="col">
      <input type="text" class="form-control innm" id="stime" name="hos_start" value="${fn:substring(hospital.hos_start,0,5)}" readonly <%//=sts%>>
      <input type="text" class="form-control innm" id="etime" name="hos_end" value="${fn:substring(hospital.hos_end,0,5)}" readonly>      
    </div></div></div>
    <div class="row hosformrow">
      <div class="input-group mb-3" id="hosmb">
      <div class="col">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">점심시간</span>
      </div></div>
      <input type="text" class="form-control innm" name="hos_s_lunch" id="stime" value="${fn:substring(hospital.hos_s_lunch,0,5)}" readonly >
      <input type="text" class="form-control innm" name="hos_e_lunch" id="etime" value="${fn:substring(hospital.hos_e_lunch,0,5)}" readonly >      
    </div></div>
    <div class="row hosformrow">
    <div class="input-group mb-3" id="hosmb">
     <div class="col">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">진료비</span>
      </div></div>
      <div class="col">
      <input type="text" class="form-control innm" name="hos_price" value="${hospital.hos_price}" readonly <%//=sts %> 
      placeholder="병원마다 진료결과에 따라 진료비는 추가될 수 있습니다.">      
    </div></div></div>
    <div class="row hosformrow">
      <div class="input-group mb-3" id="hosmb">
      <div class="col">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text" >휴일</span>
      </div></div>
      <div class="col">  
      <input type="text" class="form-control innm" name="hos_hol" value="${hospital.hos_hol}" readonly <% //sts%>>      
    </div></div></div>
   	  <div class="row hosformrow">
      <div class="input-group mb-3" id="hosmb">
      <div class="col">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text" >제출증명자료</span>
      </div></div>
      <div class="col"> 
      <input type="file" class="form-control innm" name="hos_file" value="${hospital.hos_file}" accept=".pdf"  style="background: white;"
        readonly>
    </div></div></div>
 <script>
 var fileInput = document.querySelector('input[name="hos_file"]');
 var hosFile = '${hospital.hos_file}';  // 서버에서 전달된 hos_file 변수의 값

 if (hosFile !== null && hosFile !== '') {
   fileInput.setAttribute('value', hosFile);  // 파일 이름을 설정
 } else {
   fileInput.setAttribute('placeholder', '선택된 파일이 없습니다.');  // 파일이 선택되지 않은 경우 문구 표시
 }
  </script> 	   
      <div class="row hosformrow">  
      <div class="input-group mb-3" id="hosmb">
      <div class="col">
    <div class="input-group-prepend" id="hosdivspan">    
     <span class="input-group-text">인증여부</span> 
         </div></div>  
         <div class="col">       
        <input type="text" class="form-control innm" name="hos_role"  value="${hospital.hos_role}" placeholder="승인된 병원입니다." readonly>   
      </div></div>
     <h3 class=hend></h3>
    </div> 
     




<script>

if ('${hospital.hos_file}' === '') {
    document.querySelector('input[name="hos_file"]').value = '${hospital.hos_file}';
  }
if ('${hospital.hos_url}' === '') {
    document.querySelector('input[name="hos_url"]').value = '작성되지 않았습니다.';
  }
  if ('${hospital.hos_hol}' === '') {
    document.querySelector('input[name="hos_hol"]').value = '쉬는날이 없습니다.';
  }
  if ('${hospital.hos_pic}' === null) {
	    document.querySelector('input[name="hos_pic"]').value = '등록된 사진이 없습니다.';
	  }
  if ('${hospital.hos_del}' === 'Y') {
	    document.querySelector('input[name="hos_del"]').value = '삭제대기중인 병원입니다.';
	  }
  
  if ('${hospital.hos_role}' === 'Y') {
    document.querySelector('input[name="hos_role"]').value = '승인 완료';
  }
  if ('${hospital.hos_role}' === 'N') {
	    document.querySelector('input[name="hos_role"]').value = '미승인';
	  }
</script>   
     
     
     <%-- 파일 추가 영역
     <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">파일</span>
        </div>
            <img src="img/" alt="${hospital.filename}" style="display: block">
        <input type="file" class="form-control innm" name="filename" <%//=sts%>>    
      </div>  
    <div class="input-group mb-3">
     <button  style="width: 100%; background-color: yellowgreen; color:white;">파일다운로드</button>    
    </div>--%> 
 
    <div id="footer">
	  	<button onclick="chkhospital('${hospital.hos_id}')"type="button" class="btn btn-primary">승인완료</button>
	  	<!-- 각 버튼의 id의 값은 js폴더에 js에 설정되어있음 -->
	</div>
	
</div>
<script>
function chkhospital(v){
	
	let con_test = confirm("병원을 승인하시겠습니까?");
		
	if(con_test == true){
		location.href = "checkHospital?hos_id="+v;
	}
	else if(con_test == false){
	  	return false;
	} 
		
}; 


</script>

</body>
</html>
