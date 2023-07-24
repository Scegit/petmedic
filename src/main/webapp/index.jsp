<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>



<%
String roleError = request.getParameter("roleError"); // 권한 없을 때 뜨는 alert(※0512)
if (roleError != null) {
	out.println("<script>");
	out.println("if (window.history.replaceState) {");
	out.println("    window.history.replaceState(null, null, window.location.href.split('?')[0]);");
	out.println("} else {");
	out.println("    window.location.href = window.location.href.split('?')[0];");
	out.println("}");
	out.println("alert('권한이 없습니다.');");
	out.println("</script>");
}

%>

<!DOCTYPE html>
<html>

<head>

<script>
//공지사항 시작

//별점담아
	 var hosListStar=[];
//리뷰담아	 
	 var hosListRev=[];

$(document).ready(function() {
	// 메인페이지가 열리면 최신 공지사항 목록을 가져와라이거야 (작성일기준, 고정여부 상관XXX)
	$.ajax({
		method : "post",
		url : "/getNoticeList4Index",
		//data:
		cache : false,
		success : function(res) {
			console.log('인덱스페이지 공지사항 가져오기 성공');
			console.log('인덱스공지 가져온 리스트는?    ', res);

			displayNotice(res);
		},
		error : function(request, status) {
			console.log('인덱스페이지 공지사항 가져오기 에러');
		}

	});
	
	// 메인페이지가 열리면 베스트 병원 목록을 가져와라 이거야 (예약내역 많은 순으로 best3)
	   $.ajax({
	      method:"post",
	      url:"/getBestHospitals",
	      cache: false,
	      success : function(res){
	         console.log('베스트3 가져오기 성공');
	         console.log('베스트병원 3개의 리스트는? ', res);
	         
	         displayBest(res);
	      },
	      error: function(request, status){
	         console.log('베스트목록 에러');
	      }
	   });
	
	//별점순
	   $.ajax({
		      url: "revHighStar",
		      method: "POST",
		      data: hosListStar,
		      dataType: "json",
		      success: function(response) {
		        // Handle the response from the server
		        console.log("revstar");
		        console.log(response);
				
		        // You can perform any necessary actions here
		        // For example, update the UI to reflect the thumbs up status
				
		        highhosstar(response);
				 
			        
		      },
		      error: function(xhr, status, error) {
		        // Handle errors
		        console.error(error);
		      }
		    });	   
	  //리뷰순 
	   $.ajax({
		      url: "getManyRevHos",
		      method: "POST",
		      data: hosListRev,
		      dataType: "json",
		      success: function(reviews) {
		        // Handle the response from the server
		        console.log("getManyRevHos");
		        console.log(reviews);
				
		        // You can perform any necessary actions here
		        // For example, update the UI to reflect the thumbs up status
				
		        manyGetRevHos(reviews);
				 
			        
		      },
		      error: function(xhr, status, error) {
		        // Handle errors
		        console.error(error);
		      }
		    });	   
	
});



//베스트병원 가져와서 메인에 출력해주기
function displayBest(res){
console.log('디스플레이 베스트', res);

var bestHosHtml = "";

if (res != null ){
   for (i = 0; i < res.length; i++ ){
      console.log(i+1, '번째 베스트 아이디는 ', res[i].res_hos_id,'이름은 ', res[i].besthosname);
      console.log('res.length',res.length);
      
      bestHosHtml += "<li class=\"main_hospital_container\"><span class=\"main_hospital_date\">"
         + "<strong class=\"h_ranking\">"+ (i+1) +"</strong></span><a class=\"notice_a\" href=\"/getHos?hos_id="
         + res[i].res_hos_id
         + "\"> "
         + res[i].hos_name +"</a></li>" 
   }
}

$('ul.maincontentsBestThree').html(bestHosHtml);
}

// 공지사항 가져와서 메인에 출력해주기
function displayNotice(res) {
	console.log('displayNotice? 2222    ', res);

	var indexNotHtml = "";

	if (res != null) {
		for (i = 0; i < 3; i++) {
			var displayDateNot = moment(res[i].notice_date).format(
					'YYYY-MM-DD');
			var dateNotday = displayDateNot.substr(8); // 날짜부분만 잘라서 가져오기
			var dateNotYM = displayDateNot.substr(0, 7); // 날짜부분만 잘라서 가져오기
			var indexNotTitle = res[i].notice_title;

			console.log("제목을 출력해줘요11", indexNotTitle);
			console.log("날짜만 출력해줘요11", dateNotday);
			console.log("연월만 출력해줘요11", dateNotYM);

			indexNotHtml += "<li class=\"main_notice_container\"> <span class=\"main_notice_date\"><span class=\"day_span\">"
					+ dateNotday
					+ "</span> <em class=\"emm\">"
					+ dateNotYM
					+ "</em></span> "
					+ "<a class=\"notice_a\" href=\"/getNoticeDetail?notice_int="
					+ res[0].notice_int
					+ "\"> "
					+ indexNotTitle
					+ "</a></li><br>"
		}
	}

	$('ul.maincontentsNotice').html(indexNotHtml);
}


//공지사항 메인 끝


</script>
<script>
/*리뷰이벤트, 병원등록 서서히 나타내기*/
function fadeInOnScroll() {
	var element = document.querySelector('.rh_img');
	var elementPosition = element.getBoundingClientRect().top;
	var screenPosition = window.innerHeight;

	if (elementPosition < screenPosition) {
		element.classList.add('show');
	}
}

window.addEventListener('scroll', fadeInOnScroll);

window.addEventListener("scroll", function() {
	var topButton = document.getElementById("topButton");
	if (window.pageYOffset > 300) {
		topButton.style.display = "block";
	} else {
		topButton.style.display = "none";
	}
});

function scrollToTop() {
	window.scrollTo({
		top : 0,
		behavior : "smooth"
	});
}
	
	
	   function getHosListCate(val){
		   if(val == '강아지') {
			   location.href = "getHosListUser?searchCondition="+val;
		   } else if(val == '고양이') {
			   location.href = "getHosListUser?searchCondition="+val;
		   } else if(val == '새') {
			   location.href = "getHosListUser?searchCondition="+val;
		   } else if(val == '파충류') {
			   location.href = "getHosListUser?searchCondition="+val;
		   } else if(val == '기타동물') {
			   location.href = "getHosListUser?searchCondition="+val; 
		   } else if (val == '전체동물') {
				location.href = "getHosListUser?searchCondition=" +val;
			}
   	}


	   
	   $(document).ready(function(){
		   
		 
		   });
	
	 //별점순
	   function highhosstar(response){
	   console.log(response);

	   var highstarhos1 = "";
	   var highstarhos2 = "";
	   var highstarhos3 = "";

	   if (response != null ){
	      
	         console.log(response[0].hos_name);
	         console.log(response[1].hos_name);
	         console.log(response[2].hos_name);
	         
	         highstarhos1 +=  "<div class=\"search-container-rev\"><div class=\"search-box\ onclick=location.href=\"/getHos?hos_id="+response[0].hos_id+"\"> "
	         +"<img style=\"width: 100px; height: 100px;\" src=\"${pageContext.request.contextPath}/img/"+response[0].hos_pic+" alt=\"mdo\"class=\"hospicpro\"onerror=\"this.src=\'${pageContext.request.contextPath}/img/dogdefault.png\'\" /><br>"
	         + "<b>" + response[0].hos_name + "</b>"
	         + "<br>"
	         + response[0].hos_addr2
	         +"</div></div>"
	         highstarhos2 +=  "<div class=\"search-container-rev\"><div class=\"search-box\ onclick=location.href=\"/getHos?hos_id="+response[1].hos_id+"\"> "
	        	  +"<img style=\"width: 100px; height: 100px;\" src=\"${pageContext.request.contextPath}/img/"+response[1].hos_pic+" alt=\"mdo\"class=\"hospicpro\"onerror=\"this.src=\'${pageContext.request.contextPath}/img/dogdefault.png\'\" /><br>"
	 	         + "<b>" + response[1].hos_name + "</b>"
	 	         + "<br>"
	 	         + response[1].hos_addr2
	 	         +"</div></div>"
	         highstarhos3 +=  "<div class=\"search-container-rev\"><div class=\"search-box\ onclick=location.href=\"/getHos?hos_id="+response[2].hos_id+"\"> "
	        	  +"<img style=\"width: 100px; height: 100px;\" src=\"${pageContext.request.contextPath}/img/"+response[2].hos_pic+" alt=\"mdo\"class=\"hospicpro\"onerror=\"this.src=\'${pageContext.request.contextPath}/img/dogdefault.png\'\" /><br>"
	 	         + "<b>" + response[2].hos_name + "</b>"
	 	         + "<br>"
	 	         + response[2].hos_addr2
	 	         +"</div></div>"
	      
	   }

	   $('button#main_hp_star_btn1').html(highstarhos1);
	   $('button#main_hp_star_btn2').html(highstarhos2);
	   $('button#main_hp_star_btn3').html(highstarhos3);
	   }
	 
	 //리뷰순
	   function manyGetRevHos(reviews){
	   console.log(reviews);

	   var revManyHos1 = "";
	   var revManyHos2 = "";
	   var revManyHos3 = "";

	   if (reviews != null ){
	      
	         console.log(reviews[0].hos_name);
	         console.log(reviews[1].hos_name);
	         console.log(reviews[2].hos_name);
	         
	         revManyHos1 +=  "<div class=\"search-container-rev\"><div class=\"search-box\" onclick=location.href=\"/getHos?hos_id="+reviews[0].hos_id+"\"> "
	         +"<img style=\"width: 100px; height: 100px;\" src=\"${pageContext.request.contextPath}/img/"+reviews[0].hos_pic+" alt=\"mdo\"class=\"hospicpro\"onerror=\"this.src=\'${pageContext.request.contextPath}/img/dogdefault.png\'\" /><br>"
	         + "<b>" + reviews[0].hos_name + "</b>"
	         + "<br>"
	         + reviews[0].hos_addr2
	         +"</div></div>"
	         revManyHos2 +=  "<div class=\"search-container-rev\"><div class=\"search-box\" onclick=location.href=\"/getHos?hos_id="+reviews[1].hos_id+"\"> "
	        	  +"<img style=\"width: 100px; height: 100px;\" src=\"${pageContext.request.contextPath}/img/"+reviews[1].hos_pic+" alt=\"mdo\"class=\"hospicpro\"onerror=\"this.src=\'${pageContext.request.contextPath}/img/dogdefault.png\'\" /><br>"
	 	         + "<b>" + reviews[1].hos_name + "</b>"
	 	         + "<br>"
	 	         + reviews[1].hos_addr2
	 	         +"</div></div>"
	 	        revManyHos3 +=  "<div class=\"search-container-rev\"><div class=\"search-box\ onclick=location.href=\"/getHos?hos_id="+reviews[2].hos_id+"\"> "
	        	  +"<img style=\"width: 100px; height: 100px;\" src=\"${pageContext.request.contextPath}/img/"+reviews[2].hos_pic+" alt=\"mdo\"class=\"hospicpro\"onerror=\"this.src=\'${pageContext.request.contextPath}/img/dogdefault.png\'\" /><br>"
	 	         + "<b>" + reviews[2].hos_name + "</b>"
	 	         + "<br>"
	 	         + reviews[2].hos_addr2
	 	         +"</div></div>"
	        	 
	        
	      
	   }

	   $('button#main_hp_review_btn1').html(revManyHos1);
	   $('button#main_hp_review_btn2').html(revManyHos2);
	   $('button#main_hp_review_btn3').html(revManyHos3);
	   }
	   
	   
	   function hosDetail(val){
			location.href = "getReview?rev_hos_seq="+val;
		}
 
	   
</script>
<meta charset="UTF-8">
<title>PetMedic Main</title>
</head>
<body>
	<%@ include file="petmedic_navbar.jsp"%>
	<button id="topButton" onclick="scrollToTop()">
		<b>Top</b>
	</button>
	<div class="mainimg_Div">
		<img id="mainimg"
			src="${pageContext.request.contextPath}/img/큩아기고앵이.png">
		<div class="maincontainer">
			<div id="catsearchDiv">
				<form id="catsearch" action="getHosListUser" method="post">
					<div id="catsearch-container">
						<select class="search-select" id="searchCondition_rv"
							name="searchCondition" style="border: none;">
							<option value="hos_cate">카테고리</option>
							<option value="hos_star">별점</option>
							<option value="hos_addr">주소</option>
							<option value="hos_name">병원명</option>
						</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
							id="catsearchbox"/>
						<button id="catsearchbtn" type="submit" >
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVFJREFUSEvVleExBEEQRt9FQAoiQATIgAgQASJABIgAESACZEAEyIAIqKd6qub2Zmen7N4P/eu2dqdf99dfz81YcsyWnJ8+wCpwBOwCG1HEC3APXAGfrYWVAAfABSCkFCY/AW5aIF2Aya/j4ANwCTzF8zZwBmzF8150VOXkACt+i8oPKxUKOQ2Z1obkygHpoJWrfS3syk7Oo6veb3OAQ1wHdjJZ+g4q1yPgmc1aJTngOz5stW7T92MBXxW3/db7V4mc0R3wDChX0wzSkF0mLdgyZPdBKzcBtOk7sBLO0CGlSIV8xJZXt7o70NS6ibWiyZTBUAr9nyQZtGh3Bqlat9m27aQUDtb3wrSpv2/7NKpddsexcO6G8RpXgwmVJe2N77yX3P6FaPV86Wx+b/VCxgBS0v2MvtDJWMAgZApAFzJ3E08FSBCtPfdHNCWg6NT/D/gBeOVFGZeTouUAAAAASUVORK5CYII=" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

<div class="container">
		<h3 class="main_hp_tit">
			병원 랭킹<img id="main_hpking_tit"
				src="${pageContext.request.contextPath}/img/메인아이콘왕관.png">
		</h3>
		<div class="main_hp_rs row">
			<div class="col-md-5 col-sm-12">
				<h5 class="main_hp_review_h5">
					리뷰순<img id="main_hp_review_icon"
						src="${pageContext.request.contextPath}/img/메인아이콘리뷰.png">
				</h5>
				<div class="main_hp_review">
					<div id="carouselExampleControls1" class="carousel slide"
						data-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<button id="main_hp_review_btn1" type="button"
									></button>
							</div>
							<div class="carousel-item">
								<button id="main_hp_review_btn2" type="button"
									></button>
							</div>
							<div class="carousel-item">
								<button id="main_hp_review_btn3" type="button"
									></button>
							</div>
						</div>

						<!-- Left and right controls -->
						<a class="carousel-control-prev" href="#carouselExampleControls1"
							data-slide="prev"> <span class="carousel-control-prev-icon"></span>
						</a> <a class="carousel-control-next" href="#carouselExampleControls1"
							data-slide="next"> <span class="carousel-control-next-icon"></span>
						</a>
					</div>

				</div>
			</div>

			<div class="col-md-2"></div>

			<div class="col-md-5 col-sm-12">
				<h5 class="main_hp_star_h5">
					별점순<img id="main_hp_star_icon"
						src="${pageContext.request.contextPath}/img/메인아이콘별.png">
				</h5>
				<div class="main_hp_star">
					<div id="carouselExampleControls2" class="carousel slide"
						data-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<button id="main_hp_star_btn1" type="button" >
								</button>

							</div>
							<div class="carousel-item">
								<button id="main_hp_star_btn2" type="button" >
								</button>

							</div>
							<div class="carousel-item">
								<button id="main_hp_star_btn3" type="button" >
								</button>

							</div>
						</div>

						<!-- Left and right controls -->
						<a class="carousel-control-prev" href="#carouselExampleControls2"
							data-slide="prev"> <span class="carousel-control-prev-icon"></span>
						</a> <a class="carousel-control-next" href="#carouselExampleControls2"
							data-slide="next"> <span class="carousel-control-next-icon"></span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container" id="main_animal_container1"
		style="overflow-x: hidden;">
		<h3 class="main_am_tit">
			동물병원찾기<img id="main_amhp_tit"
				src="${pageContext.request.contextPath}/img/메인아이콘동물.png">
		</h3>
		<div class="row">
			<div class="col-md-2 col-sm-4" id="main_animal_container2">
				<div class="main_ambtn_img">
					<button id="main_ambtn_dogcat" type="button" class="search-select"
						id="searchCondition" name="searchCondition"
						onclick="getHosListCate('강아지')">
						<img id="main_ambtn_dog2"
							src="${pageContext.request.contextPath}/img/개3d.png">
					</button>
				</div>
			</div>
			<div class="col-md-2 col-sm-4">
				<div class="main_ambtn_img">
					<button id="main_ambtn_dogcat" type="button" class="search-select"
						id="searchCondition" name="searchCondition"
						onclick="getHosListCate('고양이')">
						<img id="main_ambtn_cat2"
							src="${pageContext.request.contextPath}/img/고양이3d.png">
					</button>
				</div>
			</div>
			<div class="col-md-2 col-sm-4">
				<div class="main_ambtn_img">
					<button id="main_ambtn_bird" type="button" class="search-select"
						id="searchCondition" name="searchCondition"
						onclick="getHosListCate('새')">
						<img id="main_ambtn_bird2" onclick="getHosListCate('새')"
							src="${pageContext.request.contextPath}/img/앵무새3d.png">
					</button>
				</div>
			</div>
			<div class="col-md-2 col-sm-4">
				<div class="main_ambtn_img">
					<button id="main_ambtn_reptile" type="button" class="search-select"
						id="searchCondition" name="searchCondition"
						onclick="getHosListCate('파충류')">
						<img id="main_ambtn_reptile2" onclick="getHosListCate('파충류')"
							src="${pageContext.request.contextPath}/img/카멜레온3d.png">
					</button>
				</div>
			</div>
			<div class="col-md-2 col-sm-4">
				<div class="main_ambtn_img">
					<button id="main_ambtn_etc" type="button" class="search-select"
						id="searchCondition" name="searchCondition"
						onclick="getHosListCate('기타동물')">
						<img id="main_ambtn_etc2" onclick="getHosListCate('기타동물')"
							src="${pageContext.request.contextPath}/img/풀밭etc(소).png">
					</button>
				</div>
			</div>
			<div class="col-md-2 col-sm-4">
				<div class="main_ambtn_img">
					<button id="main_ambtn_all" type="button" class="search-select"
						id="searchCondition" name="searchCondition"
						onclick="getHosListCate('전체동물')">
						<img id="main_ambtn_all2" onclick="getHosListCate('전체동물')"
							src="${pageContext.request.contextPath}/img/전체동물3d.png">
					</button>
				</div>
			</div>
		</div>
	</div>


	

<!-- 	<div class="container-fluid"> -->
<!-- 		<div class="container"> -->
<!-- 			<h3 class="main_am_tit">어떤 병원을 찾으시나요?</h3> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-md-4 col-sm-4"> -->
<!-- 					<div class="main_where_hp1"> -->
<!-- 						<button id="main_where_hp_btn1" type="button" -->
<!-- 							onclick="location.href='#'"> -->
<!-- 							<img id="main_where_hp_img1" -->
<%-- 								src="${pageContext.request.contextPath}/img/메인아이콘위치.png">주변병원 --%>
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-4 col-sm-4"> -->
<!-- 					<div class="main_where_hp1"> -->
<!-- 						<button id="main_where_hp_btn2" type="button" -->
<!-- 							onclick="location.href='#'"> -->
<!-- 							<img id="main_where_hp_img2" -->
<%-- 								src="${pageContext.request.contextPath}/img/메인아이콘달.png">야간진료 --%>
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-4 col-sm-4"> -->
<!-- 					<div class="main_where_hp1"> -->
<!-- 						<button id="main_where_hp_btn3" type="button" -->
<!-- 							onclick="location.href='#'"> -->
<!-- 							<img id="main_where_hp_img3" -->
<%-- 								src="${pageContext.request.contextPath}/img/메인아이콘일요일.png">일요일진료 --%>
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->

<!-- 		<div class="container"> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-md-4 col-sm-4"> -->
<!-- 					<div class="main_where_hp1"> -->
<!-- 						<button id="main_where_hp_btn4" type="button" -->
<!-- 							onclick="location.href='#'"> -->
<!-- 							<img id="main_where_hp_img4" -->
<%-- 								src="${pageContext.request.contextPath}/img/메인아이콘비대면.png">비대면진료 --%>
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-4 col-sm-4"> -->
<!-- 					<div class="main_where_hp1"> -->
<!-- 						<button id="main_where_hp_btn5" type="button" -->
<!-- 							onclick="location.href='#'"> -->
<!-- 							<img id="main_where_hp_img5" -->
<%-- 								src="${pageContext.request.contextPath}/img/메인아이콘타이머.png">빠른예약 --%>
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-4 col-sm-4"> -->
<!-- 					<div class="main_where_hp1"> -->
<!-- 						<button id="main_where_hp_btn6" type="button" -->
<!-- 							onclick="location.href='#'"> -->
<!-- 							<img id="main_where_hp_img6" -->
<%-- 								src="${pageContext.request.contextPath}/img/메인아이콘따봉.png">추천병원 --%>
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->


	<div class="container rh_img">
		<div class="row">
			<div class="col-md-5 col-sm-12">
				<div class="main_reserve_Div">
					<img id="main_reserve_img"
						src="${pageContext.request.contextPath}/img/펫메딕리뷰등록메인.png">
					<button id="main_reserve_btn" type="button"
						onclick="location.href = '/getReserveForReview'">리뷰 등록하기</button>
				</div>
			</div>

			<div class="col-md-2 col-sm-12"></div>

			<div class="col-md-5 col-sm-12">
				<div class="main_hospitaluser_Div">
					<img id="main_hospitaluser_img"
						src="${pageContext.request.contextPath}/img/펫메딕병원등록메인.png">
					<button id="main_hospitaluser_btn" type="button"
						onclick="location.href='/insertHospital'">병원 등록하기</button>
				</div>
			</div>
		</div>
	</div>



	<div class="container-fluid" id="main_Allcontainer">
		<h2 class="section_tit">
			<i>자주찾는</i> 메뉴
		</h2>
		<div class="container">
			<div id="contents1page" class="row">
				<div class="main_contentsDiv col-md-5">
					<div class="main_notice_more">
						<h4 class="main_notice_h4">공지 사항</h4>
						<a id="notice_plus" href="/toGetNoticeList">+</a>
					</div>
					<ul class="main_contents maincontentsNotice">
						<!--                   <li class="main_notice_container"> -->
						<!--                   <span class="main_notice_date"> <span class="day_span">19</span><em -->
						<!--                         class="emm">2023-05</em> -->
						<!--                   </span> <a class="notice_a" href="#"> 2023 05| 발표일[파이널프로젝트]힘냅시다. </a></li> -->
						<!--                   <br> -->
						<!--                   <li class="main_notice_container"><span -->
						<!--                      class="main_notice_date"> <span class="day_span">18</span><em -->
						<!--                         class="emm">2023-05</em> -->
						<!--                   </span> <a class="notice_a" href="#"> 2023 05| 발표일[파이널프로젝트]힘냅시다. </a></li> -->
						<!--                   <br> -->
						<!--                   <li class="main_notice_container"><span -->
						<!--                      class="main_notice_date"> <span class="day_span">17</span><em -->
						<!--                         class="emm">2023-05</em> -->
						<!--                   </span> <a class="notice_a" href="#"> 2023 05| 발표일[파이널프로젝트]힘냅시다. </a></li> -->
						<!--                   <br> -->
					</ul>
				</div>
				<div class="col-md-2"></div>

				<div class="main_contentsDiv col-md-5">
					<div class="main_hospital_more">
						<h4 class="main_notice_h4">BEST 병원</h4>
						<a id="hospital_plus" href="#">+</a>
					</div>
					
					<ul class="main_contents maincontentsBestThree">
               </ul>
				</div>
			</div>
		</div>
	</div>


	<%@ include file="footer.jsp"%>
</body>
</html>