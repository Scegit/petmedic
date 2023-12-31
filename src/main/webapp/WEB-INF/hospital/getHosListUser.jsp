<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../../header.jsp"%>
<%@ include file="../../petmedic_navbar.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>병원목록</title>
<script>

//리뷰쓰기 이동
function revIns(val) {
	location.href = "getReserveForReview";
}
//예약내역으로 이동 
function getMyActionReserve(val) {
	location.href = "myActionReserve";
}
//찜병원으로 이동	
function getMyActionZzim(val) {
	location.href = "myActionZzim";
}



</script>
<script>
//       리뷰보이기 글자제한
      document.addEventListener("DOMContentLoaded", function () {
        var reviewElements = document.getElementsByClassName("review");
        for (var i = 0; i < reviewElements.length; i++) {
          var reviewText = reviewElements[i].textContent;
          if (reviewText.length > 100) {
            reviewElements[i].textContent = reviewText.substring(0, 100) + "...";
          }
        }
      });
//       리뷰목록 더보기
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("reviewContainer");
        var showMoreButton = document.getElementById("showMoreButton");

        showMoreButton.addEventListener("click", function () {
          console.log("더보기 실행");
          reviewContainer.classList.remove("d-none"); // Remove the "d-none" class to show the review container
          showMoreButton.classList.add("d-none"); // Add the "d-none" class to hide the "Show More" button
        });
      });

//       블러처리 해제
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("reviewContainer");
        var showMoreButton = document.getElementById("showMoreButton");

        var userid = '<%=session.getAttribute("users_id")%>';
        
        if(userid == null){
        	// Add the following code to check the user's login status
       		 var isLoggedIn = false; // Set this variable based on the user's login status
        } else {
        	var isLoggedIn = true;
        }
        
        if (isLoggedIn) {
          reviewContainer.style.filter = "none"; // Remove the blur effect
          reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
          showMoreButton.style.display = "none"; // Hide the "Show More" button
        }
      });
      
      function hosDetail(val){
	  		location.href = "/getHos?hos_id="+val;
	  }
      
      function listbtnhos(){
    	  location.href = "/ListHosUser";
      }
  
    </script>
<body>

	<div class="container structure">
		
		<div class="search-container-rev">
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
		</div>
		<c:set var="sti" value="0" />
		<div class="row" id="reviewContainer">
			<c:choose>
        <c:when test="${empty hospital}">
            <div class="col-md-12">
                해당되는 병원이 없습니다.
            </div>
        </c:when>
        <c:otherwise>
			<c:forEach items="${hospital}" var="hospital">
				<div class="col-md-6 mt-sm-4"
					onclick="hosDetail('${hospital.hos_id}')">
						
					<div class="revShadow review-box">
						<div class="user-info">
							<img src="${pageContext.request.contextPath}/img/${hospital.hos_pic}" alt="mdo"
								class="rounded-circle profilepic"
								onerror="this.src='${pageContext.request.contextPath}/img/dogdefault.png'" />
							<div class="profileupper" >
								<h6>${hospital.hos_name}</h6>
								<div><img id="reviewUpButton" style="border-radius: 10px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAThJREFUSEvVle01BEEQRe9GgAgQASJABIgAESACZEAEyGBFgAjIABkQAec61XNmes32ztneH1u/pj+qXterVzUjFmyjBcdnCMAq8ARsx6OegSPga9ojhwCMgYMs2AVwUwPAIGfAd2RwHutr4GpegBPgLoLsAG/AB7AOpHUvRoki+X4N71PgPjJw7xPYKIlkGoDOBrK4t4C0aImu9t5MGewFFfmrHoHDVoRET19Qz81WlXVk2ue4lknRGmwVqDHWZg7wE06Jtnxdojudd/zaNVgKAOtotzcKq52BMj4GmgasCaCc30PWFthCd1Q0bw1Sx78AUvVnNTNQ97vRA1JVFcDmlB6Hod/NCK+VgRP1EngApKqxNoCoK7N2U8+9/TQi/qPIwsidY3ioSY1DcOLfUBrXQ4Em7i8/wC/AX0YZwIqJ7wAAAABJRU5ErkJggg=="/>
								 ${hospital.hos_star}</div>
								<div class="star-rating" id="st-${sti = sti+1}">
									<script>
								       $(function(){generateStarRating(${sti}, ${hospital.hos_star});}) ;
								       </script>
								</div>
							</div>
							
						</div>
						<div class="review-details" style="font-size: 14px;">
							<div><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png"> ${hospital.hos_addr3}</div>
							<div>전문카테고리 - ${hospital.hos_cate}</div>
							<div>진료비 - ${hospital.hos_price}</div>
						</div>
						
					</div>
					
				</div>
				
			</c:forEach>
			</c:otherwise>
    </c:choose>
			<script>
								//이전별점
						          function generateStarRating(idx, starValue) {
						        	  	console.log('starValue', starValue);
						            for (var i = 1; i <= 5; i++) {
						            var starHtml = '';
						              starHtml += '<input type="radio" id="' + i + '-stars" name="rev_star" value="' + i + '"';
						             
						              if (i<= starValue) {
						            	  if(i== starValue) starHtml += ' checked';
							              starHtml += ' /><label for="' + i + '-stars" class="star starChk">&#9733;</label>';
						              }else{
							              starHtml += ' /><label for="' + i + '-stars" class="star">&#9733;</label>';
						              }
							         $("#st-"+idx).append(starHtml);
						            }
						          }
				 </script>
		</div>
		<button id="showMoreButton" class="revInsBtn">더보기</button>
	</div>
	<%@ include file="../../footer.jsp"%>	
</body>
</html>