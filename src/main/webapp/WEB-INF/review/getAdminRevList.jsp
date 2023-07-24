<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../../header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>마이페이지</title>

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

        // Add the following code to check the user's login status
        var isLoggedIn = true; // Set this variable based on the user's login status

        if (isLoggedIn) {
          reviewContainer.style.filter = "none"; // Remove the blur effect
          reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
          showMoreButton.style.display = "none"; // Hide the "Show More" button
        }
      });
      
      function revAdminDetail(val){
  		location.href = "getAdminReview?rev_hos_seq="+val;
  	}
    

    </script>
<body>

	<div class="container structure">
		<h3 class="text-center">리뷰목록</h3>
		<div class="search-container-rev">
			<div class="search-box">
				<form action="getAdminReviewDetails" method="post">
					<select class="search-select" id="searchCondition_rv"
						name="searchCondition">
						<option value="rev_name">제목</option>
						<option value="rev_star">별점</option>
						<option value="hos_name">병원명</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
						class="search-input-rev" />
					<button type="submit" class="search-button">
						<i class="fa fa-search"></i>
					</button>
				</form>
			</div>
		</div>
		<c:set var="sti" value="0" />
		<div class="row" id="reviewContainer">
		<c:choose>
        <c:when test="${empty reviewList}">
            <div class="col-md-12">
                해당되는 리뷰가 없습니다.
            </div>
        </c:when>
        <c:otherwise>
			<c:forEach items="${reviewList}" var="review">
				<div class="col-md-3 mt-sm-2 revShadow review-box">
					<div class="" onclick="revAdminDetail(${review.rev_hos_seq})">
								<h5>${review.rev_userid}</h5>
								<div>리뷰추천수:	${review.rev_up}</div>
								<div>별점: ${review.rev_star}</div>
							<div>제목: ${review.rev_title}</div>
							<div>병원명: ${review.hos_name}</div>
							<div>예약날짜: ${review.res_date} ${review.res_time}</div>
							
						</div>
						<hr>
						<div class="text-right">
							<button id="revDel" type="button" class="search-button">글삭제</button>
							</div>
					</div>
				
			</c:forEach>
			</c:otherwise>
    </c:choose>
		</div>
		<button id="showMoreButton" class="revInsBtn">더보기</button>
	</div>
</body>
</html>