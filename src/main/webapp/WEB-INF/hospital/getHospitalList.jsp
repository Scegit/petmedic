<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.spring.pet.commons.PageInfo"%>
<%@ include file="../admin_user/adminPage.jsp" %> 

<%-- <% 
  PageInfo hosvo = (PageInfo) request.getAttribute("paging");  
  int startNUM = hosvo.getStartNUM();  
  int endNUM = hosvo.getEndNUM();  
  int pageNUM = hosvo.getPageNUM(); 
  int totalPage = hosvo.getTotalPage(); 
  int pageListCount = hosvo.getPageListCount();  
%> --%>


<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/subin.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hospital.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css"> 
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
 
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/adminUser.js"></script>	
 	
<style>
.showhospital{
	color: #5D3891;
	text-align: center;
	font-weight: bold;
	padding-top: 20px;
	
}

.hospitaltable {
  background :#7b6ec5;
  text-align: center;   
}

.hospitaltable th:first-child{
  border-top-left-radius: 20px;
}
.hospitaltable th:last-child{
  border-top-right-radius: 20px;
}
#addbtn{
  background: #Fbbc04;
}

/* --페이징 버튼 css */
.paging_btn{
background-color:white;
outline: none;
border: none;
cursor:pointer;
width: 45px;
height: 45px;
margin:0 3px;
font-size: 0.9em;
border-radius: 50%;
}

button.select{
font-weight: bold;
border-radius: 50%;
background-color:#dff4f3;
}

button.pagingBefore,
button.pagingAfter{
/* border:none; */
/* cursor:pointer; */
/* font-size:0.9em; */
/* background-color:white; */
border:none;
outline:none;
background-color:transparent;
}

button.pagingBefore span,
button.pagingAfter span{
font-size:0.6em;
vertical-align:middle;
}

img.pagingBtnFAB{
width:120px;
}

img.pagingBtnFAB:hover {
cursor: pointer;
}
.hoslogo{
	width: 100%;
	text-align: center;
    margin: 0px;
	margin-top: 30px;
}

.tdCenter{
  text-align: center;
}
/* 반응형 */
@media(max-width:1199px){
.container-fluid.hoslist{
  padding-left: 150px;
 
 
 } 
.table.table-hover{
   width: 400px;
   
}      
.adminsidebar{
	overflow: auto;
	height: 100%;
 }
/* 사이드바 닫힌 상태 */
.sidebar-closehide {
	width: 70px;
	background: #5D3891;
	height: 100%;
	z-index: 9999; /* 다른 요소 위에 표시되도록 설정 */
	top: 0; /* 페이지 상단에 위치하도록 설정 */
	left: 0; /* 페이지 왼쪽에 위치하도록 설정 */
	bottom: 0;
	position: fixed; /*사이드바영역 위아래 끝으로*/
	float: left; 
	
}

/* 사이드바 열린 상태 */
.sidebar-closeshow {
	background: #5D3891;
	float: left;
	width: 220px;
	/* 사이드바를 고정 위치로 설정 */
	position: fixed;
	/* 페이지 상단에 위치하도록 설정 */
	top: 0;
	/* 페이지 왼쪽에 위치하도록 설정 */
	left: 0;
	/* 페이지 전체 높이만큼 설정 */
	height: 100%;
	/* 다른 요소 위에 표시되도록 설정 */
	z-index: 9999;	
   }
.hoslogo a img {
    width: 120px;
    margin-left: 70px;
  }   
.showhospital{
  font-size: 30px;
  text-align: center;
  width: 400px;
  height: 60px;
 }   

}

</style>


</head>
<body>


<script type="text/javascript">

</script>
    
<!--     <div class="hoslogo"> -->
<!--     <a href="index.jsp">  -->
<%-- 		<img style="width: 250px; margin-right: 200px;"src="${pageContext.request.contextPath}/img/PetMedicLogo_P.png"></a> --%>
<!--     </div> -->

<!-- 	<div class="jumbotron"> -->
<!-- 		<h1 class="showhospital">Pet Medic의 동물병원목록</h1> -->
<!-- 		<br> -->
<!-- 	</div> -->
	
	<!-- <nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<form class="form-inline" action="getHospitalList" method="post">
			<select class="form-control" id="sel1" name="searchCondition"
				style="display: inline-block !important; margin-right: 10px;">
				<option value="LOCAL">지역명</option>
				<option value="NAME">이름</option>
			</select> <input class="form-control mr-sm-2" type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요.">
			<button class="btn btn-success" type="submit">검색</button>
		</form>
	</nav> -->
	
 	   <%-- <% 
  		if (pageListCount > 0) { 
 		%>  --%>
 <script >
 
 function hosDetail(val){
 		location.href = "/getHospital?hos_id="+val;
 }
 
 function listbtnhos(){
	  location.href = "/getHospitalList";
 }
 
 
 
 
 </script>
	
	
	
	
	<div class="container-fluid hoslist">

		 <div class="hoslogo">
	    	<a href="index.jsp"> 
			<img style="width: 70px;"src="${pageContext.request.contextPath}/img/PetMedicLogo_P.png">
			</a>
	     </div>
	     
	     <!-- 검색기능 미흡 -->
	   <!--   	<div class="search-container-rev">
			<div class="search-box">
				<form action="getHosListUser" method="post">
					<select class="search-select" id="searchCondition"
						name="searchCondition" style="border: none;">
						<option value="hos_cate">카테고리</option>
						<option value="hos_star">별점</option>
						<option value="hos_addr">주소</option>
						<option value="hos_name">병원명</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
						class="search-input-rev" />
					<button type="submit" class="search-button">
						<i class="fa fa-search"></i>
					</button>
					
				</form>
				<button type="button" onclick="listbtnhos()" class="search-button">
						전체목록
					</button>
			</div>
		</div> -->
	
	
    
			<h3 class="showhospital">동물병원목록</h3>
			<br>		 
		<table class="table table-hover">
			<thead class="hospitaltable">
				<tr>				
					<th>아이디</th>
					<th>병원명</th>
<!-- 					<th>진료동물</th> -->
					<th>지역</th>
<!-- 					<th>평점</th> -->
					<th>승인/삭제</th>
				</tr>	
	       </thead>		

		       
			<tbody>
        
				<c:forEach items="${hospital}" var="hospital" varStatus="status">
					<tr onclick="movehospital('${hospital.hos_id}')" style="cursor:pointer;">
					    <td class="tdCenter" >${hospital.hos_id}</td>
						<td class="tdCenter" >${hospital.hos_name}</td>
 						<td class="tdCenter">${hospital.hos_addr2}</td>
					<%-- 	<td class="tdCenter">${hospital.hos_start== null?"": hospital.hos_start.substring(0,5)}
						~  ${hospital.hos_end== null?"": hospital.hos_end.substring(0,5)}</td> --%>
<%-- 						<td class="tdCenter">${hospital.hos_star}</td>
 --%>						<td class="tdCenter">${hospital.hos_role} / ${hospital.hos_del}</td>					
						<%-- c:forEach item에서 자료형이 list로 요구시 <td>태그사이에
						<a href="/hospital/hospital?hos_del=${hospital.hos_del }">${hospital.hos_del }</a> 넣으면 객체로 값을 가져올 수 있음 --%>
					</tr>
				</c:forEach>
				 
			</tbody>
		</table>
		<br>		
		
		
         <%--  <div class="container">
			<%
			if (pageNUM <= 1) {
			%>
			<button type="button" class="pagingBefore">&lt;&nbsp;이전</button>
			<%
			} else {
			%>
			<button type="button" class="pagingBefore" onClick="dateCheck(<%=pageNUM - 1%>)">&lt;&nbsp;이전</button>
			<%
			}
			%>
			<%
			for (int a = startNUM; a <= endNUM; a++) {
				if (a == pageNUM) {
			%>
			<button type="button" class="btn paging_btn select">
				<%=a%>
			</button>
			<%
			} else {
			%>
			<button class="btn paging_btn" onClick="dateCheck(<%=a%>)"><%=a%>
			</button>
			<%
			}
			%>
			<%
			}
			%>
			<%
			if (pageNUM == totalPage) {
			%>
			<button type="button" class="pagingAfter">다음&nbsp;&gt;</button>
			<%
			} else {
			%>
			<button type="button" class="pagingAfter" onClick="dateCheck(<%=pageNUM + 1%>)">다음&nbsp;&gt;
			</button>
			<%
			}
			%>
			<%
			} else {
			%>
			<div  id="adminNoneUser">
			<section>가입된 회원이 없습니다.</section>
			</div>
			<%
			}
			%>
		</div> --%>
		
 </div>
 
 
<script>
	  
//버튼 페이징
$("button.paging_btn").click(function() {
	$("button.paging_btn").removeClass("select");
	$(this).addClass("select");
});


$(document).ready(
		function() {
			$.datepicker.setDefaults($.datepicker.regional['ko']);
			$("#searchInsertDate1").datepicker(
					{
						
						changeMonth : true,
						changeYear : true,
						nextText : '다음 달',
						prevText : '이전 달',
						dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
								'금요일', '토요일' ],
						dayNamesMin : [ '일', '월', '화', '수', '목', '금',
								'토' ],
						monthNamesShort : [ '1월', '2월', '3월', '4월',
								'5월', '6월', '7월', '8월', '9월', '10월',
								'11월', '12월' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월',
								'6월', '7월', '8월', '9월', '10월', '11월',
								'12월' ],
						dateFormat : "yy-mm-dd",
						maxDate : 0, // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
						onClose : function(selectedDate) {
							//시작일(startDate) datepicker가 닫힐때
							//종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
							$("#searchInsertDate2").datepicker(
									"option", "minDate", selectedDate);
						}

					});
			$("#searchInsertDate2").datepicker(
					{
						changeMonth : true,
						changeYear : true,
						nextText : '다음 달',
						prevText : '이전 달',
						dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
								'금요일', '토요일' ],
						dayNamesMin : [ '일', '월', '화', '수', '목', '금',
								'토' ],
						monthNamesShort : [ '1월', '2월', '3월', '4월',
								'5월', '6월', '7월', '8월', '9월', '10월',
								'11월', '12월' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월',
								'6월', '7월', '8월', '9월', '10월', '11월',
								'12월' ],
						dateFormat : "yy-mm-dd",
						maxDate : 0, // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
						onClose : function(selectedDate) {
							// 종료일(endDate) datepicker가 닫힐때
							// 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
							$("#searchInsertDate1").datepicker(
									"option", "maxDate", selectedDate);
						}

					});
		});


</script>   
   
   
 <%@include file="../../footer.jsp" %>  
</body>
</html>
