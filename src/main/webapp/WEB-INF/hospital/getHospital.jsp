<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../admin_user/adminPage.jsp" %> 



  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hospital.css">
 
<script>
function updateHospital(val){
	location.href="/updatePageHospital?hos_id="+val;
}

</script>
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

html{
 width: 100%;
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

</style>

<body class="inserthos">

<div class="container-fluid" id="hosadd">

  <div class="row">
		<a href="index.jsp"> 
		<img style="width: 160px; align-items: center;"src="${pageContext.request.contextPath}/img/PetMedicLogo_P.png"></a>
	     
			<h3 class="hname">병원 정보</h3>
		</div>
  <form name="fm" action="/getHospital" method="post">
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
      <input type="button" class="form-control innm" name="hos_url" value="${hospital.hos_url}" onclick="location.href='https://${hospital.hos_url}'" readonly<%//=sts%>> 
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
     <span class="input-group-text">인증여부</span> 
         </div></div>  
         <div class="col">       
        <input type="text" class="form-control innm" name="hos_role"  value="${hospital.hos_role}" placeholder="승인된 병원입니다." readonly>   
      </div></div>
     <h3 class=hend></h3>
    </div> 
     
   </div>
   
   </form>  


<script>
if ('${hospital.hos_s_lunch}' === '') {
    document.querySelector('input[name="hos_s_lunch"]').value = '없음';
  }
if ('${hospital.hos_e_lunch}' === '') {
    document.querySelector('input[name="hos_e_lunch"]').value = '없음';
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
  if ('${hospital.hos_del}' === 'N') {
	    document.querySelector('input[name="hos_del"]').value = '운영중인 병원입니다.';
	  }
  
  if ('${hospital.hos_role}' === 'Y') {
    document.querySelector('input[name="hos_role"]').value = '승인 완료';
  }
  if ('${hospital.hos_role}' === 'N') {
	    document.querySelector('input[name="hos_role"]').value = '미승인';
	  }
</script>


     
     
     
     
 
    <div id="footer">
	  	<button onclick="updateHospital('${hospital.hos_id}')" type="button" class="btn btn-primary"  <%//=sts %>>수정페이지이동</button>
	  	<button id="delwaithospital" type="button" class="btn btn-primary" <%//=sts%>>병원정보임시삭제</button>
	  	<button id="hospitalList" type="button" class="btn btn-primary">병원목록</button>
	  	<!-- 각 버튼의 id의 값은 js폴더에 js에 설정되어있음 -->
	</div>
	



</body>
</html>
